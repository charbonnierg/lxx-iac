## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.21.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_database_cluster.mongodb-lxx-cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster) | resource |
| [digitalocean_database_db.mongodb-lxx-db](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_db) | resource |
| [digitalocean_database_firewall.mongodb-lxx-fw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_firewall) | resource |
| [digitalocean_database_user.mongodb-lxx-user](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_user) | resource |
| [digitalocean_domain.lxx_domain](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain) | resource |
| [digitalocean_droplet.lxx-droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.lxx-droplet-fw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_record.lxx-subdomains](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/record) | resource |
| [digitalocean_record.lxx_domain](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/record) | resource |
| [null_resource.cloud-init](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [digitalocean_ssh_key.ssh_key](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | Digital ocean token. See [digital ocean provider documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs#token) | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain to manager using Digital Ocean | `string` | n/a | yes |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | Name of allowed SSH key which can connect to root user | `string` | n/a | yes |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | SSH private key used to connect as root user | `string` | n/a | yes |
| <a name="input_db_cluster_size"></a> [db\_cluster\_size](#input\_db\_cluster\_size) | size of digital ocean managed MongoDB database. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#size) | `string` | `"db-s-1vcpu-1gb"` | no |
| <a name="input_db_cluster_version"></a> [db\_cluster\_version](#input\_db\_cluster\_version) | version of digital ocean managed MongoDB database. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#version) | `string` | `"5"` | no |
| <a name="input_db_cluter_name"></a> [db\_cluter\_name](#input\_db\_cluter\_name) | name of digital ocean managed MongoDB database | `string` | `"mongo-lxx"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | name of database | `string` | `"lxx"` | no |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | name of database user | `string` | `"lxx"` | no |
| <a name="input_droplet_image"></a> [droplet\_image](#input\_droplet\_image) | image used by digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#image) | `string` | `"ubuntu-20-04-x64"` | no |
| <a name="input_droplet_name"></a> [droplet\_name](#input\_droplet\_name) | name of digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#name) | `string` | `"lxx-01"` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | size of digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#size) | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_region"></a> [region](#input\_region) | region in which both droplet and databases are deployed. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#region) and [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#regionhttps://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#region) | `string` | `"fra1"` | no |

## Outputs

No outputs.
