provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

#data "tfe_outputs" "source_workspace" {
#  workspace    = var.workspace_name
#  organization = var.organization_name
#}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = ["sg-997301bd"]
  subnet_id              = "subnet-5f7ed72"

  tags = {
    Name = var.instance_name
  }
}
