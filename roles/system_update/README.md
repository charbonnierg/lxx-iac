# Role variables

| Name                            |       Default/Required        | Description                                    |
| ------------------------------- | :---------------------------: | ---------------------------------------------- |
| `system_update_dpkg_options`    | `force-confold,force-confdef` | Options given to `dpkg` through `apt-get`      |
| `system_update_upgrade_dist`    |            `true`             | Whether dist upgrade should be performed hosts |
| `system_update_remove_packages` |             `[]`              | Array of packages to remove                    |
