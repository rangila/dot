<!-- vim: set colorcolumn=80: -->

# Description

Graphical terminal emulator related themes and configurations

## Install

First, install the [dependencies](#dependencies).

From repository root (e.g.: `~/.dot`)

```bash
stow --dotfiles dot -t $HOME -d terminal
```

Configure pinentry

```bash
sudo update-alternatives --config pinentry
```

## Dependencies

### Common

- rxvt-unicode
- fonts-hack

