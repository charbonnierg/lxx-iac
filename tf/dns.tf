data "digitalocean_domain" "lxx_domain" {
  name = var.domain_name
}

# Create a new A record for lxx.quest
resource "digitalocean_record" "lxx_domain" {
  domain = data.digitalocean_domain.lxx_domain.id
  type   = "A"
  name   = trimsuffix(trimsuffix(var.domain, var.domain_name), ".")
  value  = digitalocean_droplet.lxx-droplet.ipv4_address
}

resource "digitalocean_record" "lxx-subdomains" {
  domain = data.digitalocean_domain.lxx_domain.id
  type   = "A"
  name   = trimsuffix("*.${trimsuffix(var.domain, var.domain_name)}", ".")
  value  = digitalocean_droplet.lxx-droplet.ipv4_address
}
