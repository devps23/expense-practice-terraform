module "vpc" {
  source = "./modules/vpc"
  env = var.env
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr_block = var.default_vpc_cidr_block
  default_route_table_id = var.default_route_table_id
  backend_subnets = var.backend_subnets
  db_subnets = var.db_subnets
  frontend_subnets = var.frontend_subnets
  public_subnets = var.public_subnets
}
# module "app"{
#   source = "./modules/app"
#   env = var.env
#   instance_type = var.instance_type
#   subnet_id = module.vpc.subnet
#   vpc_id    = module.vpc.vpc_id
# }
module "frontend"{
  source          = "./modules/app"
  env             = var.env
  instance_type   = var.instance_type
  subnet_id       = module.frontend
  vpc_id          = module.vpc.vpc_id
  component       = "frontend"
  vault_token     = var.vault_token
  zone_id         = var.zone_id
  lb_type         = "public"
  lb_subnets      = var.public_subnets
  app_port        = 80
  lb_needed       = "true"
}
# module "backend"{
#   source         = "./modules/app"
#   env            = var.env
#   instance_type  = var.instance_type
#   subnet_id      = var.backend_subnets
#   vpc_id         = module.vpc.vpc_id
#   component      = "backend"
#   app_port       = 8080
#   lb_needed      = "true"
#   lb_subnets     = var.backend_subnets
#   lb_type        = "private"
#   vault_token    = var.vault_token
#   zone_id        = var.zone_id
# }
# module "db"{
#   source        = "./modules/app"
#   component     = "db"
#   env           = var.env
#   instance_type = var.instance_type
#   subnet_id     = var.db_subnets
#   vpc_id        = module.vpc.vpc_id
#   lb_subnets    = var.db_subnets
#   vault_token   = var.vault_token
#   zone_id       = var.zone_id
# }