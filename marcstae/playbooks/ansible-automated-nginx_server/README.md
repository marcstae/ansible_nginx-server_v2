# Ansible automated web server

This is a learning project I undertook in my time at the Linux team as a part of my apprenticeship @Aveniq.

## Key Features

A simple Ansible playbook to deploy a nginx server either to a RedHat system or an Ubuntu system.

* Automatically installs all required packages
* Chooses automatically between RedHat or Ubuntu
  * RedHat: CentOS, Fedora, RHEL, etc.
* Automatically creates a HTML website with jinja2 templating
  * Allows for dynamic content

## How To Use

Clone this project onto your local machine that has Ansible installed.

Edit the inventory file and run the playbook.

```bash
# Run the playbook
$ ansible-playbook playbook.yml -i inventory -k -K
```
