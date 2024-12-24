module "frontend" {
  depends_on = [module.backend]
  source = "./modules/app"
  component = "frontend"
  instance_type=var.instance_type
  env = var.env
  zone_id     = var.zone_id
}
module "backend" {
  depends_on = [module.db]
  source = "./modules/app"
  component = "backend"
  instance_type=var.instance_type
  env = var.env
  zone_id = var.zone_id
}
module "db" {
  source = "./modules/app"
  component = "db"
  instance_type=var.instance_type
  env = var.env
  zone_id = var.zone_id
}