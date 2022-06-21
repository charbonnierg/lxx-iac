# Role variables

| Name               |             Default/Required              | Description                            |
| ------------------ | :---------------------------------------: | -------------------------------------- |
| `default_ssh_key`  |                `required`                 | Default SSH public key used to connect |
| `system_groups`    |     `[{name: "docker", gid: 12345}]`      | Array of groups                        |
| `system_users`     | [See roles default](./defaults./main.yml) | Array of users                         |
| `default_username` |                  `"lxx"`                  | Default username                       |

## User format

Each users found in `system_users` array is expected to have the following schema:

```yaml
users:
  - name: example
    # It's also possible to set UID for user
    # uid: 1000
    # Users will be added to those groups
    groups:
      - docker
    # Control whether home directory should be created for user
    # default to true
    create_home: true
    # Set default shell
    # default to /bin/bash
    shell: /bin/bash
    # Boolean indicating whether password is locked
    # When password is locked, login is only possible using SSH key
    # default to false
    password_lock: true
    # Give sudo capabilities
    # default to false
    sudo_user: true
    # Give password to user
    # password: ...
    # Control whether password is required to use sudo
    # default to false (I.E, password is required)
    passwordless_sudo: true
    # A couple of public and private keys will be generated for the user
    # They can be found at ~/.ssh/id_rsa.pub and ~/.ssh/id_rsa
    # default to false
    generate_ssh_key: true
    # Following SSH public key will be allowed to log in as user
    # default to empty list
    ssh_authorized_keys:
      # QUARA Admin
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDatmjoB/PensjlLNiNwIOtiXg0sgbw+ahB2aEwhzqwQ7weSusTps0DbMsqQ2lKHhcO//43jFehYSAAbRVHAox3YTPtWY1JT18AJTGhWOOt32+W91ZXoFQnQBcTQZs915WUYT2AlqXUdNgIu86lnfV1OmI0koLCVQqJ9P8SJLrCuq11me2lqJFofGDhkSmiJqi4EIPzsTA2pFCbx43h1sBEUIUE2VQAoI+kVG+wbXPtN+Teklb+1NHpxWZWJoh7lEoLZkQKA4W2ou30gZ1pbDndzXTVBVLI1jH6hpnL624H21ypE2NXA+bi6ULj4rooOhg8uG+wu6EdQoBn4hlsBJpFarQM856cXDOnIAcitRd1+D3ozBVS4BIbE5LQCnHsuv6cyNyJfR0d9N2HFd0Q6LgqasOVpZBL1XYst7QhBh1FZYrIK7KdB65Yo4c0XRjqt99m5i0SqqdH6oT7KWsaBMJz3VnoqPV1p/amTPnmYh4fcRX/KFvGJo/XmCzHFD3wP10= quara-admin
```

Note that encrypted password can be generated using:

```bash
python -c "from passlib.hash import sha512_crypt; import getpass; print(sha512_crypt.using(rounds=5000).hash(getpass.getpass()))"
```
