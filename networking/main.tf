



resource "aws_vpc" "appgate-test-vpc" {
  cidr_block           = var.vpc_cidr 
  enable_dns_hostnames = true
  tags = {
    Name  = "${var.vpc_name}--VPC"
  }
  
}


resource "aws_subnet" "public-subnets" {
  
  for_each = {for v in var.vpc_pub_subnets : v.cidr_block => v }

  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.appgate-test-vpc.id
  availability_zone = each.value.availability_zone
  tags = each.value.tags
  map_public_ip_on_launch =  true   

  depends_on = [aws_internet_gateway.igw]
  
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.appgate-test-vpc.id
  tags = {
      Name = "igw-vpc"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.appgate-test-vpc.id 
  route  {
      gateway_id = aws_internet_gateway.igw.id
      cidr_block="0.0.0.0/0" 
  } 
  
  
  tags ={

    Name = "${var.env}--Public-RouteTable"

  }  
  
}

 resource "aws_eip" "bar" {
  vpc = true
  tags ={
    Name = "Elastic-appgate"
  }

 }

resource "aws_nat_gateway" "nat-appgate" {
 allocation_id = aws_eip.bar.id

 subnet_id     = values(aws_subnet.public-subnets)[0].id
 

  tags = {
    Name = "gw NAT-APPGATE"
  }
  
   
  
  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.appgate-test-vpc.id
  route  {
      nat_gateway_id = aws_nat_gateway.nat-appgate.id
      cidr_block="0.0.0.0/0" 
  } 
  
  tags ={
    Name = "${var.env}--Public-RouteTable"

  }  
  
}

resource "aws_route_table_association" "public-route-1-association" {
  for_each =  aws_subnet.public-subnets

  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = each.value.id
  
  depends_on = [aws_subnet.public-subnets]
}
resource "aws_route_table_association" "private-route-2-association" {
    
    for_each =  aws_subnet.private-subnets 

    route_table_id = aws_route_table.private-route-table.id
    subnet_id      = each.value.id

  depends_on = [aws_subnet.private-subnets]

}



resource "aws_subnet" "private-subnets" {
  
  for_each = {for v in var.vpc_pri_subnets : v.cidr_block => v }

  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.appgate-test-vpc.id  
  availability_zone = each.value.availability_zone
  tags = each.value.tags
     
  
}

#

#resource "aws_lb" "load_balancer" {
 # name               = "web-app-lb"
  #load_balancer_type = "application"
  #subnets            = data.aws_subnet_ids.default_subnet.ids
  #security_groups    = [aws_security_group.alb.id]

#}



#resource "aws_lb_listener" "http" {

 # load_balancer_arn = aws_lb.load_balancer.arn

  #port = 80

  #protocol = "HTTP"

  # By default, return a simple 404 page
  #default_action {
   # type = "fixed-response"

    #fixed_response {
     # content_type = "text/plain"
      #message_body = "404: page not found"
      #status_code  = 404
    #}
  #}
#}