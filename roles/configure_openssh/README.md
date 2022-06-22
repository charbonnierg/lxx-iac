# Role variables

| Name                                     |    Default/Required    | Description                                                                                      |
| ---------------------------------------- | :--------------------: | ------------------------------------------------------------------------------------------------ |
| `enable_sshd`                            |         `true`         | Enable or disable `sshd` at boot                                                                 |
| `start_sshd`                             |         `true`         | Start `sshd` immediately                                                                         |
| `sshd_port`                              |          `22`          | SSH server listening port                                                                        |
| `sshd_listen_address`                    |       `0.0.0.0`        | SSH server listening address                                                                     |
| `sshd_strict_mode`                       |         `yes`          | Enable or disable strict mode                                                                    |
| `sshd_authorized_keys`                   | `.ssh/authorized_keys` | File to look for authorized keys                                                                 |
| `sshd_root_login`                        | `"prohibit-password"`  | Root login policy                                                                                |
| `sshd_password_authentication`           |         `"no"`         | Enable or disable password authentication                                                        |
| `sshd_public_key_authentication`         |        `"yes"`         | Enable or disable password authentication                                                        |
| `sshd_challenge_response_authentication` |         `"no"`         | Enable or disable challenge response authentication                                              |
| `sshd_kerberos_authentication`           |         `"no"`         | Enable or disable kerberos authentication                                                        |
| `sshd_gssapi_authentication`             |         `"no"`         | Enable or disable GSSAPI authentication                                                          |
| `sshd_empty_password`                    |         `"no"`         | Allow login with empty password (only considered when `sshd_password_authentication` is `"yes"`) |
