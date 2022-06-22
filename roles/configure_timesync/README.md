# Role variables

| Name                          |   Default/Required    | Description                                                                       |
| ----------------------------- | :-------------------: | --------------------------------------------------------------------------------- |
| `timesync_timezone`           |       `Etc/UTC`       | Timezone to set (relative to `/usr/share/zoneinfo`)                               |
| `timesync_ntp_hosts`          |  `time.windows.com`   | Array of NTP hosts                                                                |
| `timesync_fallback_ntp_hosts` | `{0..3}.pool.ntp.org` | Array of fallback NTP hosts                                                       |
| `timesync_set_hwclock`        |        `True`         | Whether to write the time to the hardware clock after changing the configuration. |
