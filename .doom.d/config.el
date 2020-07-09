;;; .doom.d/config.el -*- lexical-binding: t; -*-

(after! ivy
  (define-key ivy-minibuffer-map (kbd "<left>") 'counsel-up-directory)
  (define-key ivy-minibuffer-map (kbd "<right>") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "C-<return>") 'ivy-immediate-done)
  )

(define-key prog-mode-map (kbd "C-<tab>") '+fold/toggle)
(define-key prog-mode-map (kbd "C-<") '+fold/close-all)
(define-key prog-mode-map (kbd "C->") '+fold/open-all)

(push (expand-file-name "~/.local/elisp") load-path)
(require 'framemove)
(windmove-default-keybindings 'super)
(setq framemove-hook-into-windmove t)

(custom-set-variables
 '(zoom-mode nil))

(custom-set-variables
 '(zoom-size '(0.618 . 0.618)))

(setq avy-all-windows 'all-frames)
(map! "s-." #'avy-goto-char-timer
      "s-j" #'avy-goto-char)

(after! org
  (setq
   org-confirm-babel-evaluate nil
   org-default-notes-file (expand-file-name "~/org/notes.org")
   org-todo-keywords '((sequence "TODO" "DOING" "|" "DONE" "ARCHIVED")
                       (sequence "QUESTION" "WORKING-ON-IT" "|" "ANSWERED"))
   ;; Roam
   org-roam-graph-viewer "open"
   org-roam-dailies-capture-templates '(("d"
                                         "daily"
                                         plain
                                         (function org-roam-capture--get-point)
                                         :immediate-finish t
                                         :file-name "dailies/%<%Y-%m-%d>"
                                         :head "#+TITLE: %<%Y-%m-%d>"))
   org-roam-tickets-capture-templates '(("t"
                                         "tickets"
                                         plain
                                         (function org-roam-capture--get-point)
                                         "%?"
                                         :file-name "jira-tickets/%<%Y%m%d%H%M%S>-${ticket}"
                                         :head "#+TITLE: ${ticket}\n#+ROAM_KEY: https://tempuslabs.atlassian.net/browse/${ticket}"))
   org-roam-graph-exclude-matcher '("private" "dailies" "jira-tickets")
   )

  (defun org-roam-jira-capture ()
    (interactive)
    (unless org-roam-mode (org-roam-mode))
    (let ((org-roam-capture-templates org-roam-tickets-capture-templates)
          (org-roam-capture--context 'title)
          (org-roam-capture--info (list (cons 'ticket (completing-read "Ticket number: " nil)))))
      (add-hook 'org-capture-after-finalize-hook #'org-roam-capture--find-file-h)
      (org-roam--with-template-error 'org-roam-dailies-capture-templates
        (org-roam-capture--capture))))

  (map! :leader
        :desc "JIRA ticket"
        "n r t"
        #'org-roam-jira-capture)


  (add-hook! 'org-mode-hook :append #'turn-on-auto-fill #'org-indent-mode)
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  )

(after! org
  (map! :map org-mode-map
        "C-<return>" #'org-insert-heading
        "C-M-<right>" #'org-demote-subtree
        "C-M-<left>" #'org-promote-subtree)

  (map! :map org-mode-map :leader
        (:prefix-map ("i" . "insert")
         :desc "drawer" "d" #'org-insert-drawer
         :desc "heading" "h" #'org-insert-heading
         :desc "item" "i" #'org-insert-item
         :desc "link" "l" #'org-insert-link
         :desc "subheading" "s" #'org-insert-subheading
         :desc "template" "t" #'org-insert-structure-template
         ))

  (require 'ox-gfm nil t)
  (require 'ox-twbs nil t)
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
       ;;:desc "multiple cursors" "c" #'hydra-multiple-cursors/body
       :desc "buffer resizing" "r" #'hydra-window-resizing/body
       :desc "jupyter" "j" #'jupyter-org-hydra/body
       :desc "smerge" "m" #'+vc/smerge-hydra/body
       :desc "zoom" "z" #'+hydra/text-zoom/body
       ))

(map! :map smerge-mode-map
      "s-m" #'+vc/smerge-hydra/body)

(map! :map jupyter-org-interaction-mode-map
      "s-h" #'jupyter-org-hydra/body)

(after! python
  (setq conda-anaconda-home (expand-file-name "~/miniconda3"))
  (setq conda-env-home-directory (expand-file-name "~/miniconda3"))
  (setq-default flycheck-disabled-checkers '(python-pylint)))

(after! magit
  (setq magit-commit-show-diff nil)
  )

(after! elfeed
  (setq-default elfeed-search-filter "@2-days-ago -work")
  (map! :map elfeed-show-mode-map
        "a" #'pocket-reader-add-link)
  (map! :map elfeed-search-mode-map
        "a" #'pocket-reader-add-link)
  )

(display-time)

(+global-word-wrap-mode 1)

(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(add-hook! prog-mode :append (subword-mode 1))

(map! [home] #'move-beginning-of-line
      [end] #'move-end-of-line
      "C-x g" #'magit-status
      "s-b" #'projectile-switch-to-buffer
      "s-f" #'swiper
      "s-k" #'kill-current-buffer
      )

(after! smartparens
  (map! :map smartparens-mode-map
        "C-<left>" nil
        "C-<right>" nil
        "M-<left>" nil
        "M-<right>" nil)
  )

(setq doom-font (font-spec :family "Hack" :size 13))

(setq confirm-kill-emacs nil)

(setq doom-theme 'doom-palenight)
(doom/reload-theme)

(setq +zen-text-scale 0)

(setq writeroom-width 120)

(after! gcmh
  (setq gcmh-high-cons-threshold 33554432))
