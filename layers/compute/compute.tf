resource "google_service_account" "manual-k8-nodes" {
  account_id   = "manualkubenodes"
  display_name = "Service Account for manual-k8-nodes"
}

resource "google_compute_instance" "kubesetup" {
  count = local.number_of_instances
  name         = "kubesetup-${count.index}"
  machine_type = var.machine_type_k8
  hostname = element(local.hostnames, tonumber("${count.index}"))

  tags = local.network_tags
  labels = local.tag

  boot_disk {
    initialize_params {
      image = local.image
      labels = local.tag
    }
  }


  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.manual-k8-nodes.email
    scopes = ["cloud-platform"]
  }
}