# Import ssh key by name
data "digitalocean_ssh_key" "ssh_key" {
  name = var.ssh_key_name
}

# Create a new droplet
resource "digitalocean_droplet" "lxx-droplet" {
  image  = var.droplet_image
  name   = var.droplet_name
  region = var.region
  size   = var.droplet_size
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
  ]
  tags = [
    "lxx"
  ]
  droplet_agent = true
  monitoring    = true
  user_data     = <<EOF
#!/bin/bash

set -euo pipefail

# Install packages using apt-get
mkdir -p /etc/apt/apt.conf.d
echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4
apt-get update
apt-get install -y \
    ansible \
    git \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    vim \
    jq

# Install docker-py client and virtualenv
python3 -m pip install --disable-pip-version-check -U --user --no-cache-dir pip setuptools wheel
python3 -m pip install --no-cache-dir --root-user-action=ignore docker virtualenv pymongo

export CERTIFICATES=$(jq --arg key0 'account_email' \
   --arg value0 "${var.account_email}" \
   --arg key1 'domains' \
   --argjson value1 "[\"${var.domain}\", \"*.${var.domain}\"]" \
   '. | .[$key0]=$value0 | .[$key1]=$value1' \
   <<<'{}')

# Configure system using ansible
ansible-galaxy collection install community.docker
ansible-pull -U https://github.com/charbonnierg/lxx-iac.git \
  -i "$(hostname --short)," \
  -e "traefik_dns_challenge_token=${var.do_token}" \
  -e "traefik_subdomain=traefik" \
  -e "traefik_domain=${var.domain}" \
  -e "default_username=lxx" \
  -e "default_ssh_key='${data.digitalocean_ssh_key.ssh_key.public_key}'" \
  -e "docker_swarm_advertise_addr=$(ip -f inet addr show eth1 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')" \
  -e "traefik_letsencrypt_ca_server=https://acme-v02.api.letsencrypt.org/directory" \
  -e "sshd_port=${var.ssh_port}" \
  -e "certificates=\"$CERTIFICATES\"" \
  playbook.yml

# Display certificates
docker run --rm \
  --env DO_AUTH_TOKEN="${var.do_token}" \
  -v /etc/lego:/lxx-lego \
  goacme/lego \
  --path /lxx-lego \
  list

# Install TLJH
mkdir -p /opt/tljh
virtualenv /opt/tljh/hub --download
/opt/tljh/hub/bin/python -m pip install git+https://github.com/charbonnierg/the-littlest-jupyterhub.git@remove-jupyter-prefix
/opt/tljh/hub/bin/python -m tljh.installer --admin lxx
/opt/tljh/hub/bin/tljh-config set https.enabled false
/opt/tljh/hub/bin/tljh-config set http.port 10080
/opt/tljh/hub/bin/tljh-config set user_environment.default_app jupyterlab

# Make sure jupyterhub is started and reloaded
systemctl enable --now jupyterhub
/opt/tljh/hub/bin/tljh-config reload proxy
/opt/tljh/hub/bin/tljh-config reload hub
EOF
}

# # FIXME: Add those lines once Mongo database is included in deployment

# # -e "mongo_user=lxx" \
# # Configure default environment variables for notebook users
# cat <<INNEREOF > /opt/tljh/config/jupyterhub_config.d/environment.py
# c.Spawner.environment = {
#   'MONGO_URI': '${digitalocean_database_cluster.mongodb-lxx-cluster.uri}',
#   'MONGO_HOST': '${digitalocean_database_cluster.mongodb-lxx-cluster.host}',
#   'MONGO_PORT': '${digitalocean_database_cluster.mongodb-lxx-cluster.port}',
#   'MONGO_PASSWORD': '${digitalocean_database_user.mongodb-lxx-user.password}',
# }
# INNEREOF

# # Export environment variables for bash sessions
# echo "export MONGO_URI='${digitalocean_database_cluster.mongodb-lxx-cluster.uri}'" >> /etc/profile
# echo "export MONGO_HOST='${digitalocean_database_cluster.mongodb-lxx-cluster.host}'" >> /etc/profile
# echo "export MONGO_PORT='${digitalocean_database_cluster.mongodb-lxx-cluster.port}'" >> /etc/profile
# echo "export MONGO_PASSWORD='${digitalocean_database_user.mongodb-lxx-user.password}'" >> /etc/profile
# echo "export MONGO_USER=lxx" >> /etc/profile



resource "null_resource" "cloud-init" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      host        = digitalocean_droplet.lxx-droplet.ipv4_address
      private_key = file("~/.ssh/id_rsa")
    }
    inline = [
      "cloud-init status --wait > /dev/null & tail --pid $! -n +1 -f /var/log/cloud-init-output.log"
    ]
  }
}
