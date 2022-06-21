# Install Docker

Quicly install and configure docker on a linux host:

- Install containerd
- Install Docker Engine (CE)
- Install Docker Client
- Configure docker daemon through `daemon.json` file

## Requirements

You only need to have an SSH access to the remote host in order to play this role.

## Role Variables

You can configure docker with the following variables:

| Variable                       | Default                                                                                               | Description                                                                                                                                                                                           |
| ------------------------------ | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `docker_repo`                  | `"deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ansible_distribution_release}} stable"` | The apt repository where to install docker packages from. Note that `{{ ansible_distribution_release}}` will be substituted with the ubuntu release or remote host (e.g, trusty, xenial, bionic, ...) |
| `docker_packages`              | `["docker-ce", "docker-ce-cli", "containerd.io"]`                                                     | Packages to install. You can choose to install only docker engine (e.g, docker-ce) or install only the docker client (docker-ce-cli)                                                                  |
| `docker_service_state`         | `"started"`                                                                                           | Desired state for docker service                                                                                                                                                                      |
| `docker_service_enabled`       | `true`                                                                                                | Register docker service to start at boot.                                                                                                                                                             |
| `docker_restart_handler_state` | `"restarted"`                                                                                         | Desired state of docker service after performing modification of docker service configuration.                                                                                                        |
| `docker_daemon_debug`          | `true`                                                                                                | Enable docker daemon debug feature                                                                                                                                                                    |
| `docker_daemon_experimental`   | `true`                                                                                                | Enable docker engine experimental features                                                                                                                                                            |
| `docker_daemon_log_driver`     | `journald`                                                                                            | Default log driver used by containers                                                                                                                                                                 |
| `docker_swarm_init`            | `true`                                                                                                | Enable docker swarm mode (as manager) when set to `true`                                                                                                                                              |
| `docker_swarm_advertise_addr`  | `omitted`                                                                                             | Address used by the swarm manager to listen to woerker or manager nodes trying to join the swarm                                                                                                      |
| `docker_compose_install`       | `true`                                                                                                | Install `docker-compose` (with exact version) when set to `true`                                                                                                                                      |
| `docker_compose_version`       | `"2.5.0"`                                                                                             | Version of `docker-compose` to install                                                                                                                                                                |
| `docker_compose_path`          | `"/usr/local/bin/docker-compose"`                                                                     | Path where `docker-compose` is installed                                                                                                                                                              |
| `docker_py_install`            | `true`                                                                                                | Install `docker` python package globally                                                                                                                                                              |