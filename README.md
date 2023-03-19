<!-- vim: set colorcolumn=80: -->

# Dot

## Installation

### Always useful

Aways needed no-config, no-brainer utilities

```bash
sudo apt install vim tmux git openssh-server
```

### Ansible

```bash
sudo apt-add-repository ppa:ansible/ansible && sudo apt install ansible
```

### Generate and upload ssh keys

```bash
ssh-keygen -t ed25519 -C "alekyrylenko@gmail.com"
cat ~/.ssh/id_ed25519.pub
```
