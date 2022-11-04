variable "default_tags" {
  description = "Map of key/value tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "tf_service_account" {
  description = "service account used by terraform to deploy resources"
  type        = string
}

variable "region" {
  description = "region to deploy resources"
  type        = string
}

variable "target_project_id" {
  description = "gcp project id being deployed to"
  type        = string
}

variable "machine_type_k8" {
  description = "instance type for manual k8 setup"
  type        = string
  default     = "n1-standard-1" #Run every 6 hours every day starting from 00:00
}