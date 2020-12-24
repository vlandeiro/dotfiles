;;; .doom.d/config.el -*- lexical-binding: t; -*-

(define-key prog-mode-map (kbd "C-<tab>") '+fold/toggle)
(define-key prog-mode-map (kbd "C-<") '+fold/close-all)
(define-key prog-mode-map (kbd "C->") '+fold/open-all)

(after! python
  (setq-default flycheck-disabled-checkers '(python-pylint))
  (add-hook! 'python-mode-hook
             :append (anaconda-mode)
             )
  )

(after! ob-jupyter
  (org-babel-jupyter-override-src-block "python")
  )

(after! magit
  (setq magit-commit-show-diff nil)
  )

(after! ivy
  (define-key ivy-minibuffer-map (kbd "<left>") 'counsel-up-directory)
  (define-key ivy-minibuffer-map (kbd "<right>") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "C-<return>") 'ivy-immediate-done)
  )

(push (expand-file-name "~/repos/dotfiles/elisp") load-path)
(require 'framemove)
(windmove-default-keybindings 'super)
(setq framemove-hook-into-windmove t)

(setq avy-all-windows 'all-frames)
(map! :leader
      (:prefix ("m" . "move")
       :desc "by word/subword" "w" #'avy-goto-word-or-subword-1
       :desc "by char" "c" #'avy-goto-char
       :desc "by many characters" "t" #'avy-goto-char-timer
       )
      )

(after! org
  (setq
   org-confirm-babel-evaluate nil
   org-agenda-files '("/Users/virgile/org/todo.org")
   org-default-notes-file (expand-file-name "~/org/notes.org")
   org-todo-keywords '((sequence "TODO" "DOING" "|" "DONE" "ARCHIVED")
                       (sequence "QUESTION" "WORKING-ON-IT" "|" "ANSWERED"))
   )
  (add-hook! 'org-mode-hook :append #'turn-on-auto-fill #'org-indent-mode)
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  )

(after! org
  (setq
   org-roam-graph-viewer "open"
   org-roam-dailies-capture-templates '(("d"
                                         "daily"
                                         plain
                                         (function org-roam-capture--get-point)
                                         :immediate-finish t
                                         :file-name "dailies/%<%Y-%m-%d>"
                                         :head "#+TITLE: %<%Y-%m-%d>"))
   org-roam-graph-exclude-matcher '("private" "dailies" "jira-tickets")
   )
  )

(after! org
  (map! :map org-mode-map
        "C-<return>" #'org-insert-heading
        "C-M-<right>" #'org-demote-subtree
        "C-M-<left>" #'org-promote-subtree
        )

  (map! :map org-mode-map :leader
        (:prefix-map ("i" . "insert")
         :desc "drawer" "d" #'org-insert-drawer
         :desc "heading" "h" #'org-insert-heading
         :desc "item" "i" #'org-insert-item
         :desc "link" "l" #'org-insert-link
         :desc "subheading" "s" #'org-insert-subheading
         :desc "template" "t" #'org-insert-structure-template
         ))
  )

(after! org
  (require 'ox-gfm nil t)
  (require 'ox-twbs nil t)
  (require 'ox-rst nil t)
  )

(after! elfeed
  (setq-default elfeed-search-filter "@2-days-ago -work")
  (map! :map elfeed-show-mode-map
        "a" #'pocket-reader-add-link)
  (map! :map elfeed-search-mode-map
        "a" #'pocket-reader-add-link)
  )

(setq +zen-text-scale 0)

(setq writeroom-width 120)

(setq ob-mermaid-cli-path (executable-find "mmdc"))

(after! treemacs
  (map! :map treemacs-mode-map
        "SPC" #'treemacs-peek)
  )

(map! :leader
      :desc "treemacs" "t t" #'treemacs)

(map! [home] #'move-beginning-of-line
      [end] #'move-end-of-line
      "C-x g" #'magit-status
      "s-k" #'doom/kill-this-buffer-in-all-windows
      "C-/" #'company-filter-candidates
      )

(after! smartparens
  (map! :map smartparens-mode-map
        "C-<left>" nil
        "C-<right>" nil
        "M-<left>" nil
        "M-<right>" nil)
  )

(defhydra hydra-window-resizing (:hint nil)
  "
Resizing frames
---------------
  [→] + horizontal
  [←] - horizontal
  [↑] + vertical
  [↓] - vertical
"
  ("<up>" enlarge-window)
  ("<down>" shrink-window)
  ("<right>" enlarge-window-horizontally)
  ("<left>" shrink-window-horizontally)
  )

(map! :leader
      (:prefix-map ("h" . "hydras")
       :desc "buffer resizing" "r" #'hydra-window-resizing/body
       :desc "jupyter" "j" #'jupyter-org-hydra/body
       :desc "smerge" "m" #'+vc/smerge-hydra/body
       :desc "zoom" "z" #'+hydra/text-zoom/body
       ))

(map! :map smerge-mode-map
      "s-m" #'+vc/smerge-hydra/body)

(map! :map org-mode-map
      "s-h" #'jupyter-org-hydra/body)

(+global-word-wrap-mode 1)

(global-subword-mode)

(display-time)

(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(setq confirm-kill-emacs nil)

(after! gcmh
  (setq gcmh-high-cons-threshold 33554432))

(map! :leader
      :desc "Show popup" "t p" #'+popup/toggle
      )

(load-theme 'doom-palenight t)
(setq doom-themes-enable-bold nil)
(set-face-bold-p 'bold nil)

(setq mixed-pitch-set-height t)
(setq doom-font (font-spec :family "Hack" :size 13)
      doom-variable-pitch-font (font-spec :family "Lora" :size 14)
      )
(doom/reload-font)
