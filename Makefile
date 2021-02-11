install-brew:
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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
