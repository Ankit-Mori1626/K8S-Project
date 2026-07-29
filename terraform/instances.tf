data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Common bootstrap script: installs containerd, kubeadm, kubelet, kubectl on every node.
# After this runs, you SSH in and run kubeadm init (on master) / kubeadm join (on workers).
locals {
  common_userdata = file("${path.module}/../kubeadm-scripts/common-setup.sh")
}

resource "aws_instance" "master" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  user_data              = local.common_userdata

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-master"
    Role = "master"
  }
}

resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  user_data              = local.common_userdata

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-worker-${count.index + 1}"
    Role = "worker"
  }
}
