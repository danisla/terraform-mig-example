variable region {
  description = "Region for managed instance group"
  default = "us-central1"
}

variable zone {
  description = "Zone for managed instance groups"
  default = "us-central1-f"
}

variable mig_name {
  description = "Name of the managed instance group"
  default = "my-group"
}

variable mig_size {
  description = "Target size of the manged instance group"
  default = 1
}

variable subnetwork_name {
  description = "Name of the subnetwork to deploy instances to"
  default = "default"
}

variable compute_machine_type {
  description = "Machine type for the VMs in the instance group"
  default = "n1-standard-1"
}

variable compute_image {
  description = "Image used for compute VMs"
  default = "ubuntu-1604-xenial-v20170328"
}

variable service_port {
  description = "TCP port your service is listening on."
  default = "80"
}

output "external_ip" {
  value = "${google_compute_forwarding_rule.compute.ip_address}"
}