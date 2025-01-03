# create an instance
resource "aws_instance" "instance" {
  ami = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id = var.subnet_id[0]

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
  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}
# create a security group
resource "aws_security_group" "security_group" {
  name        = "${var.env}-sg"
  vpc_id      = var.vpc_id
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
      "ansible-pull -i localhost. -U https://github.com/devps23/learn-ansible.git -e env=${var.env} -e component_nam=${var.component}"
    ]
  }
}
# resource "aws_route53_record" "vault_record" {
#   name      = "vault_internal"
#   type      = "A"
#   zone_id   = var.zone_id
#   ttl       = 5
#   records = [aws_instance.instance.public_ip]
# }
# create a load balancer
resource "aws_lb" "test" {
  count              = lb_needed ? 1 : 0
  name               = "${var.env}-${var.component}-lb"
  internal           = var.lb_type == "public" ? 0 : 1
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group.id]
  subnets            = var.lb_subnets
  enable_deletion_protection = true
   tags = {
    Environment = "${var.env}-${var.component}-lb"
  }
}