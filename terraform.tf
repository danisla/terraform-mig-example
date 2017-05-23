variable mig_size {
  default = 1
}

module "mig" {
  source = "./managed-instance-group"
  mig_size = "${var.mig_size}"
}