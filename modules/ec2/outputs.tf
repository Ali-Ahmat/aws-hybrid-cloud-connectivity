output "instance_id" {
  value = aws_instance.quant-server.id
}

output "private_ip" {
  value = aws_instance.quant-server.private_ip
}

output "public_ip" {
  value = aws_instance.quant-server.public_ip
}