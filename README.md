## Infrastructure As Code on Digital Ocean

**Objective**:

This repository can be used to deploy an Ubuntu virtual machine (droplet) on Digital Ocean.

The following configuration are performed:

- [x] Update of system packages using `apt-get`
- [x] Configuration of OpenSSH server to allow key pair authentication only
- [x] Configuration of `systemd-timesyncd` to set system local time and configure time synchronnisation
- [x] Configuration of system users
- [x] Docker installation
- [x] Traefik Proxy installation
- [x] MinIO Cloud Storage installation
- [ ] Bible Clusterer Application installation

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
