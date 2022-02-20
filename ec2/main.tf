
resource "aws_key_pair" "deployer-appgate" {
  key_name   = "deployer-appgate"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYuqRSIWQBrpyNCBCrBRLsFb/e7/CMdLaHf23b6rjptt6Iqr32a5I2JVAaajct81gNnkmHxdq9fCX13bwDU1VWtzr3aw19xfNgz/XfCJxH+JVzKs1Py6eICKOtUWrVRyKVWjVka5qpDgFl1NAJZH5lTxILvxGPM4C25ytB87qJdKbSje1474NX8Hl80rgFUG3P6nnT6VlxqcD+CwnDJFtYcT9rEu37Ml0IUG847pNB9O6wSB0Xc7ZxFMximDh7o0A8yjWC5mYuqPGvT/0QjHXSmrnHPwyLqivUrzvhrAUX7uPnZTFzAYae9dWE9yPKVbI5cWoWYt/umm1biRA+9vwL alexander.mazabael@CO-IT020528"
}


resource "aws_security_group" "alb-securitygroup" {
 name = "alb-security-group"
 tags = {

     Name = "Alb-security-group-appgate"

 }

ingress  {
        cidr_blocks =  ["0.0.0.0/0"]
        from_port = 80
        protocol =  "tcp"
        to_port = 80
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    
      } 

      vpc_id = var.vpc_id

}



resource "aws_security_group" "sg-instance"  {
    name = "terraform-tcp-security-group"

    ingress  {
        cidr_blocks =  ["0.0.0.0/0"]
        from_port = 80
        protocol =  "tcp"
        to_port = 80
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = [ aws_security_group.alb-securitygroup.id ]
        self = false


      } 

      vpc_id = var.vpc_id

    egress   {
        cidr_blocks =  ["0.0.0.0/0"]
        from_port = 0
        protocol =  "-1"
        to_port = 0
    }
}


resource "aws_ebs_volume" "instance-volume-1" {
  availability_zone = "us-east-2a"
  size              = 10
  type              = "gp2" 
  tags = {
    Name = "disk-1"
  }
}

resource "aws_ebs_volume" "instance-volume-2" {
  availability_zone = "us-east-2a"
  size              = 10
  type              = "gp2" 
  tags = {
    Name = "disk-2"
  }
}

resource "aws_ebs_volume" "instance-volume-3" {
  availability_zone = "us-east-2c"
  size              = 10
  type              = "gp2" 
  tags = {
    Name = "disk-3"
  }
}

resource "aws_ebs_volume" "instance-volume-4" {
  availability_zone = "us-east-2c"
  size              = 10
  type              = "gp2" 
  tags = {
    Name = "disk-4"
  }
}




resource "aws_volume_attachment" "ebs-1"{
device_name = "/dev/sdh"
volume_id   = aws_ebs_volume.instance-volume-1.id
instance_id = aws_instance.web-page.id 

}

resource "aws_volume_attachment" "ebs-2"{

device_name = "/dev/sdf"
volume_id   = aws_ebs_volume.instance-volume-2.id
instance_id = aws_instance.web-page.id 

}


resource "aws_volume_attachment" "ebs-3"{
device_name = "/dev/sdh"
volume_id   = aws_ebs_volume.instance-volume-3.id
instance_id = aws_instance.web-server.id 

}

resource "aws_volume_attachment" "ebs-4"{


device_name = "/dev/sdf"
volume_id   = aws_ebs_volume.instance-volume-4.id
instance_id = aws_instance.web-server.id 

}




resource "aws_instance" "web-server" {
  ami             = var.ami # Amazon Linux 2 AMI(HVM 64-bitx86)
  instance_type   = "t3.micro"
  subnet_id       =  var.vpc_pri_subnets[0]
  key_name        =  aws_key_pair.deployer-appgate.key_name
  security_groups = [aws_security_group.sg-instance.id]
   tags = {
    Name = "appgate-instance-web-server"
  }
  user_data                = <<EOF
 #!/bin/bash 
 sudo apt update
 sudo apt upgrade -y
 docker pull httpd:latest
 docker run -d httpd

 EOF

 

}

#“/appgate/testpage”

resource "aws_instance" "web-page" {
  ami             = var.ami # Amazon Linux 2 AMI(HVM 64-bitx86)
  instance_type   = "t3.micro"
  subnet_id       =  var.vpc_pri_subnets[1]
  key_name        =  aws_key_pair.deployer-appgate.key_name

  tags = {
    Name = "appgate-instance-webpage"
  }
 user_data                = <<EOF
 #!/bin/bash 
 sudo apt update
 sudo apt upgrade -y
 docker pull httpd:latest
 docker run -d httpd

 EOF


}

resource "aws_alb_listener" "appgate-alb" {

    
  
}





