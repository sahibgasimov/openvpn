//data "aws_ami" "ubuntu" {
//  most_recent = true
//
//  filter {
//    name   = "name"
//    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
//    values = ["paravirtual"]
//  }
//
//  owners = ["099720109477"]
//}

resource "aws_security_group" "openvpn" {
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  description = "OpenVPN security group"


  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # For OpenVPN Client Web Server & Admin Web UI
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "udp"
    from_port   = 1194
    to_port     = 1194
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "openvpn" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = "subnet-092e82366475f1e18"

  vpc_security_group_ids = ["${aws_security_group.openvpn.id}"]

  provisioner "local-exec" {
    command = "ansible-playbook --private-key ~/.ssh/id_rsa.pub -i '${aws_instance.openvpn.public_ip},' config/ansible/openvpn.yml"
  }
}

resource "aws_route53_record" "openvpn" {
  zone_id = "${var.route_zone_id}"
  name    = "vpn.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.openvpn.public_ip}"]
}