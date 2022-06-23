# Install Bible Clusterer App

Quickly install the Bible Clusterer application using Docker on Linux systems.

## Requirements

Target system must have the `docker` python package installed.

## Role variables

You can configure traefik with the following variables:

| Variable                       | Default             | Description                                                                                               |
| ------------------------------ | ------------------- | --------------------------------------------------------------------------------------------------------- |
| `traefik_domain`               | `lxx.quest`         | Main domain on which Bible Clusterer app will be deployed                                                 |
| `bible_clusterer_subdomain`    | `app`               | Subdomain on which minio console is exposed. Default is `app` which lead to the subdomain `app.lxx.quest` |
| `bible_clusterer_image`        | `...`               | Bible Clusterer Docker image                                                                              |
| `bible_clusterer_service_name` | `"bible-clusterer"` | Name of Docker Swarm service                                                                              |
