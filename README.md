<!-- vim: set colorcolumn=80: -->

# Dot

## Installation

### Always useful

Aways needed no-config, no-brainer utilities

```bash
sudo apt install vim tmux git openssh-server curl
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

### Docker

```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo gpasswd -a rangila docker
```


