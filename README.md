# Ansible automated web server

This is a learning project I undertook in my time at the Linux team as a part of my apprenticeship @Aveniq.

## :paperclip: important

This project is the advanced version of the "ansible_nginx-server_v1" Repo, and thus adds the following features:

* On Push event to this Repo, the following actions are performed:
  * The Ansible Playbook gets executed
  * Checks with curl to see if the web server is up and running
  * If the web server is up and running, nothing happens
    * If the web server is down, GitHub automatically sends an email to the maintainer of this Repo
* At the moment it only supports Ubuntu

## Key Features

A simple Ansible playbook to deploy a nginx server either to a RedHat system or an Ubuntu system.

* Automatically installs all required packages
* Chooses automatically between RedHat or Ubuntu
  * RedHat: CentOS, Fedora, RHEL, etc.
* Automatically creates a HTML website with jinja2 templating
  * Allows for dynamic content

## How To Use

Change the "playbook.yml" as you wish and on a push event it automatically gets tested.
