variable "env" {}
variable "instance_type"{}
variable "vpc_id" {}
variable "subnet_id" {}
variable "component"{}
variable "vault_token"{}
variable "zone_id" {}
variable "lb_type"{
  default = null
}
variable "app_port"{
  default = null
}
variable "lb_needed"{
  default = null
}
variable "lb_subnets"{
  default = null
}

