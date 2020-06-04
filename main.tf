provider "google" {
  credentials = file("poc-terraform.json")
  project     = "poc-terraform-279308"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_container_cluster" "poc" {
  name     = "poc-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = "root"
    password = "@pocterraform1234567890"

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "poc-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.poc.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}