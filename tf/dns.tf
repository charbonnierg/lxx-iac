resource "digitalocean_domain" "lxx_domain" {
  name = var.domain_name
}

# Create a new A record for lxx.quest
resource "digitalocean_record" "lxx_domain" {
  domain = digitalocean_domain.lxx_domain.id
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.lxx-droplet.ipv4_address
}

resource "digitalocean_record" "lxx-subdomains" {
  domain = digitalocean_domain.lxx_domain.id
  type   = "A"
  name   = "*"
  value  = digitalocean_droplet.lxx-droplet.ipv4_address
}


