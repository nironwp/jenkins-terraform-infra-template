variable "default_owner_tag" {
  type        = string
  description = "The owner tag default in every resource"
}

variable "default_resources_region" {
  type        = string
  description = "The location where the resources were available, run in terminal `aws ec2 describe-regions`, describing the regions to see their regions available"
}

variable "jenkins_ami" {
  description = "AMI from Jenkins Instance,"
  type        = string
}

variable "jenkins_instance_type" {
  description = "Jenkins Instance type, to developing is recommended t2.micro"
  type        = string
}

