## Ansible

### `ec2-provision.yml`

Playbook that kicks off an EC2 server.

> :point_up: In order to make the `ec2` module working with AWS Educate you need to make sure to export the `AWS_SESSION_TOKEN` env variables otherwise the module will fail provisioning.
