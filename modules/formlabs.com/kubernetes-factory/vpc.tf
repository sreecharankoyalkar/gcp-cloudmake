module "vpc" {
  source = "../../vpc-factory"

  project_id   = var.project_id
  network_name = "${var.cluster_name}-vpc"
  subnets = [{
    subnet_name   = local.network_names["subnet"]
    subnet_ip     = var.subnet
    subnet_region = var.cluster_region
    },
  ]

  secondary_ranges = {
    (local.network_names["subnet"]) = [
      {
        range_name    = local.network_names["pods"]
        ip_cidr_range = var.pods_range
      },
      {
        range_name    = local.network_names["services"]
        ip_cidr_range = var.services_range
      },
    ]
  }
}