#### VARIABLES MODULO VPC ##################3

variable "vpc_cidr" {
  type    = string
  default = "10.1.96.0/24"
}
variable "vpc_name" {
  type    = string
  default = "main"
}

variable "region" {
  type    = string
  default = "us-east-2a"
}



variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "vpc_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_pub_subnets" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))

  default = [
    {
      name                    = "nombre",
      cidr_block              = "10.1.96.0/27",
      availability_zone       = "us-east-2a"
      map_public_ip_on_launch = true
      tags = {
        "env" = "appgate-test-alex"
      }
    },

    {
      name                    = "nombre",
      cidr_block              = "10.1.96.32/27",
      availability_zone       = "us-east-2b"
      map_public_ip_on_launch = true
      tags = {
        "env" = "appgate-test-alex"
      }
    }

  ]
}

variable "vpc_pri_subnets" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))

  default = [
    {
      name                    = "nombre",
      cidr_block              = "10.1.96.64/27",
      availability_zone       = "us-east-2a"
      map_public_ip_on_launch = true
      tags = {
        "env" = "appgate-test-alex"
      }
    },

    {
      name                    = "nombre",
      cidr_block              = "10.1.96.96/27",
      availability_zone       = "us-east-2b"
      map_public_ip_on_launch = true
      tags = {
        "env" = "appgate-test-alex"
      }
    },
    {
      name                    = "nombre",
      cidr_block              = "10.1.96.128/27",
      availability_zone       = "us-east-2c"
      map_public_ip_on_launch = true
      tags = {
        "env" = "appgate-test-alex"
      }
    }


  ]
}

variable "name_subnet_nat" {
  type    = string
  default = "value"
}

variable "my_access_key" {

  type    = string
  default = "value"

}

variable "my_secret_key" {

  type    = string
  default = "value"

}



#### VARIABLES MODULO EC2 ################

variable "key_name" {
  type    = string
  default = "default"
}

variable "ami" {

  type    = string
  default = "ami-0b614a5d911900a9b"

}
