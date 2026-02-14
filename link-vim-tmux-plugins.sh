#!/bin/sh

DOTFILES="$HOME/src/dotfiles"

echo "Initializing Git submodules..."

git submodule update --init --recursive

echo "🔗 Linking dotfiles plugins..."

# Remove existing
rm -rf ~/.tmux/plugins/
rm -rf ~/.vim/bundle/

# Ensure target directories exist
mkdir -p ~/.tmux/plugins
mkdir -p ~/.vim/bundle

# Link tmux plugins
if [ -d "$DOTFILES/.tmux/plugins" ]; then
    echo "  → Linking tmux plugins..."
    find "$DOTFILES/.tmux/plugins" -maxdepth 1 -type d ! -path "$DOTFILES/.tmux/plugins" | while read dir; do
        name=$(basename "$dir")
        ln -sf "$dir" ~/.tmux/plugins/"$name"
        echo "    → $name"
    done
else
    echo "  ⚠️  No .tmux/plugins/ found in dotfiles"
fi

# Link vim plugins  
if [ -d "$DOTFILES/.vim/bundle" ]; then
    echo "  → Linking vim bundle..."
    find "$DOTFILES/.vim/bundle" -maxdepth 1 -mindepth 1 | while read item; do
        name=$(basename "$item")
        ln -sf "$item" ~/.vim/bundle/"$name"
        echo "    → $name"
    done
else
    echo "  ⚠️  No .vim/bundle/ found in dotfiles"
fi

echo "✅ Done! Run: tmux source ~/.tmux.conf && vim +qall"
