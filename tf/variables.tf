variable "do_token" {
  type        = string
  description = "Digital ocean token. See [digital ocean provider documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs#token)"
}
variable "domain_name" {
  type        = string
  description = "Domain to manage using Digital Ocean"
}

variable "domain" {
  type        = string
  description = "Base domain name used to expose applications"
}

variable "account_email" {
  type        = string
  description = "Account email to use for let's encrypt registration"
}

variable "ssh_key_name" {
  type        = string
  description = "Name of allowed SSH key which can connect to root user"
}

variable "ssh_private_key" {
  type        = string
  description = "SSH private key used to connect as root user"
}


variable "region" {
  type        = string
  description = "region in which both droplet and databases are deployed. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#region) and [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#regionhttps://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#region)"
  default     = "fra1"
}

variable "droplet_name" {
  type        = string
  description = "name of digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#name)"
  default     = "lxx-01"
}

variable "droplet_image" {
  type        = string
  description = "image used by digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#image)"
  default     = "ubuntu-20-04-x64"
}

variable "droplet_size" {
  type        = string
  description = "size of digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#size)"
  default     = "s-1vcpu-1gb"
}

variable "db_cluster_name" {
  type        = string
  description = "name of digital ocean managed MongoDB database"
  default     = "mongo-lxx"
}

variable "db_cluster_size" {
  type        = string
  description = "size of digital ocean managed MongoDB database. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#size)"
  default     = "db-s-1vcpu-1gb"
}

variable "db_cluster_version" {
  type        = string
  description = "version of digital ocean managed MongoDB database. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#version)"
  default     = "5"
}

variable "db_name" {
  type        = string
  description = "name of database"
  default     = "lxx"
}

variable "db_user_name" {
  type        = string
  description = "name of database user"
  default     = "lxx"
}

variable "ssh_port" {
  type        = number
  description = "port used to connect using SSH"
  default     = 22
}
