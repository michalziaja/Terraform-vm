resource "google_compute_network" "vm_vpc" {
  name = "vm-vpc"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "vm_subnet" {
  name          = "vm-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-west1"
  network       = google_compute_network.vm_vpc.name
}  
resource "google_compute_instance" "vm_instance" {
  name         = "vm-instance"
  machine_type = "e2-small"
  zone         = "us-west1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vm_vpc.name
    subnetwork = google_compute_subnetwork.vm_subnet.name
    access_config {
      // public ip
    }
  }
}
