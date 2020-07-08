install-brew:
	@bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

install-emacs:
	@brew tap railwaycat/emacsmacport
	@brew install emacs-mac --with-modules --with-rsvg
	@cp -r .doom.d ~/.doom.d
	@mkdir -p ~/.local
	@cp -r elisp ~/.local/elisp
	@$(MAKE) install-doom-emacs

install-doom-emacs:
	@git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
	@~/.emacs.d/bin/doom install

install-miniconda:
	@curl -sS https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh > ~/miniconda.sh
	@bash ~/miniconda.sh -b -p $$HOME/miniconda3
	@rm ~/miniconda.sh

install-iterm:
	@open https://www.iterm2.com/downloads.html

install-starship:
	@curl -fsSL https://starship.rs/install.sh | bash
	@echo 'eval "$$(starship init zsh)"' >> ~/.zshrc

install-hack-font:
	@open https://github.com/source-foundry/Hack#macos

install-docker:
	@open https://hub.docker.com/editions/community/docker-ce-desktop-mac/

install-dotfiles:
	@cp -r .zshrc .gitconfig .aliases .envvar ~/

# Brave Browser
# - DarkReader
# - LastPass
# - Vimium
# - Pocket
#
# Spotify
# Pocket Reader
# Spectacle
