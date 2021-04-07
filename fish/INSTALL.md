<!-- vim: set colorcolumn=80: -->
# Description

Fish shell configuration.

## Install

From repository root (e.g.: `~/.dot`)

```bash
mkdir -p $HOME/.config/fish && stow --dotfiles dot -t $HOME/.config/fish -d fish/
fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
git checkout -- fish/dot/fish_plugins && fisher update
```

## Dependencies

**Common**
- stow
- curl

**Uncommon**
- fish >= 3.2 (repo)

**Dotfiles**
- [rust-tools](rust-tools/INSTALL.md)
