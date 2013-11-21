# A Virtual Machine for CS 165 Development

(based on [rails-dev-box](https://github.com/rails/rails-dev-box))

## Introduction

This project automates the setup of a development environment for working on [CS 165](https://github.com/ngpestelos/cs165).

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant 1.1+](http://vagrantup.com)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/ngpestelos/cs165-dev-box.git
    host $ cd cs165-dev-box
    host $ vagrant up

That's it.

After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)
    ...
    vagrant@cs165-dev-box:~$

Port 5432 in the host computer is forwarded to port 5432 in the virtual machine. Thus, applications running in the
virtual machine can be accessed via localhost:5432 in the host computer.

## What's In The Box

* Git

* Postgres

* Default database user (vagrant)

## Recommended Workflow

The recommended workflow is

* edit in the host computer and

* test within the virtual machine.

Vagrant mounts that very directory as _/vagrant_ within the virtual machine:

    vagrant@rails-dev-box:~$ ls /vagrant
    puppet  rails  README.md  Vagrantfile

We are ready to go to edit in the host, and test in the virtual machine.

This workflow is convenient because in the host computer you normally have your editor of choice fine-tuned,
Git configured, and SSH keys in place.

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://vagrantup.com/v1/docs/index.html) for more information on Vagrant.
