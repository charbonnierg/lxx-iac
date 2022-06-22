# Create a new database cluster
resource "digitalocean_database_cluster" "mongodb-lxx-cluster" {
  name       = var.db_cluster_name
  engine     = "mongodb"
  version    = var.db_cluster_version
  size       = var.db_cluster_size
  region     = var.region
  node_count = 1
}

# Create a new database user
resource "digitalocean_database_user" "mongodb-lxx-user" {
  cluster_id = digitalocean_database_cluster.mongodb-lxx-cluster.id
  name       = var.db_user_name
}

# Create a new database
resource "digitalocean_database_db" "mongodb-lxx-db" {
  cluster_id = digitalocean_database_cluster.mongodb-lxx-cluster.id
  name       = var.db_name
}

# Create a database firewall to allow incoming trafic from droplet only
resource "digitalocean_database_firewall" "mongodb-lxx-fw" {
  cluster_id = digitalocean_database_cluster.mongodb-lxx-cluster.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.lxx-droplet.id
  }
}
