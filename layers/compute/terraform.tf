provider "google" {
  impersonate_service_account = "terraform@${var.target_project_id}.iam.gserviceaccount.com"
}

terraform {
  backend "gcs" {}

  required_version = ">=1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.40.0"
    }
  }
}
