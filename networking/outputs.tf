output "vpc_id" {
  value = aws_vpc.appgate-test-vpc.id
}

output "this_sub_pub" {
  value = [for p in aws_subnet.public-subnets: p.id]
}

output "this_sub_pri" {
  value = [for p in aws_subnet.private-subnets : p.id]
}

