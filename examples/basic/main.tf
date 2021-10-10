module "main" {
  source = "../.."

  username   = var.username
  first_name = var.first_name
  public_key = file(var.public_key)
  path       = var.path
}
