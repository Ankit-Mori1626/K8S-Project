output "master_public_ip" {
  description = "Public IP of the master node"
  value       = aws_instance.master.public_ip
}

output "master_private_ip" {
  description = "Private IP of the master node (use this for kubeadm init --apiserver-advertise-address)"
  value       = aws_instance.master.private_ip
}

output "worker_public_ips" {
  description = "Public IPs of worker nodes"
  value       = aws_instance.worker[*].public_ip
}

output "worker_private_ips" {
  description = "Private IPs of worker nodes"
  value       = aws_instance.worker[*].private_ip
}

output "ssh_private_key_path" {
  description = "Path to the generated private key for SSH access"
  value       = local_file.private_key.filename
}

output "ssh_master_command" {
  value = "ssh -i ${local_file.private_key.filename} ubuntu@${aws_instance.master.public_ip}"
}
