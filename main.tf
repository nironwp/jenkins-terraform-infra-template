terraform {

  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }
}

provider "aws" {
  region = var.default_resources_region

  default_tags {
    tags = {
      owner      = var.default_owner_tag
      managed-by = "terraform"
    }
  }
}


resource "aws_default_vpc" "main" {

  tags = {
    "Name" = "Main VPC"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" = "default subnet for ${data.aws_availability_zones.available.names[0]}"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow 8080 & 22 & 443 inbound traffic"
  vpc_id      = aws_default_vpc.main.id
  ingress {
    description = "TLS from vpc"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from vpc"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "allow_tls"
  }
}


resource "aws_key_pair" "aws_key_pair" {
  key_name   = "aws_key_pair"
  public_key = file("./aws-key.pub")
}

resource "aws_instance" "jenkins_server" {
  ami                         = var.jenkins_ami
  instance_type               = var.jenkins_instance_type
  subnet_id                   = aws_default_subnet.default_az1.id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  key_name                    = aws_key_pair.aws_key_pair.key_name
  associate_public_ip_address = true
  tags = {
    "Name" = "jenkins_server"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ip.txt"
  }


  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./aws-key")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./scripts/install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
  }



  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install_jenkins.sh",
      "sudo sh /tmp/install_jenkins.sh",
    ]
  }


}
