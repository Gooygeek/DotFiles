
# Make local bin folder
mkdir -p ~/.local/bin
cd ~/.local/bin

# Homebrew
# git clone https://github.com/Homebrew/brew homebrew
# eval "$(homebrew/bin/brew shellenv)"
# brew update --force --quiet
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install jq
brew install fzf
brew install ripgrep
brew install fd
brew install starship
brew install shellcheck
# brew install pre-commit

# Post install config

$(brew --prefix)/opt/fzf/install
