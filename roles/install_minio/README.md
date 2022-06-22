# Install MinIO

Quickly install MinIO using Docker on Linux systems.

## Requirements

Target system must have the `docker` python package installed.

## Role variables

You can configure traefik with the following variables:

| Variable                  | Default                                      | Description                                                                                                                         |
| ------------------------- | -------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `traefik_domain`          | `lxx.quest`                                  | Main domain on which MinIO apps will be deployed                                                                                    |
| `minio_subdomain`         | `storage`                                    | Subdomain on which minio console is exposed. Default is `stroage` which lead to the subdomain `storage.lxx.quest`                   |
| `minio_console_subdomain` | `"minio"`                                    | Subdomain on which MinIO Console is expoed. Default value is `minio` which lead to the subdomain `minio.lxx.quest`                  |
| `minio_user`              | `"minioadmin"`                               | Default MinIO username                                                                                                              |
| `minio_password`          | `"minioadmin"`                               | Default MinIO password                                                                                                              |
| `minio_region`            | `"fra1"`                                     | Name of MinIO region                                                                                                                |
| `minio_site`              | `"lxx-01"`                                   | Name of MinIO site                                                                                                                  |
| `minio_image`             | `"minio/minio:RELEASE.2022-06-20T23-13-45Z"` | MinIO Docker image                                                                                                                  |
| `minio_data_mount`        | `"/var/lib/minio"`                           | Directory on host machine where MinIO files are stored. Directory is mounted into Docker container using a bind mount into `/data`. |
| `minio_service_name`      | `"minio"`                                    | Name of Docker Swarm service                                                                                                        |
