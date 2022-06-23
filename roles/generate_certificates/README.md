# Example usage

- Using variables in playbook

```yaml
roles:
    - role: generate_certificates
      vars:
        # Certificates will be available under /etc/lego/certificates/<domains[0]>.crt
        lego_home: /etc/lego
        certificates:
            - account_email: guillaume.charbonnier@araymond.com
              domains:
                - "guillaume.lxx.quest"
                - "*.guillaume.lxx.quest"
```
