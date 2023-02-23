# Infrastructure Template with Jenkins and Docker on AWS

This template provides an infrastructure setup with a Jenkins server and Docker installed. It is created using Terraform and deploys to an AWS VPC and subnet.

## Prerequisites

Before using this template, you must have the following:

- An AWS account
- AWS CLI installed and configured
- Terraform CLI installed

## Installation

### AWS CLI Setup

1. Ensure you have an AWS account.
2. Install the AWS CLI by following the instructions provided [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).
3. Configure the AWS CLI by following the instructions provided [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

### Terraform CLI Setup

1. Install the Terraform CLI by following the instructions provided [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).
2. Clone this repository to your local machine.

### Generate SSH Key

1. Open your terminal and navigate to the cloned repository.
2. Run the following command: `ssh-keygen -f aws-key`
3. Press enter for all options to accept the default values.

### Terraform Apply

1. Navigate to the cloned repository in your terminal.
2. Run the following command: `terraform apply`
3. Follow the steps and enter the variables and type "yes" when prompted to confirm the changes.

## Accessing Jenkins

After the installation is complete there will be something like this in your terminal:
```bash
    aws_instance.jenkins_server (remote-exec): Jenkins installed
    aws_instance.jenkins_server (remote-exec): Admin password: 
    herethepassword
```

jenkins_url: here is the url, you access the url, insert the password that appeared just above and you can enjoy your jenkins
