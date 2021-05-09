provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  required_providers {
    aws = "~>3.10.0"
  }
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count =  "${length(var.name)}"
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  user_data = <<-EOF
              #!/bin/bash
              echo "xin chao moi nguoi,toi la huy" > index.html
              nohup busybox httpd -f -p "80" &
              EOF
  vpc_security_group_ids = ["${aws_security_group.web_server.id}"]
  

  tags = {
    Name = "${element(var.name,count.index)}"
  }
}
resource "aws_vpc" "example" {
  cidr_block       = "10.0.0.0/16"
}
resource "aws_security_group" "web_server" {
  
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.example.cidr_block]

  security_group_id = "${aws_security_group.web_server.id}"
}
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.example.cidr_block]
 
   security_group_id = "${aws_security_group.web_server.id}"
}
resource "aws_security_group_rule" "example" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = [aws_vpc.example.cidr_block]

   security_group_id = "${aws_security_group.web_server.id}"
}
