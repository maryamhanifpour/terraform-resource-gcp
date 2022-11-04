provider "google" {
  impersonate_service_account = "${var.tf_service_account}"
}

terraform {
  backend "gcs" {}

  required_version = ">=1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.42.0"
    }
  }
}
