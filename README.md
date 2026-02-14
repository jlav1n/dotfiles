# dotfiles

## Gemini

Vim will need Python3 for the [Vimini plugin](https://github.com/simo5/vimini).

```
vim --version | grep python
```

If no "python3", then:

```
brew install vim
brew reinstall python@3.12
brew reinstall vim
$(brew --prefix)/opt/python@3.14/bin/python3 -m pip install --break-system-packages google-genai
```

## Submodules

Both `.vim/bundle/` and `.tmux/plugins/` contain Git Submodules.

### To add a new submodule

From the root of the dotfiles repo, run:
```
git submodule add <repo-url> <path/inside/repo>
git commit -am "Add <name> submodule"
```

### To fetch and update submodules on a new machine

```
git submodule update --init --recursive
```

### To install the submodules into your home

```
./link-vim-tmux-plugins.sh
```
