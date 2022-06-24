## Infrastructure As Code on Digital Ocean

## Virtual Machine Description

This project can be used to spin-up a droplet (virtual machine) on Digital Ocean.

This droplet is configured on first boot in order to provide various services to end users.

#### Operation System

The droplet OS is Ubuntu 20.04 (focal fossa).

#### Unix Users

- A default user named `lxx` is created with home directory `/home/lxx`
- This user can use `sudo` without password and is a member of `docker` group

#### Journald Configuration

`journald` log system is configured to store logs persistently by default.

#### SSH Configuration

- Password authentication is disabled
- SSH keypairs must be used
- Port 22 is used by default
- A single SSH key can connect to both `root` and `lxx` user by default

> Note: Use the `DO_SSH_KEY_NAME` environment variable to configure the name of SSH key to allow.

#### Time Synchronisation

- Time synchronisation is enabled using `systemd-timesyncd`.
- The default NTP server is `time.windows.com`.

#### Docker

- Docker Engine is installed and can be used using the `docker` command.
- Only users in `docker` group can run docker commands without `sudo`
- Engine configuration can be found under `/etc/docker/daemon.json`

#### Docker Swarm

- A single-node docker swarm cluster is running by default.
- Docker Swarm cluster advertise address is the droplet private address within its VPC (it means that it's possible to create a new droplet in the same VPC and join the swarm cluster)

#### Traefik

- Traefik reverse proxy is installed using Docker Swarm and listens on ports `80` and `443` on host machine.
- Traefik dashboad can be reached on `https://traefik.<domain>` (default `https://traefik.lxx.quest`).

> Note: Update `DOMAIN_NAME` to configure domain to use.
> For example, using `DOMAIN_NAME=test.lxx.quest` leads to Traefik Dashboard listenning on <https://traefik.test.lxx.quest>

> In order to expose docker services using Traefik, containers must be attached to the `traefik-network` (docker overlay network).

#### MinIO

- MinIO server is installed using Docker Swarm and is exposed behind Traefik:
  - MinIO Dashboard can be reached on `https://minio.<domain>` (default `https://minio.lxx.quest`)
  - MinIO Server can be reached on `https://storage.<domain>` (default `https://storage.lxx.quest`)

#### Jupyter Hub

- Jupyterhub is installed using [TLJH](https://tljh.jupyter.org/en/latest/)
- Jupyter users are authenticated using `systemd`.
  - Admin user is `lxx`
    - Password is defined on first connection
  - New users can be created from admin panel
    - Unix users will be created automatically

#### Let's Encrypt certificates

- TLS certificates are available under `/etc/lego/certificates`
- Certificates are renewed 30 days before expiration (check performed daily)


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
DO_SSH_KEY_NAME: <your_ssh_key_name>
DO_DOMAIN_NAME: lxx.quest
DOMAIN_NAME: test.lxx.quest
DO_SSH_KEY_NAME: charbonnierg@WSL2
DROPLET_SIZE: s-2vcpu-4gb
DROPLET_NAME: lxx-test
DB_CLUSTER_NAME: lxx-test-cluster
DB_CLUSTER_SIZE: db-s-1vcpu-1gb
DO_REGION: ams3
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

- Apply deployment

```bash
task apply
```

- Inspect the droplet state:

```bash
task show-droplet
```

- Connect to the droplet:

```bash
task ssh
```

- Connect using VSCode:

```bash
task code
```

> When using WSL, Windows user SSH key must be allowed to connect to remote host instead of Linux user SSH key

## Advanced usage

Navigate into the `tf/` directory and use `terraform` CLI directly to:
- provide variables
- plan deployment
- apply deployment
- destroy deployment
