resource "google_service_account" "k8-servers" {
  account_id   = "k8-servers"
  display_name = "Service Account used by k8-nodes"
}

resource "google_compute_instance" "kubesetup" {
  count = local.number_of_instances
  name  = "kubesetup-${count.index}"
  machine_type = var.machine_type_k8
  hostname = element(local.hostnames, tonumber("${count.index}"))
  project = var.target_project_id
  zone = local.zone

  tags = local.network_tags
  labels = local.tag

  boot_disk {
    initialize_params {
      image = local.image
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
    email  = google_service_account.k8-servers.email
    scopes = ["cloud-platform"]
  }
}