locals {
  number_of_instances = 3
  hostnames = ["worker-0.google.com", "worker-1.google.com", "control-plane.google.com"]
  layer_tags     = tomap({ "terraform_location" = format("%s", "terraform_resource_gcp_layers_compute") })
  tag            = merge(var.default_tags, local.layer_tags)
  network_tags = ["allowhttp", "allowhttps"]
  image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221018"
  zone = "europe-north1-a"
}
