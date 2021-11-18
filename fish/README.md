<!-- vim: set colorcolumn=80: -->

# Description

Fish shell configuration and plugins.

## Install

First, install the [dependencies](#dependencies).

From repository root (e.g.: `~/.dot`)

```bash
mkdir -p $HOME/.config/fish && stow --dotfiles dot -t $HOME/.config/fish -d fish/
fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
git checkout -- fish/dot/fish_plugins && fisher update
fish_add_path ~/.cargo/bin
```

## Appreciation list

Follows a list of worthwhile features that caught my eye:

- configuration is minimal, since out-of-the-box defaults are already good
- command suggestion is directory sensitive
- universal (persistent) variables
- shell syntax colors
- guess-complete by default: to me means I have to press just
    <kbd>Ctrl</kbd>+<kbd>e</kbd> most of the times

## Plugins

Plugin list with basic usage.

### fzf

Fuzzy matching:

- **file:** <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>F</kbd>
- **git status:** <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>S</kbd>
- **git commit hash:** <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>L</kbd>
- **history:** <kbd>Ctrl</kbd>+<kbd>R</kbd>
- **shell variable:** <kbd>Ctrl</kbd>+<kbd>V</kbd>

### zoxide

Smart directory jumping:

- **jump:** <kbd>g</kbd>+`keyword`
- **jump with fzf:** <kbd>gi</kbd>+`keyword`

Not really a fish plugin, but comes with [rust-tools](../rust-tools/README.md).
I did reconfigure it to use `g` and `gi` bindings, which seem more
comfortable to me.

### bass

Bash compatibility adapter, mainly to use with `source`:

```bash
bass source /opt/ros/noetic/setup.bash
```

### hydro

Nice and lightweight command prompt.

### fisher

Plugin manager for fish.

## Dependencies

### Common

- stow
- curl

### Uncommon

- fish >= 3.2 (repo)

```bash
sudo add-apt-repository ppa:fish-shell/release-3
```

### Dotfiles

- [rust-tools](../rust-tools/README.md)
- [github-tools](../github-tools/README.md)

