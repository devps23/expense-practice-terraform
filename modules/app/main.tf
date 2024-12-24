# create an instance
resource "aws_instance" "instance" {
  ami = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type             = "persistent"
    }
  }
  tags = {
    Name = "${var.env}-${var.component}-demo"
    monitor = "yes"

  }
}
# create a security group
resource "aws_security_group" "security_group" {
  name        = "${var.env}-sg"
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  tags = {
    Name = "${var.env}-sg"
  }
}
resource "null_resource" "null_instance" {
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.instance.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo pip3.11 install ansible hvac",
      "ansible-pull -i localhost -U https://github.com/devps23/learn-ansible.git expense.yml-e env=${var.env} -e component_name=${var.component}"
    ]
  }
}
resource "aws_route53_record" "record" {
  name      = "${var.component}-${var.env}"
  type      = "A"
  zone_id   = var.zone_id
  ttl       = 5
  records = [aws_instance.instance.private_ip]
}


