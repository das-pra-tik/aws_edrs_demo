output "ec2-sg-ids" {
  value = aws_security_group.ec2_sg.id
}
output "ec2-sg-name" {
  value = aws_security_group.ec2_sg.name
}
