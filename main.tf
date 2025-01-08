# module "frontend" {
#   depends_on = [module.backend]
#   source = "./modules/app"
#   component = "frontend"
#   instance_type=var.instance_type
#   env = var.env
#   zone_id     = var.zone_id
#   vault_token = var.vault_token
# }
# module "backend" {
#   depends_on = [module.mysql]
#   source = "./modules/app"
#   component = "backend"
#   instance_type=var.instance_type
#   env = var.env
#   zone_id = var.zone_id
#   vault_token = var.vault_token
# }
# module "mysql" {
#   source = "./modules/app"
#   component = "mysql"
#   instance_type=var.instance_type
#   env = var.env
#   zone_id = var.zone_id
#   vault_token = var.vault_token
# }
module "rds"{
  source = "./modules/rds"
  component = "rds"
  env = var.env
#   instance_type = var.instance_type
#   vault_token = var.vault_token
#   zone_id = var.zone_id
#   app_port = 3306
}