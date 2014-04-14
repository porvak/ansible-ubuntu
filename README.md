ansible-ubuntu
===============

Ansible playbook to setup some of the basics for my Ubuntu machine.

## Notes

* This playbook is currently tested against Ubuntu 13.10, YMMV for other versions
* Ansible 1.6 or higher is required

## Getting Started

On a fresh install of Ubuntu 13.10:
* Download the zip of this repository
* Extract the repo
* Run setupAnsible.sh - this will install the latest devel version.
* Edit ansible's inventory file
* Execute the playbook

```Shell
wget https://github.com/porvak/ansible-ubuntu/archive/master.zip
unzip master.zip
cd master
./setupAnsible.sh
```

Edit /etc/ansible/hosts
```
[all]
localhost     ansible_connection=local

[all:vars]
git_user_name=myname
git_user_email=me@example.com
```

Run the ansible playbook (from the extracted directory for this repository)
```Shell
ansible-playbook -vvv basic.yml
```
