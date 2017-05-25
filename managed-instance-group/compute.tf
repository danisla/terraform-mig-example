
resource "google_compute_http_health_check" "compute" {
  name = "${var.mig_name}-compute-hc"
  request_path = "/"
  port = "${var.service_port}"
}

resource "google_compute_instance_template" "compute" {
  name_prefix = "compute-"

  machine_type = "${var.compute_machine_type}"

  region = "${var.region}"

  tags = [
    "allow-ssh",
    "allow-service"
  ]

  network_interface {
    subnetwork = "${var.subnetwork_name}"
    access_config {
    }
  }

  disk {
    auto_delete = true
    boot = true
    source_image = "${var.compute_image}"
    type = "PERSISTENT"
    disk_type = "pd-ssd"
  }

  service_account {
    email = "default"
    scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/devstorage.full_control"
    ]
  }

  metadata {
    startup-script = "${file("${path.module}/scripts/compute.sh")}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "compute" {
  name = "${var.mig_name}-compute"
  description = "compute VM Instance Group"

  base_instance_name = "${var.mig_name}-compute"

  instance_template = "${google_compute_instance_template.compute.self_link}"

  zone = "${var.zone}"

  update_strategy = "RESTART"

  target_pools = ["${google_compute_target_pool.compute.self_link}"]
  target_size = "${var.mig_size}"

  named_port {
    name = "service"
    port = "${var.service_port}"
  }
}

resource "google_compute_target_pool" "compute" {
  name = "${var.mig_name}-target-pool"
  session_affinity = "NONE"
  health_checks = [
    "${google_compute_http_health_check.compute.name}",
  ]
}