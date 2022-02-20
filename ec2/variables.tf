

variable "key_name" {
  type    = string
  default = "default"
}

variable "ami" {
    
   type = string 
   default = "ami-0b614a5d911900a9b"

  
}

variable  "vpc_pri_subnets" {

    type = list(string)
    default = []

}

variable "vpc_id" {
   type = string 
   default = " "
}
