;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)

;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name
;;         "straight/repos/straight.el/bootstrap.el"
;;         (or (bound-and-true-p straight-base-dir)
;;             user-emacs-directory)))
;;       (bootstrap-version 7))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))

;; (straight-use-package 'use-package)
;; (eval-when-compile (require 'use-package))

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq native-comp-async-report-warnings-errors nil)

(add-to-list 'load-path "~/.config/emacs/lisp/")

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-dired)

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(setq inhibit-startup-message t)
(setq fast-but-imprecise-scrolling 1)
(setq use-file-dialog nil)   ;; No file dialog
(setq use-dialog-box nil)    ;; No dialog box
(setq pop-up-windows nil)    ;; No popup window
(setq visible-bell 0)
(setq use-dialog-box nil)    ;; No dialog box
(setq pixel-scroll-precision-mode t)
(scroll-bar-mode 1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 30)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar
(recentf-mode 1) ; use spc f r to invoke recentf-open-files
(save-place-mode 1)
(global-visual-line-mode t)
(column-number-mode)
(global-display-line-numbers-mode t)
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(defalias 'yes-or-no-p 'y-or-n-p)
(auto-save-visited-mode t)
(delete-selection-mode 1)

;; Remove messages from the *Messages* buffer.
(setq-default message-log-max nil)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Remove messages from the *Messages* buffer.
(setq-default message-log-max nil)

;; Kill both buffers on startup.
(kill-buffer "*Messages*")
(kill-buffer "*scratch*")

;; Empty the *scratch* buffer.
(setq initial-scratch-message "")

(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative keys: M-p, M-+, ...
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; Merge the dabbrev, dict and keyword capfs, display candidates together.
  (setq-local completion-at-point-functions
              (list (cape-capf-super #'cape-dabbrev #'cape-dict #'cape-keyword))))

(use-package citar
  :init
  (setq citar-templates
    '((main . "${author editor:30%sn}     ${date year issued:4}     ${title:48}")
     (suffix . "          ${=key= id:15}    ${=type=:12}    ${tags keywords:*}")
     (preview . "${author editor:%etal} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
     (note . "Notes on ${author editor:%etal}, ${title}"))) 

  :custom
  (citar-bibliography '("~/Dropbox/Documents/Project1/references.bib"))
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup))

(use-package citar-denote
  :demand t ;; Ensure minor mode loads
  :after (:any citar denote)
  :custom
  ;; Package defaults
  (citar-denote-file-type 'org)
  (citar-denote-keyword "bib")
  (citar-denote-signature nil)
  (citar-denote-subdir nil)
  (citar-denote-template nil)
  (citar-denote-title-format "title")
  (citar-denote-title-format-andstr "and")
  (citar-denote-title-format-authors 1)
  (citar-denote-use-bib-keywords nil)
  :preface
  (bind-key "C-c w n" #'citar-denote-open-note)
  :init
  (citar-denote-mode))

(use-package citar-embark
  :after (citar embark)
  :config (citar-embark-mode))

(use-package consult
  :init
  (setq completion-in-region-function #'consult-completion-in-region)
  (keymap-global-set "C-s" 'consult-line)
  (keymap-set minibuffer-local-map "C-r" 'consult-history))

(use-package consult-denote
  :after (denote consult)
  :config
  (consult-denote-mode 1))

(use-package consult-notes
  :vc (:fetcher github
		:repo mclear-tools/consult-notes)
  :commands (consult-notes
             consult-notes-search-in-all-notes)
  :config


  (setq consult-notes-file-dir-sources
	`(("Denote Notes"  ?d ,(denote-directory))
          ("Books"  ?b "~/Documents/books/")))


  ;; Set org-roam integration, denote integration, or org-heading integration e.g.:
  (consult-notes-org-headings-mode)
  (when (locate-library "denote")
    (consult-notes-denote-mode))
  ;; search only for text files in denote dir
  (setq consult-notes-denote-files-function (function denote-directory-text-only-files)))

;; (use-package corfu
;;   :init
;;   (global-corfu-mode)
;;   :config
;;   (setq corfu-cycle t)
;;   (setq corfu-auto t)
;;   (setq corfu-auto-prefix 2)
;;   (setq corfu-on-exact-match 'insert)
;;   (setq corfu-preselect 'prompt)
;;   (setq corfu-quit-no-match t)
;;   (setq corfu-popupinfo-mode t))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)               
  (corfu-auto t)                
  (corfu-preview-current nil)   
  (corfu-echo-documentation t)
  (corfu-preselect 'prompt)
  (corfu-scroll-margin 5)
  :init
  (global-corfu-mode))

(add-hook 'corfu-mode-hook #'corfu-popupinfo-mode)

;; A few more useful configurations...
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package evil-nerd-commenter
  :after evil)

(use-package dabbrev
  :custom
  (dabbrev-upcase-means-case-search t)
  (dabbrev-check-all-buffers nil)
  (dabbrev-check-other-buffers t)
  (dabbrev-friend-buffer-function 'dabbrev--same-major-mode-p)
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))

(use-package dashboard
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-startup-banner "~/.config/emacs/art/ascii.txt")    
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(use-package denote
  :after org)

;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/Dropbox/Documents/notes/"))
(setq denote-save-buffers nil)
(setq denote-known-keywords '("emacs" "philosophy" "politics" "economics"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type nil) ; Org is the default, set others here
(setq denote-prompts '(title keywords))
(setq denote-excluded-directories-regexp nil)
(setq denote-excluded-keywords-regexp nil)
(setq denote-rename-confirmations '(rewrite-front-matter modify-file-name))

;; Pick dates, where relevant, with Org's advanced interface:
(setq denote-date-prompt-use-org-read-date t)


;; Read this manual for how to specify `denote-templates'.  We do not
;; include an example here to avoid potential confusion.


(setq denote-date-format nil) ; read doc string

;; By default, we do not show the context of links.  We just display
;; file names.  This provides a more informative view.
(setq denote-backlinks-show-context t)

;; Also see `denote-backlinks-display-buffer-action' which is a bit
;; advanced.

;; If you use Markdown or plain text files (Org renders links as buttons
;; right away)
(add-hook 'text-mode-hook #'denote-fontify-links-mode-maybe)

;; We use different ways to specify a path for demo purposes.
(setq denote-dired-directories
      (list denote-directory
            (thread-last denote-directory (expand-file-name "attachments"))
            (expand-file-name "~/Documents/books")))

;; Generic (great if you rename files Denote-style in lots of places):
;; (add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR if only want it in `denote-dired-directories':
(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)


;; Automatically rename Denote buffers using the `denote-rename-buffer-format'.
(denote-rename-buffer-mode 1)

(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))

;; Also check the commands `denote-link-after-creating',
;; `denote-link-or-create'.  You may want to bind them to keys as well.


;; If you want to have Denote commands available via a right click
;; context menu, use the following and then enable
;; `context-menu-mode'.
(add-hook 'context-menu-functions #'denote-context-menu)

(use-package denote-explore
  :after denote
  :custom
  ;; Location of graph files
  (denote-explore-network-directory "~/documents/notes/graphs/")
  (denote-explore-network-filename "denote-network")
  ;; Output format
  (denote-explore-network-format 'graphviz)
  (denote-explore-network-graphviz-filetype "svg")
  ;; Exlude keywords or regex
  (denote-explore-network-keywords-ignore '("bib")))

(defun my/denote-insert-category (category)
  (save-excursion
    (beginning-of-buffer)
    (while (and
            (< (point) (point-max))
            (string= "#+"
                    (buffer-substring-no-properties
                     (point-at-bol)
                     (+ (point-at-bol) 2))))
      (next-line))

    (insert "#+category: " category)
    (save-buffer)))

(defun my/denote-create-topic-note ()
  (interactive)
  (let* ((topic-files (mapcar (lambda (file)
                                (cons (denote-retrieve-front-matter-title-value file 'org)
                                      file))
                              (denote-directory-files-matching-regexp "_kt")))
         (selected-topic (completing-read "Select topic: "
                                          (mapcar #'car topic-files))))

    (denote (denote-title-prompt (format "%s: " selected-topic))
            (denote-keywords-prompt))

    ;(my/denote-insert-category selected-topic)
    ))

(defun my/denote-extract-subtree ()
  (interactive)
  (save-excursion
    (if-let ((text (org-get-entry))
             (heading (denote-link-ol-get-heading)))
        (progn
          (delete-region (org-entry-beginning-position)
                         (save-excursion (org-end-of-subtree t) (point)))
          (denote heading (denote-keywords-prompt) 'org)
          (insert text)))))

(defvar my/denote-keywords
  '(("pra" . "Active Project")
    ("prb" . "Backlogged Project")
    ("prc" . "Closed Project")))

(defun my/denote-custom-affixation (completions)
  (mapcar (lambda (completion)
            (list completion
                  ""
                  (alist-get completion
                             my/denote-keywords
                             nil
                             nil
                             #'string=)))
          completions))

(defun my/denote-keyword-prompt ()
  (let ((completion-extra-properties
         (list :affixation-function
               #'my/denote-custom-affixation)))
    (denote-keywords-prompt)))

(use-package denote-menu)

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

;; (use-package dirvish
;;   :straight t
;;   :init
;;   (dirvish-override-dired-mode)
;;   :custom
;;   (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
;;    '(("h" "~/"                          "Home")
;;      ("d" "~/Downloads/"                "Downloads")
;;      ("m" "/mnt/"                       "Drives")
;;      ("t" "~/.local/share/Trash/files/" "TrashCan")))
;;   :config
;;   ;; (dirvish-peek-mode) ; Preview files in minibuffer
;;   ;; (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
;;   (setq dirvish-mode-line-format
;;         '(:left (sort symlink) :right (omit yank index)))
;;   (setq dirvish-attributes
;;         '(all-the-icons file-time file-size collapse subtree-state vc-state git-msg))
;;   (setq delete-by-moving-to-trash t)
;;   (setq dired-listing-switches
;;         "-l --almost-all --human-readable --group-directories-first --no-group"))

(use-package drag-stuff
  :init
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package eglot
  :defer t
  :custom
  (read-process-output-max (* 1024 1024))
  (eldoc-echo-area-use-multiline-p)
  (eglot-autoshutdown t)
  :hook ((bash-ts-mode . eglot-ensure)
         (c-ts-mode-hook . eglot-ensure)
         (c++-ts-mode-hook . eglot-ensure)
         (clojure-mode . eglot-ensure)
         (css-ts-mode-hook . eglot-ensure)
         (dockerfile-ts-mode . eglot-ensure)
         (html-mode-hook . eglot-ensure)
         (java-ts-mode . eglot-ensure)
         (js-ts-mode-hook . eglot-ensure)
         (tsx-ts-mode-hook . eglot-ensure)
         (json-ts-mode . eglot-ensure)
         (latex-mode-hook . eglot-ensure)
         (markdown-mode . eglot-ensure)
         (cperl-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure)
         (rust-ts-mode-hook . eglot-ensure)
         (yaml-ts-mode . eglot-ensure))
  :config
  (setq eglot-workspace-configuration
        '((:pylsp .
                  (:configurationSources
                   ["flake8"]
                   :plugins (:pycodestyle (:enabled :json-false)
                                          :mccabe (:enabled :json-false)
                                          :pyflakes (:enabled :json-false)
                                          :flake8
                                          (:enabled :json-false
                                                    :maxLineLength 80)
                                          :ruff
                                          (:enabled t :lineLength 80)
                                          :pydocstyle
                                          (:enabled t :convention "numpy")
                                          :yapf (:enabled :json-false)
                                          :autopep8 (:enabled :json-false)
                                          :black
                                          (:enabled t
                                                    :line_length 80
                                                    :cache_config t)))))))

(use-package eglot-booster 
  :after eglot
  :vc (:fetcher github :repo jdtsmith/eglot-booster)
  :config
  (eglot-booster-mode))

(with-eval-after-load 'eglot
  (setq completion-category-defaults nil))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package embark
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  (use-package embark-consult
    :hook
    (embark-collect-mode . consult-preview-at-point-mode)))

(use-package evil
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t  ;; This is optional since it's already set to t by default.
          evil-want-keybinding nil
          evil-vsplit-window-right t
          evil-split-window-below t
          evil-undo-system 'undo-redo)  ;; Adds vim-like C-r redo functionality
    (evil-mode))

(use-package evil-collection
  :after evil
  :config
  ;; Do not uncomment this unless you want to specify each and every mode
  ;; that evil-collection should works with.  The following line is here 
  ;; for documentation purposes in case you need it.  
  ;; (setq evil-collection-mode-list '(calendar dashboard dired ediff info magit ibuffer))
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))

(use-package evil-tutor)

;; Using RETURN to follow links in Org/Evil 
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
(setq org-return-follows-link  t)
(setq evil-kill-on-visual-paste nil)

(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-mode)

  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces))

(use-package eshell-toggle
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-function #'eshell-toggle-init-ansi-term))

  (use-package eshell-syntax-highlighting
    :after esh-mode
    :config
    (eshell-syntax-highlighting-global-mode +1))

  ;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
  ;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
  ;; eshell-aliases-file -- sets an aliases file for the eshell.

  (setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
        eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
        eshell-history-size 5000
        eshell-buffer-maximum-lines 5000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t
        eshell-destroy-buffer-when-process-dies t
        eshell-visual-commands'("bash" "btop" "ssh" "zsh"))

(defun efs/set-font-faces ()
  (message "Setting faces!")
  (set-face-attribute 'default nil
		      :font "JetBrains Mono"
		      :height 115
		      :weight 'medium)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil
		      :font "JetBrains Mono"
		      :height 115
		      :weight 'medium)

  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil
		      :font "Ubuntu"
		      :height 115
		      :weight 'medium))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (setq doom-modeline-icon t)
                (with-selected-frame frame
                  (efs/set-font-faces))))
  (efs/set-font-faces));; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci")))))

(use-package flycheck
  :defer t
  :diminish
  :init (global-flycheck-mode))

(use-package general
  :config
  (general-evil-setup)
    ;; set up 'SPC' as the global leader key
  (general-create-definer ar/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC")

(ar/leader-keys
  "SPC" '(execute-extended-command :wk "M-x")
  "f f" '(find-file :wk "Find file")
  "/" '(evilnc-comment-or-uncomment-lines :wk "Comment lines")
  "u" '(universal-argument :wk "Universal argument"))

(ar/leader-keys
  "b" '(:ignore t :wk "Bookmarks/Buffers")
  "b b" '(switch-to-buffer :wk "Switch to buffer")
  "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
  "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
  "b d" '(bookmark-delete :wk "Delete bookmark")
  "b i" '(ibuffer :wk "Ibuffer")
  "b k" '(kill-current-buffer :wk "Kill current buffer")
  "b K" '(kill-some-buffers :wk "Kill multiple buffers")
  "b l" '(list-bookmarks :wk "List bookmarks")
  "b m" '(bookmark-set :wk "Set bookmark")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer")
  "b R" '(rename-buffer :wk "Rename buffer")
  "b s" '(basic-save-buffer :wk "Save buffer")
  "b S" '(save-some-buffers :wk "Save multiple buffers")
  "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))

(ar/leader-keys
  :keymaps 'global-map
  "n" '(:ignore t :wk "Denote")
  "n c" '(denote-region :wk "denote-region")
  "n N" '(denote-type :wk "denote-type")
  "n d" '(denote-date :wk "denote-date")
  "n z" '(denote-signature :wk "denote-signature")
  "n s" '(denote-subdirectory :wk "denote-subdirectory")
  "n t" '(denote-template :wk "denote-template")
  "n i" '(denote-link :wk "denote-link")
  "n I" '(denote-add-links :wk "denote-add-links")
  "n b" '(denote-backlinks :wk "denote-backlinks")
  "n r" '(denote-rename-file :wk "denote-rename-file")
  "n R" '(denote-rename-file-using-front-matter :wk "denote-rename-file-using-front-matter")
  "n f f" '(denote-find-link :wk "denote-find-link");; ask reddit about making f not appear as prefix in which-ke
  "n f b" '(denote-find-backlink :wk "denote-find-backlink"))

(ar/leader-keys
  "d" '(:ignore t :wk "Dired/Denote")
  "d d" '(dired :wk "Open dired")
  "d f" '(wdired-finish-edit :wk "Writable dired finish edit")
  "d i" '(denote-link-dired-marked-notes :wk "denote-link-dired-marked-notes")
  "d j" '(dired-jump :wk "Dired jump to current")
  "d k" '(denote-dired-rename-marked-files-with-keywords :wk "denote-dired-rename-marked-files-with-keywords")
  "d n" '(neotree-dir :wk "Open directory in neotree")
  "d p" '(peep-dired :wk "Peep-dired")
  "d r" '(denote-dired-rename-files :wk "denote-dired-rename-files")
  "d R" '(denote-dired-rename-marked-files-using-front-matter :wk "denote-dired-rename-marked-files-using-front-matter")
  "d w" '(wdired-change-to-wdired-mode :wk "Writable dired"))

(ar/leader-keys
  "e" '(:ignore t :wk "Ediff/Eshell/Eval/EWW")    
  "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
  "e d" '(eval-defun :wk "Evaluate defun containing or after point")
  "e e" '(eval-expression :wk "Evaluate and elisp expression")
  "e f" '(ediff-files :wk "Run ediff on a pair of files")
  "e F" '(ediff-files3 :wk "Run ediff on three files")
  "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
  "e r" '(eval-region :wk "Evaluate elisp in region")
  "e s" '(eshell :which-key "Eshell"))

(ar/leader-keys
  "f" '(:ignore t :wk "Files")    
  "f p" '((lambda () (interactive)
            (find-file "~/.config/emacs/Emacs.org")) 
          :wk "Open emacs config.org")
  "f e" '((lambda () (interactive)
            (dired "~/.config/emacs/")) 
          :wk "Open user-emacs-directory in dired")
  "f d" '(find-grep-dired :wk "Search for string in files in DIR")
  "f i" '((lambda () (interactive)
            (find-file "~/.config/emacs/init.el")) 
          :wk "Open emacs init.el"))

(ar/leader-keys
  :keymaps 'global-map
  "h" '(:ignore t :wk "Helpful")
  "h d" '(helpful-at-point :wk "helpful-at-point")
  "h f" '(helpful-callable :wk "helpful-callable")
  "h F" '(helpful-function :wk "helpful-function")
  "h v" '(helpful-variable :wk "helpful-variable"  )
  "h k" '(helpful-key :wk "helpful-key")
  "h x" '(helpful-command :wk "helpful-command"))

(ar/leader-keys
  "g" '(:ignore t :wk "Git")    
  "g /" '(magit-displatch :wk "Magit dispatch")
  "g ." '(magit-file-displatch :wk "Magit file dispatch")
  "g b" '(magit-branch-checkout :wk "Switch branch")
  "g c" '(:ignore t :wk "Create") 
  "g c b" '(magit-branch-and-checkout :wk "Create branch and checkout")
  "g c c" '(magit-commit-create :wk "Create commit")
  "g c f" '(magit-commit-fixup :wk "Create fixup commit")
  "g C" '(magit-clone :wk "Clone repo")
  "g f" '(:ignore t :wk "Find") 
  "g f c" '(magit-show-commit :wk "Show commit")
  "g f f" '(magit-find-file :wk "Magit find file")
  "g f g" '(magit-find-git-config-file :wk "Find gitconfig file")
  "g F" '(magit-fetch :wk "Git fetch")
  "g g" '(magit-status :wk "Magit status")
  "g i" '(magit-init :wk "Initialize git repo")
  "g l" '(magit-log-buffer-file :wk "Magit buffer log")
  "g r" '(vc-revert :wk "Git revert file")
  "g s" '(magit-stage-file :wk "Git stage file")
  "g t" '(git-timemachine :wk "Git time machine")
  "g u" '(magit-stage-file :wk "Git unstage file"))

(ar/leader-keys
  "m" '(:ignore t :wk "Org")
  "m a" '(org-agenda :wk "Org agenda")
  "m e" '(org-export-dispatch :wk "Org export dispatch")
  "m i" '(org-toggle-item :wk "Org toggle item")
  "m t" '(org-todo :wk "Org todo")
  "m B" '(org-babel-tangle :wk "Org babel tangle")
  "m T" '(org-todo-list :wk "Org todo list"))

(ar/leader-keys
  "m b" '(:ignore t :wk "Tables")
  "m b -" '(org-table-insert-hline :wk "Insert hline in table"))

(ar/leader-keys
  "m d" '(:ignore t :wk "Date/deadline")
  "m d t" '(org-time-stamp :wk "Org time stamp"))

(ar/leader-keys
  "t" '(:ignore t :wk "Toggle")
  "t e" '(eshell-toggle :wk "Toggle eshell")
  "t f" '(flycheck-mode :wk "Toggle flycheck")
  "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
  "t n" '(neotree-toggle :wk "Toggle neotree file viewer")
  "t o" '(org-mode :wk "Toggle org mode")
  "t r" '(rainbow-mode :wk "Toggle rainbow mode")
  "t t" '(visual-line-mode :wk "Toggle truncated lines")
  "t v" '(vterm-toggle :wk "Toggle vterm"))

(ar/leader-keys
  "w" '(:ignore t :wk "Windows/Words")
  ;; Window splits
  "w c" '(evil-window-delete :wk "Close window")
  "w n" '(evil-window-new :wk "New window")
  "w s" '(evil-window-split :wk "Horizontal split window")
  "w v" '(evil-window-vsplit :wk "Vertical split window")
  ;; Window motions
  "w <left>" '(evil-window-left :wk "Window left")
  "w <down>" '(evil-window-down :wk "Window down")
  "w <up>" '(evil-window-up :wk "Window up")
  "w <right>" '(evil-window-right :wk "Window right")
  "w w" '(evil-window-next :wk "Goto next window")
  ;; Move Windows
  "w H" '(buf-move-left :wk "Buffer move left")
  "w J" '(buf-move-down :wk "Buffer move down")
  "w K" '(buf-move-up :wk "Buffer move up")
  "w L" '(buf-move-right :wk "Buffer move right")
  ;; Words
  "w d" '(downcase-word :wk "Downcase word")
  "w u" '(upcase-word :wk "Upcase word")
  "w =" '(count-words :wk "Count words/lines for buffer"))

)

(use-package git-timemachine
  :hook (evil-normalize-keymaps . git-timemachine-hook)
  :config
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-<down>") 'git-timemachine-show-previous-revision)
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-<up>") 'git-timemachine-show-next-revision))

(use-package helpful)

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

;; (keymap-set hl-todo-mode-map "C-c p" #'hl-todo-previous)
;; (keymap-set hl-todo-mode-map "C-c n" #'hl-todo-next)
;; (keymap-set hl-todo-mode-map "C-c o" #'hl-todo-occur)
;; (keymap-set hl-todo-mode-map "C-c i" #'hl-todo-insert)

(use-package highlight-indent-guides
  :hook ((prog-mode . highlight-indent-guides-mode)
	 (LaTeX-mode . highlight-indent-guides-mode))
  :config
  (setq highlight-indent-guides-method 'bitmap)
  (setq highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line))

(use-package rainbow-mode
  :commands (rainbow-mode))

(use-package ibuffer-project
  :config
  (add-hook
   'ibuffer-hook
   (lambda ()
     (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
     (unless (eq ibuffer-sorting-mode 'project-file-relative)
       (ibuffer-do-sort-by-project-file-relative)))))

(use-package aggressive-indent
  :init
  (global-aggressive-indent-mode 1))

(use-package auctex
  :defer t
  :config
  (setq-default TeX-auto-save t)
  (setq-default TeX-parse-self t)
  (TeX-PDF-mode)
  ;; Use XeLaTeX & stuff
  (setq-default TeX-engine 'xetex)
  (setq-default TeX-command-extra-options "-shell-escape")
  (setq-default TeX-source-correlate-method 'synctex)
  (TeX-source-correlate-mode)
  (setq-default TeX-source-correlate-start-server t)
  (setq-default LaTeX-math-menu-unicode t)

  (setq-default font-latex-fontify-sectioning 1.3)

  ;; Scale preview for my DPI
  (setq-default preview-scale-function 1.4)
  (when (boundp 'tex--prettify-symbols-alist)
    (assoc-delete-all "--" tex--prettify-symbols-alist)
    (assoc-delete-all "---" tex--prettify-symbols-alist))

  (add-hook 'LaTeX-mode-hook
	    (lambda ()
	      (TeX-fold-mode 1)
	      (outline-minor-mode)))

  (add-to-list 'TeX-view-program-selection
	       '(output-pdf "Zathura"))

  ;; Do not run lsp within templated TeX files
  (add-hook 'LaTeX-mode-hook
	    (lambda ()
	      (unless (string-match "\.hogan\.tex$" (buffer-name))
		(lsp))
	      (setq-local lsp-diagnostic-package :none)
	      (setq-local flycheck-checker 'tex-chktex)))

  (add-hook 'LaTeX-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'LaTeX-mode-hook #'smartparens-mode)
  (add-hook 'LaTeX-mode-hook #'prettify-symbols-mode)

  (my/set-smartparens-indent 'LaTeX-mode)
  (require 'smartparens-latex)

  (general-nmap
    :keymaps '(LaTeX-mode-map latex-mode-map)
    "RET" 'TeX-command-run-all
    "C-c t" 'orgtbl-mode)

  <<init-greek-latex-snippets>>
  <<init-english-latex-snippets>>
  <<init-math-latex-snippets>>
  <<init-section-latex-snippets>>)

(use-package auctex-latexmk
  :after auctex
  :init
  (auctex-latexmk-setup)
  :config
  (setq auctex-latexmk-inherit-TeX-PDF-mode t))

(use-package cdlatex
  :diminish 'org-cdlatex-mode
  :hook ((LaTeX-mode . turn-on-cdlatex)
         (org-mode . turn-on-org-cdlatex)))

(use-package ligature
  :vc (:fetcher github :repo mickeynp/ligature.el)
  :if (display-graphic-p)
  :config
  (ligature-set-ligatures
   '(latex-mode
     typescript-mode
     typescript-ts-mode
     js2-mode
     javascript-ts-mode
     vue-mode
     svelte-mode
     scss-mode
     php-mode
     python-mode
     python-ts-mode
     js-mode
     markdown-mode
     clojure-mode
     go-mode
     sh-mode
     haskell-mode
     web-mode)
   '("--" "---" "==" "===" "!=" "!==" "=!=" "=:=" "=/=" "<="
     ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!" "??"
     "?:" "?." "?=" "<:" ":<" ":>" ">:" "<>" "<<<" ">>>"
     "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##"
     "###" "####" "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:"
     "#!" "#=" "^=" "<$>" "<$" "$>" "<+>" "<+" "+>" "<*>"
     "<*" "*>" "</" "</>" "/>" "<!--" "<#--" "-->" "->" "->>"
     "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>" "==>" "=>"
     "=>>" ">=>" ">>=" ">>-" ">-" ">--" "-<" "-<<" ">->" "<-<"
     "<-|" "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>"
     "~>" "~-" "-~" "~@" "[||]" "|]" "[|" "|}" "{|" "[<"
     ">]" "|>" "<|" "||>" "<||" "|||>" "<|||" "<|>" "..." ".."
     ".=" ".-" "..<" ".?" "::" ":::" ":=" "::=" ":?" ":?>"
     "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__"))
  (global-ligature-mode t))

(global-display-line-numbers-mode -1)

(setq-default display-line-numbers-grow-only t
              display-line-numbers-width 2)

;; Enable line numbers for some modes
(dolist (mode '(prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode t))))

(use-package magit)

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode 1))

(global-set-key [escape] 'keyboard-escape-quit)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  (setq doom-modeline-height 35
	doom-modeline-icon t
	doom-modeline-major-mode-icon t
	doom-modeline-lsp-icon t
	doom-modeline-time-icon t
	doom-modeline-enable-word-count t
	doom-modeline-vcs-icon t))

;; (use-package modus-themes)

;; ;;Configure the Modus Themes' appearance
;; (setq modus-themes-mode-line '(accented borderless)
;; 	modus-themes-bold-constructs t
;; 	modus-themes-italic-constructs t
;; 	modus-themes-fringes 'subtle
;; 	modus-themes-tabs-accented t
;; 	modus-themes-paren-match '(bold intense)
;; 	modus-themes-prompts '(bold intense)
;; 	modus-themes-org-blocks 'tinted-background
;; 	modus-themes-scale-headings t
;; 	modus-themes-region '(bg-only)
;; 	modus-themes-headings
;; 	'((1 . (rainbow overline background 1.4))
;; 	  (2 . (rainbow background 1.3))
;; 	  (3 . (rainbow bold 1.2))
;; 	  (t . (semilight 1.1))))


;; (setq modus-themes-completions
;; 	'((matches . (extrabold underline))
;; 	  (selection . (semibold italic))))

;; ;; Load the dark theme by default
;; (load-theme 'modus-vivendi-tinted t)

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 30
        neo-window-fixed-size nil
	neo-theme (if (display-graphic-p) 'nerd 'icons 'arrow)

        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

;;(use-package all-the-icons-nerd-fonts)

(use-package nerd-icons)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :commands (nerd-icons-completion-mode)
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup)
  :config
  (nerd-icons-completion-mode))

(use-package nerd-icons-corfu
  :ensure t
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nix-mode 
  :mode "\\.nix\\'")

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package org
  :pin org
  :defer t
  :config
  (setq org-agenda-files '("~/org")
        org-ellipsis " ▾"
        org-src-preserve-indentation t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
	visual-line-mode t))

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(setq org-confirm-babel-evaluate nil
      org-confirm-elisp-link-function nil
      org-link-shell-confirm-function nil)

(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
      (python . t)
      (shell . t)
      (org . t)
      (latex . t)
      (sqlite . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(require 'org-block-capf)
(with-eval-after-load 'org
  (add-hook 'org-mode-hook #'org-block-capf-add-to-completion-at-point-functions))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.27))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.23))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.17))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.13))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

(electric-pair-mode 1)

(defun crafted-org-enhance-electric-pair-inhibit-predicate ()
  "Disable auto-pairing of \"<\" in `org-mode' when using `electric-pair-mode'."
  (when (and electric-pair-mode (eql major-mode #'org-mode))
    (setq-local electric-pair-inhibit-predicate
                `(lambda (c)
                   (if (char-equal c ?<)
                       t
                     (,electric-pair-inhibit-predicate c))))))

;;; Electric Pair Mode
;; Add hook to both electric-pair-mode-hook and org-mode-hook
;; This ensures org-mode buffers don't behave weirdly,
;; no matter when electric-pair-mode is activated.
(add-hook 'electric-pair-mode-hook #'crafted-org-enhance-electric-pair-inhibit-predicate)
(add-hook 'org-mode-hook #'crafted-org-enhance-electric-pair-inhibit-predicate)

(use-package org-fancy-priorities
  :after org
  :init
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '((?A . "❗")
                                  (?B . "⬆")
                                  (?C . "⬇")
                                  (?D . "☕")
                                  (?1 . "⚡")
                                  (?2 . "⮬")
                                  (?3 . "⮮")
                                  (?4 . "☕")
                                  (?I . "Important"))))

(defun my-auto-lightweight-mode ()
  "Start Org Superstar differently depending on the number of lists items."
  (let ((list-items
         (count-matches "^[ \t]*?\\([+-]\\|[ \t]\\*\\)"
                        (point-min) (point-max))))
    (unless (< list-items 100)
      (org-superstar-toggle-lightweight-lists)))
  (org-superstar-mode))

(use-package org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
;; This is usually the default, but keep in mind it must be nil
(setq org-hide-leading-stars nil)
;; This line is necessary.
(setq org-superstar-leading-bullet ?\s)
;; If you use Org Indent you also need to add this, otherwise the
;; above has no effect while Indent is enabled.
(setq org-indent-mode-turns-on-hiding-stars nil)
(setq inhibit-compacting-font-caches t)
(add-hook 'org-mode-hook #'my-auto-lightweight-mode)

(require 'org-inlinetask)
(setq org-inlinetask-show-first-star t)
;; Less gray please.
(set-face-attribute 'org-inlinetask nil
                    :foreground nil
		      :inherit 'bold)
(with-eval-after-load 'org-superstar
  (set-face-attribute 'org-superstar-first nil
                     :foreground "#9000e1"))

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

(use-package prescient
  :commands (prescient-persist-mode)
  :config
  (setq-default history-length 1000)
  (setq-default prescient-history-length 1000) ;; More prescient history
  (prescient-persist-mode +1))

;(global-prettify-symbols-mode t)

(defun my/org-mode/load-prettify-symbols ()
  (interactive)
  (setq prettify-symbols-alist
    '(("#+begin_src" . ?)
      ("#+BEGIN_SRC" . ?)
      ("#+end_src" . ?)
      ("#+END_SRC" . ?)
      ("#+begin_example" . ?)
      ("#+BEGIN_EXAMPLE" . ?)
      ("#+end_example" . ?)
      ("#+END_EXAMPLE" . ?)
      ("#+header:" . ?)
      ("#+HEADER:" . ?)
      ("#+name:" . ?﮸)
      ("#+NAME:" . ?﮸)
      ("#+results:" . ?)
      ("#+RESULTS:" . ?)
      ("#+call:" . ?)
      ("#+CALL:" . ?)
      (":PROPERTY:" . ?)
      (":property:" . ?)
      (":LOGBOOK:" . ?)
      (":logbook:" . ?)))
  (prettify-symbols-mode 1))

(add-hook 'org-mode-hook 'my/org-mode/load-prettify-symbols)

(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)
	 (org-mode . rainbow-delimiters-mode)))

(use-package centaur-tabs
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-show-new-tab-button t
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-bar 'under
        centaur-tabs-show-count nil
        ;; centaur-tabs-label-fixed-length 15
        ;; centaur-tabs-gray-out-icons 'buffer
        ;; centaur-tabs-plain-icons t
        x-underline-at-descent-line t
        centaur-tabs-left-edge-margin nil)
  (centaur-tabs-change-fonts (face-attribute 'default :font) 110)
  (centaur-tabs-headline-match)
  ;; (centaur-tabs-enable-buffer-alphabetical-reordering)
  ;; (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-mode t)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-S-<prior>" . centaur-tabs-move-current-tab-to-left)
  ("C-S-<next>" . centaur-tabs-move-current-tab-to-right)
  (:map evil-normal-state-map
        ("g t" . centaur-tabs-forward)
        ("g T" . centaur-tabs-backward)))

;; Configure Tempel
(use-package tempel
  ;; Require trigger prefix before template name when completing.
  ;; :custom
  ;; (tempel-trigger-prefix "<")

  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert))

  :init

  ;; Setup completion at point
  (defun tempel-setup-capf ()
    ;; Add the Tempel Capf to `completion-at-point-functions'.
    ;; `tempel-expand' only triggers on exact matches. Alternatively use
    ;; `tempel-complete' if you want to see all matches, but then you
    ;; should also configure `tempel-trigger-prefix', such that Tempel
    ;; does not trigger too often when you don't expect it. NOTE: We add
    ;; `tempel-expand' *before* the main programming mode Capf, such
    ;; that it will be tried first.
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))

  (add-hook 'conf-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)

  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
  ;; (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  ;; (global-tempel-abbrev-mode)
)

;; Optional: Add tempel-collection.
;; The package is young and doesn't have comprehensive coverage.
(use-package tempel-collection)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tokyo-night t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; (use-package catppuccin-theme)
;; (load-theme 'catppuccin :no-confirm)
;; (setq catppuccin-flavor 'mocha)
;; (catppuccin-reload)

(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode)
  (setq vertico-cycle t))

;; just for looks
(use-package vertico-posframe
  :custom
  (vertico-posframe-parameters
   '((left-fringe . 8)
     (right-fringe . 8))))

(use-package vertico-prescient
  :ensure t
  :after vertico
  :commands vertico-prescient-mode
  :config
  ;; don't prescient sort these commands
  (vertico-prescient-mode +1))

(use-package vterm
  :config
  (setq shell-file-name "/usr/bin/zsh"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  ;; When running programs in Vterm and in 'normal' mode, make sure that ESC
  ;; kills the program as it would in most standard terminal programs.
  (evil-define-key 'normal vterm-mode-map (kbd "<escape>") 'vterm--self-insert)
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.4))))

(use-package which-key
  :defer 0
  :diminish
  :config
  (which-key-mode 1)
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-allow-imprecise-window-fit nil
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 0.1
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit nil
	which-key-separator " → " ))

;; (use-package markdown-mode)
;; (use-package pandoc-mode)
;; (use-package auctex)
;; (use-package auctex-latexmk)

(use-package yasnippet-snippets
  :disabled
  :ensure t)

(use-package yasnippet
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs '("~/.config/emacs/yasnippet") )
  (setq yas-triggers-in-field t))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold 63000000
      gc-cons-percentage 0.6)
