variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type for master/worker nodes (t3.medium min recommended for kubeadm)"
  type        = string
  default     = "t3.medium"
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 3
}

variable "project_name" {
  description = "Prefix used to tag/name all resources"
  type        = string
  default     = "k8s-cluster"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH into instances (restrict this to your IP in production!)"
  type        = string
  default     = "0.0.0.0/0"
}
