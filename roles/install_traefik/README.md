# Install Traefik

Quickly install Traefik using Docker on Linux systems.

## Requirements

Target system must have the `docker` python package installed.

## Role variables

You can configure traefik with the following variables:

| Variable                      | Default       | Description                                                                                                                 |
| ----------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `traefik_dns_challenge_token` | `required`    | Digital Ocean API token                                                                                                     |
| `traefik_letsencrypt_email`   | `required`    | Email used to create Let's Encrypt account. Certificate expiration alerts will be sent to this email.                       |
| `traefik_subdomain`           | `"traefik"`   | Subdomain on which Traefik dashboard is exposed. Default value is `traefik` which lead to the subdomain `traefik.lxx.quest` |
| `traefik_domain`              | `"lxx.quest"` | Main domain for which TLS certificates are isued                                                                            |

