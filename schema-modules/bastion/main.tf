resource "aws_instance" "bastion_node" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  subnet_id                   = "${var.subnet_id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.bastion_node.id}"]
  key_name                    = "${var.key_name}"

  tags {
    Name        = "Bastion Node"
    Environment = "${var.env_prefix}"
  }
}

resource "aws_security_group" "bastion_node" {
  name        = "${format("%s-bastion-sg", var.env_prefix)}"
  description = "Security group for Bastion Node"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_prefix} Bastion Node"
    }
  }
