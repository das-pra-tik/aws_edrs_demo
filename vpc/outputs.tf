output "vpc-id" {
  value = aws_vpc.aws_vpc.id
}
output "primary-vpc-public-subnet-ids" {
  value = aws_subnet.public_subnet.*.id
}
/*
output "dr-region-vpc-id" {
  value = aws_vpc.shared-vpc.id
}

output "primary-region-vpc-cidr" {
  value = aws_vpc.lamp-app-vpc.cidr_block
}

output "dr-region-vpc-cidr" {
  value = aws_vpc.shared-vpc.cidr_block
}

output "dr-region-vpc-private-subnet-ids" {
  value = [for s in aws_subnet.shared-vpc-private : s.id]
}

output "primary-region-vpc-private-subnet-ids" {
  value = [for s in aws_subnet.lamp-app-private : s.id]
}

output "primary-region-vpc-public-subnet-ids" {
  value = [for s in aws_subnet.lamp-app-public : s.id]
}

output "primary-region-vpc-database-subnet-ids" {
  value = [for s in aws_subnet.lamp-app-database : s.id]
}
*/
/*
output "shared-vpc-private-subnet-cidrs" {
  value = [for s in aws_subnet.shared-vpc-private : s.cidr_block]
}

output "shared-vpc-public-subnet-ids" {
  value = aws_subnet.shared-vpc-public[*].id
}

output "shared-vpc-private-subnet-ids" {
  value = aws_subnet.shared-vpc-private[*].id
}

output "lamp-app-vpc-private-subnet-ids" {
  value = aws_subnet.lamp-app-private.*.id
}
*/

