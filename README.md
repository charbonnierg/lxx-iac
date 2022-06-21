## Infrastructure As Code on Digital Ocean

**Objective**:

This repository can be used to deploy a virtual machine (droplet) on Digital Ocean.

## Supported development environments

- A Linux system is required to contribute to the project. 

- A Linux system is required to use the project.

> Note: `terraform` can be used on Windows, as well as `task`, but the `Taskfile` is not cross-platform.

## Useful links

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform) - <https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform>

- [Install Task](https://taskfile.dev/installation/) - <https://taskfile.dev/installation/>

- [Install doctl](https://docs.digitalocean.com/reference/doctl/how-to/install/) - <https://docs.digitalocean.com/reference/doctl/how-to/install/>

- [Install terraform-docs](https://terraform-docs.io/user-guide/installation/)

## Useful commands

- List droplet sizes:

```bash
doctl compute size list --output json | jq -r "[.[].slug]"
```

- List droplet regions:

```bash
doctl compute region list --output=json | jq '[.[].slug]'
```



## Quick start

- Make sure [`terraform`](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform) is installed.

- Make sure [`task`](https://taskfile.dev/installation/) is installed

- Create a file named `.env` and write options:

```bash
DO_TOKEN: <secret>
DO_DOMAIN_NAME: <your_domain>
DO_SSH_KEY_NAME: <your_ssh_key_name>
DROPLET_SIZE: s-2vcpu-4gb
DB_SIZE: db-s-1vcpu-1gb
DO_REGION: fra1
```

> Don't forget to update and review the values. Cost will depend on configured sizes.
>
> The configuration used above has a **_total_** cost of **_35$ / month_**:
>   - droplet: **_20$ / month_**
>   - database cluster: **_15$ / month_**
>
> Other  resources do not have a cost (*domain records and firewalls*)

- Initialize terraform environment:

```bash
task init
```

- Prepare deployment

```bash
task plan
```

You should see a summary of resources to create in the console:

```bash
Terraform will perform the following actions:

  # digitalocean_database_cluster.mongodb-lxx-cluster will be created
  + resource "digitalocean_database_cluster" "mongodb-lxx-cluster" {
      + database             = (known after apply)
      + engine               = "mongodb"
      + host                 = (known after apply)
      + id                   = (known after apply)
      + name                 = "mongodb-lxx"
      + node_count           = 1
      + password             = (sensitive value)
      + port                 = (known after apply)
      + private_host         = (known after apply)
      + private_network_uuid = (known after apply)
      + private_uri          = (sensitive value)
      + region               = "ams3"
      + size                 = "db-s-1vcpu-1gb"
      + uri                  = (sensitive value)
      + urn                  = (known after apply)
      + user                 = (known after apply)
      + version              = "5"
    }

  # digitalocean_database_db.mongodb-lxx-db will be created
  + resource "digitalocean_database_db" "mongodb-lxx-db" {
      + cluster_id = (known after apply)
      + id         = (known after apply)
      + name       = "lxx"
    }

  # digitalocean_database_firewall.mongodb-lxx-fw will be created
  + resource "digitalocean_database_firewall" "mongodb-lxx-fw" {
      + cluster_id = (known after apply)
      + id         = (known after apply)

      + rule {
          + created_at = (known after apply)
          + type       = "droplet"
          + uuid       = (known after apply)
          + value      = (known after apply)
        }
    }

  # digitalocean_database_user.mongodb-lxx-user will be created
  + resource "digitalocean_database_user" "mongodb-lxx-user" {
      + cluster_id = (known after apply)
      + id         = (known after apply)
      + name       = "lxx"
      + password   = (sensitive value)
      + role       = (known after apply)
    }

  # digitalocean_domain.lxx-domain will be created
  + resource "digitalocean_domain" "lxx-domain" {
      + id   = (known after apply)
      + name = "lxx.quest"
      + ttl  = (known after apply)
      + urn  = (known after apply)
    }

  # digitalocean_droplet.lxx-droplet will be created
  + resource "digitalocean_droplet" "lxx-droplet" {
      + backups              = false
      + created_at           = (known after apply)
      + disk                 = (known after apply)
      + droplet_agent        = true
      + graceful_shutdown    = false
      + id                   = (known after apply)
      + image                = "ubuntu-20-04-x64"
      + ipv4_address         = (known after apply)
      + ipv4_address_private = (known after apply)
      + ipv6                 = false
      + ipv6_address         = (known after apply)
      + locked               = (known after apply)
      + memory               = (known after apply)
      + monitoring           = true
      + name                 = "lxx-01"
      + price_hourly         = (known after apply)
      + price_monthly        = (known after apply)
      + private_networking   = (known after apply)
      + region               = "ams3"
      + resize_disk          = true
      + size                 = "s-2vcpu-4gb"
      + ssh_keys             = [
          + "31635942",
        ]
      + status               = (known after apply)
      + tags                 = [
          + "lxx",
        ]
      + urn                  = (known after apply)
      + user_data            = (sensitive)
      + vcpus                = (known after apply)
      + volume_ids           = (known after apply)
      + vpc_uuid             = (known after apply)
    }

  # digitalocean_firewall.lxx-droplet-fw will be created
  + resource "digitalocean_firewall" "lxx-droplet-fw" {
      + created_at      = (known after apply)
      + droplet_ids     = (known after apply)
      + id              = (known after apply)
      + name            = "only-22-80-and-443"
      + pending_changes = (known after apply)
      + status          = (known after apply)

      + inbound_rule {
          + protocol                  = "icmp"
          + source_addresses          = [
              + "0.0.0.0/0",
              + "::/0",
            ]
          + source_droplet_ids        = []
          + source_kubernetes_ids     = []
          + source_load_balancer_uids = []
          + source_tags               = []
        }
      + inbound_rule {
          + port_range                = "22"
          + protocol                  = "tcp"
          + source_addresses          = [
              + "0.0.0.0/0",
              + "::/0",
            ]
          + source_droplet_ids        = []
          + source_kubernetes_ids     = []
          + source_load_balancer_uids = []
          + source_tags               = []
        }
      + inbound_rule {
          + port_range                = "443"
          + protocol                  = "tcp"
          + source_addresses          = [
              + "0.0.0.0/0",
              + "::/0",
            ]
          + source_droplet_ids        = []
          + source_kubernetes_ids     = []
          + source_load_balancer_uids = []
          + source_tags               = []
        }
      + inbound_rule {
          + port_range                = "80"
          + protocol                  = "tcp"
          + source_addresses          = [
              + "0.0.0.0/0",
              + "::/0",
            ]
          + source_droplet_ids        = []
          + source_kubernetes_ids     = []
          + source_load_balancer_uids = []
          + source_tags               = []
        }

      + outbound_rule {
          + destination_addresses          = [
              + "0.0.0.0/0",
              + "::/0",
            ]
          + destination_droplet_ids        = []
          + destination_kubernetes_ids     = []
          + destination_load_balancer_uids = []
          + destination_tags               = []
          + protocol                       = "icmp"
        }
      + outbound_rule {
          + destination_addresses          = [
              + "0.0.0.0/0",
              + "::/0",
            ]
          + destination_droplet_ids        = []
          + destination_kubernetes_ids     = []
          + destination_load_balancer_uids = []
          + destination_tags               = []
          + port_range                     = "53"
          + protocol                       = "tcp"
        }
      + outbound_rule {
          + destination_addresses          = [
              + "0.0.0.0/0",
              + "::/0",
            ]
          + destination_droplet_ids        = []
          + destination_kubernetes_ids     = []
          + destination_load_balancer_uids = []
```

- Apply deployment

```bash
task apply
```

You can follow resources creation in the console:

```bash
digitalocean_domain.lxx-domain: Creating...
digitalocean_database_cluster.mongodb-lxx-cluster: Creating...
digitalocean_domain.lxx-domain: Creation complete after 0s [id=lxx.quest]
digitalocean_database_cluster.mongodb-lxx-cluster: Still creating... [10s elapsed]
...
digitalocean_database_cluster.mongodb-lxx-cluster: Still creating... [6m0s elapsed]
digitalocean_database_cluster.mongodb-lxx-cluster: Creation complete after 6m8s [id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx]
digitalocean_database_db.mongodb-lxx-db: Creating...
digitalocean_database_user.mongodb-lxx-user: Creating...
digitalocean_database_db.mongodb-lxx-db: Creation complete after 2s [id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx/database/lxx]
digitalocean_database_user.mongodb-lxx-user: Creation complete after 3s [id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx/user/lxx]
digitalocean_droplet.lxx-droplet: Creating...
digitalocean_droplet.lxx-droplet: Still creating... [10s elapsed]
...
digitalocean_droplet.lxx-droplet: Still creating... [50s elapsed]
digitalocean_droplet.lxx-droplet: Creation complete after 52s [id=xxxxxxxxxx]
digitalocean_database_firewall.mongodb-lxx-fw: Creating...
digitalocean_record.www: Creating...
digitalocean_firewall.lxx-droplet-fw: Creating...
digitalocean_record.www: Creation complete after 0s [id=xxxxxxxxxxx]
digitalocean_database_firewall.mongodb-lxx-fw: Creation complete after 0s [id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxx]
digitalocean_firewall.lxx-droplet-fw: Creation complete after 1s [id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxx]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
```

- Inspect the droplet state:

```bash
terraform -chdir=tf state show 'digitalocean_droplet.lxx-droplet'
```

It should return data like:

```json
# digitalocean_droplet.lxx-droplet:
resource "digitalocean_droplet" "lxx-droplet" {
    backups              = false
    created_at           = "2022-06-21T19:32:21Z"
    disk                 = 80
    droplet_agent        = true
    graceful_shutdown    = false
    id                   = "XXXXXXXXXXX"
    image                = "ubuntu-20-04-x64"
    ipv4_address         = "X.X.X.X"   <========= 📢 IPV4 address here 📢
    ipv4_address_private = "10.110.0.4"
    ipv6                 = false
    ipv6_address         = ""
    locked               = false
    memory               = 4096
    monitoring           = true
    name                 = "lxx-01"
    price_hourly         = 0.02976
    price_monthly        = 20
    private_networking   = true
    region               = "ams3"
    resize_disk          = true
    size                 = "s-2vcpu-4gb"
    ssh_keys             = [
        "31635942",
    ]
    status               = "active"
    tags                 = [
        "lxx",
    ]
    urn                  = "do:droplet:XXXXXXXXXX"
    user_data            = (sensitive)
    vcpus                = 2
    volume_ids           = []
    vpc_uuid             = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

- Connect to the droplet:

Use the IPv4 address displayed to connect using SSH:

```bash
ssh root@X.X.X.X
```

## Advanced usage

Navigate into the `tf/` directory and use `terraform` CLI directly to:
- provide variables
- plan deployment
- apply deployment
- destroy deployment

## Terraform Inputs

| Name                                                                                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Type     | Default              | Required |
| -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | -------------------- | :------: |
| <a name="input_do_token"></a> [do\_token](#input\_do\_token)                                 | Digital ocean token. See [digital ocean provider documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs#token)                                                                                                                                                                                                                                                                                                                       | `string` | n/a                  |   yes    |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name)                        | Domain to manager using Digital Ocean                                                                                                                                                                                                                                                                                                                                                                                                                                      | `string` | n/a                  |   yes    |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name)                   | Name of allowed SSH key which can connect to root user                                                                                                                                                                                                                                                                                                                                                                                                                     | `string` | n/a                  |   yes    |
| <a name="input_db_cluster_size"></a> [db\_cluster\_size](#input\_db\_cluster\_size)          | size of digital ocean managed MongoDB database. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#size)                                                                                                                                                                                                                                                               | `string` | `"db-s-1vcpu-1gb"`   |    no    |
| <a name="input_db_cluster_version"></a> [db\_cluster\_version](#input\_db\_cluster\_version) | version of digital ocean managed MongoDB database. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#version)                                                                                                                                                                                                                                                         | `string` | `"5"`                |    no    |
| <a name="input_db_cluter_name"></a> [db\_cluter\_name](#input\_db\_cluter\_name)             | name of digital ocean managed MongoDB database                                                                                                                                                                                                                                                                                                                                                                                                                             | `string` | `"mongodb-lxx"`      |    no    |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name)                                    | name of database                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `string` | `"lxx"`              |    no    |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name)                   | name of database user                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `string` | `"lxx"`              |    no    |
| <a name="input_droplet_image"></a> [droplet\_image](#input\_droplet\_image)                  | image used by digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#image)                                                                                                                                                                                                                                                                                           | `string` | `"ubuntu-20-04-x64"` |    no    |
| <a name="input_droplet_name"></a> [droplet\_name](#input\_droplet\_name)                     | name of digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#name)                                                                                                                                                                                                                                                                                                  | `string` | `"lxx-01"`           |    no    |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size)                     | size of digital ocean droplet. See [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#size)                                                                                                                                                                                                                                                                                                  | `string` | `"s-1vcpu-1gb"`      |    no    |
| <a name="input_region"></a> [region](#input\_region)                                         | region in which both droplet and databases are deployed. See [database cluster resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster#region) and [droplet resource documentation](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#regionhttps://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#region) | `string` | `"fra1"`             |    no    |

## Terraform Resources

| Name                                                                                                                                                          | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [digitalocean_database_cluster.mongodb-lxx-cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_cluster) | resource    |
| [digitalocean_database_db.mongodb-lxx-db](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_db)                | resource    |
| [digitalocean_database_firewall.mongodb-lxx-fw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_firewall)    | resource    |
| [digitalocean_database_user.mongodb-lxx-user](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_user)          | resource    |
| [digitalocean_domain.lxx-domain](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain)                              | resource    |
| [digitalocean_droplet.lxx-droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet)                           | resource    |
| [digitalocean_firewall.lxx-droplet-fw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall)                      | resource    |
| [digitalocean_record.www](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/record)                                     | resource    |
| [digitalocean_ssh_key.ssh_key](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key)                            | data source |
