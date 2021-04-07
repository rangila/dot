<!-- vim: set colorcolumn=80: -->

# Description

Fish shell configuration and plugins.

## Appreciation list

Follows a list of worthwhile features that caught my eye:

- configuration is minimal, since out-of-the-box defaults are already good
- `$PATH` by default includes modern tools support.
  e.g.: `$HOME/.cargo/bin`
- command suggestion is directory sensitive

## Plugins

Plugin list with basic usage.

### fzf

Fuzzy matching:

<!-- markdownlint-disable MD033 -->

- **file:** <span><kbd>Ctrl</kbd>+<kbd>F</kbd></span>
- **git status:** <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>S</kbd>
- **git commit hash:** <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>L</kbd>
- **history:** <kbd>Ctrl</kbd>+<kbd>R</kbd>
- **shell variable:** <kbd>Ctrl</kbd>+<kbd>V</kbd>

<!-- markdownlint-enable MD033 -->

### z

Smart directory jumping:

<!-- markdownlint-disable MD033 -->

- **jump:** <kbd>z</kbd>+`keyword`
- **jump with alternatives:** <kbd>z</kbd>+`keyword`+<kbd>Tab</kbd>

<!-- markdownlint-enable MD033 -->

### bass

Bash compatibility adapter, mainly to use with `source`:

```bash
bass source /opt/ros/noetic/setup.bash
```

### hydro

Nice and lightweight command prompt.

### fisher

Plugin manager for fish.

## Install

From repository root (e.g.: `~/.dot`)

```bash
mkdir -p $HOME/.config/fish && stow --dotfiles dot -t $HOME/.config/fish -d fish/
fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
git checkout -- fish/dot/fish_plugins && fisher update
```

## Dependencies

### Common

- stow
- curl

### Uncommon

- fish >= 3.2 (repo)

### Dotfiles

- [rust-tools](rust-tools/INSTALL.md)
- [github-tools](github-tools/INSTALL.md)

