;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "Fira Code" :size 12)
      doom-symbol-font (font-spec :family "Apple Symbols" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Avy configuration
(setq avy-all-windows t)
(map! :leader
      "s /" #'avy-goto-char-timer
      :desc "Jump to char (timer)")

(use-package! casual-avy
  :config
  (map! "M-g" #'casual-avy-tmenu))

;; Windmove configuration
(windmove-default-keybindings 'super)

;; Useful shortcut
(map! "s-k" #'kill-current-buffer)

;; Svelte Mode
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . svelte-mode))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(svelte-mode . ("svelteserver" "--stdio"))))


;; TailwindCSS configuration
(after! lsp-tailwindcss
  (setq lsp-tailwindcss-add-on-class-sort t)) ; Enable automatic class sorting

;; gptel configuration
(use-package! gptel
  :config
  (mapcar (apply-partially #'apply #'gptel-make-tool)
          (llm-tool-collection-get-all))

  (map! :localleader
        (:prefix-map ("a" . "AI")
                     "c" #'gptel
                     "s" #'gptel-send
                     "m" #'gptel-menu)))

;; Org
;; Ask me for a note when clocking out
(setq org-log-note-clock-out t)

;; Setting up Claude Code
(use-package! claude-code-ide
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

;; Setting up Aider
(use-package! aider
  :config
  ;; For latest claude sonnet model
  ;; (setq aider-args '("--model" "sonnet" "--no-auto-accept-architect")) ;; add --no-auto-commits if you don't want it
  ;; (setenv "ANTHROPIC_API_KEY" anthropic-api-key)
  ;; (setq aider-args '("--model" "gemini"))
  ;; Or chatgpt model
  (setq aider-args '("--model" "o4-mini"))
  ;; Or use your personal config file
  ;; (setq aider-args `("--config" ,(expand-file-name "~/.aider.conf.yml")))
  ;; ;;
  ;; Optional: Set a key binding for the transient menu
  (global-set-key (kbd "C-c C-a") 'aider-transient-menu) ;; for wider screen
  ;; or use aider-transient-menu-2cols / aider-transient-menu-1col, for narrow screen
  (aider-magit-setup-transients) ;; add aider magit function to magit menu
  ;; auto revert buffer
  (global-auto-revert-mode 1)
  (auto-revert-mode 1))

;; Setting up ACP with agent-shell
(require 'acp)
(require 'agent-shell)
(use-package! agent-shell
  :ensure t
  :ensure-system-package
  ;; Add agent installation configs here
  ((claude . "brew install claude-code")
   (claude-agent-acp . "npm install -g @zed-industries/claude-agent-acp"))
  :init
  ;; Use login-based auth for Claude
  (setq agent-shell-anthropic-authentication
        (agent-shell-anthropic-make-authentication :login t))

  ;; Use login-based auth for Gemini
  (setq agent-shell-google-authentication
        (agent-shell-google-make-authentication :login t))
  )

;; Remove emoji support
(setq doom-emoji-fallback-font-families nil)

(after! embark
  (defun my/update-whisper-project (&rest _)
    (let* ((dir  (embark--default-directory))
           (root (locate-dominating-file dir ".whisper_words.txt")))
      (write-region (if root (expand-file-name (directory-file-name root)) "")
                    nil "/tmp/whisper_active_emacs_project" nil 'quiet)))
  (add-hook 'find-file-hook #'my/update-whisper-project)
  (add-hook 'window-selection-change-functions #'my/update-whisper-project)
  (add-hook 'window-buffer-change-functions #'my/update-whisper-project))
