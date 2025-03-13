provider "aws" {
    alias = "east"
    region = "us-east-2"  
}

provider "aws" {
    alias = "west"
    region = "us-west-1"  
}

variable "instance_type" {
  description = "Instance type for EC`2"
  type        = string
  default     = "t2.micro"
}

resource "aws_instance" "my_ec2_east" {
  ami           = "ami-0d0f28110d16ee7d6"
  provider =  aws.east
  instance_type = var.instance_type 
  security_groups = [aws_security_group.web_sg_east2.name]
}

resource "aws_instance" "my_ec2_west" {
  ami           = "ami-01eb4eefd88522422"
  provider =  aws.west
  instance_type = var.instance_type 
  security_groups = [aws_security_group.web_sg_west_1.name]
}

output "instance_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.my_ec2_east.public_ip
 # value       = aws_instance.my_ec2_west.public_ip
}
resource "aws_security_group" "web_sg_east2" {
  provider    = aws.east
  name        = "web_sg_east2"
  description = "Allow SSH & HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebSecurityGroup-Easts"
  }
}

resource "aws_security_group" "web_sg_west_1" {
    provider    = aws.west
    name        = "web_sg_west_1"
  description = "Allow SSH & HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebSecurityGroup-Easts"
  }
}
