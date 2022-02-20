


module "appgate-network" {

  source = "./networking"

  vpc_pri_subnets          = var.vpc_pri_subnets
  vpc_pub_subnets          = var.vpc_pub_subnets
  vpc_cidr                 = var.vpc_cidr
  vpc_name                 = var.vpc_name
  region                   = var.region
  vpc_tags                 = var.vpc_tags
  vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames
  #vpc_id                   = module.appgate-network.vpc_id
 # nat-appgate              = 
 # aws_eip                  = 

 # name_subnet_nat = var.name_subnet_nat


}

module "appate-ec2" {

    source = "./ec2"
    key_name             = var.key_name
    ami                  = var.ami
    vpc_pri_subnets      = module.appgate-network.this_sub_pri
    vpc_id               = module.appgate-network.vpc_id

}