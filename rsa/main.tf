# Generate a private TLS key using RSA encryption with a length of 4096 bits
resource "tls_private_key" "ssh_private_key" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

# Apply correct file/directory level permission
resource "local_file" "pem-file" {
  depends_on = [tls_private_key.ssh_private_key]
  content    = tls_private_key.ssh_private_key.private_key_pem
  filename   = "${var.key_pair_name}.pem"
}

# Leverage the TLS private key to generate a SSH public/private key pair
resource "aws_key_pair" "ssh_key_pair" {
  depends_on = [tls_private_key.ssh_private_key, local_file.pem-file]
  key_name   = var.key_pair_name
  public_key = tls_private_key.ssh_private_key.public_key_openssh

  # when creating, save the private key to the local Terraform directory
  provisioner "local-exec" {
    when    = create
    command = "chmod 400 ${local_file.pem-file.filename}"
  }

  # When this resources is destroyed, delete the associated key from the file system
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ${self.id}.pem"
  }
}
