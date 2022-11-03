locals {
  number_of_instances = 3
  hostnames = ["worker-0", "worker-1", "control-plane"]
  layer_tags     = tomap({ "terraform_location" = format("%s", "gcp-sandbox-resources/compute") })
  tag            = merge(var.default_tags, local.layer_tags)
  network_tags = ["allowhttp", "allowhttps"]
  image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221018"
}
