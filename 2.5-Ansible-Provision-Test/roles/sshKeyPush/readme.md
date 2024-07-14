# Instructions
In order to use this playbook you must first generate an ssh key pair for your user:

```
$ ssh-keygen -t rsa
```

Then in the playbook adjust the username to match the username on the Remote servers you want to deploy the key to.

The command to run the ansible playbook is:

```
ansible-playbook playbook.yml -i ~/path/to/your/inventory/file/hosts.ini --ask-become-pass -k
```