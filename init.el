;; init.el --- Emacs configuration
;; INSTALL PACKAGES
;; --------------------------------------
(setenv "IPY_TEST_SIMPLE_PROMPT" "1") ;; Fix broken ipython
(require 'package)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar myPackages
  '(better-defaults
    ein
    elpy
    exec-path-from-shell
    flycheck
    material-theme
    neotree
    origami
    py-autopep8
    web-mode))
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)
;; Packages that I've manually installed
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; BASIC CUSTOMIZATION
;; --------------------------------------
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
;; FILE TREES
;; --------------------------------------
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;; PYTHON CONFIGURATION
;; --------------------------------------
(exec-path-from-shell-copy-env "PATH")
(elpy-enable)
(elpy-use-ipython)
(setq elpy-rpc-python-command "python3")
(setq elpy-rpc-backend "jedi")
;; (setq elpy-rpc-timeout nil)
(setq elpy-rpc-timeout 2)
;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(delete-selection-mode 1)
;; ace jump mode major function
(add-to-list 'load-path "/Users/ben/.emacs.d/manually_installed_things/")
(autoload
  'ace-jump-mode
  "ace-jump-mode.el"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; --------------------------------------
;; HTML/WEB DEV CUSTOMIZATION
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; General Code Folding
(require 'origami)
(define-key origami-mode-map (kbd "C-c f a") 'origami-toggle-all-nodes)
;; http://stackoverflow.com/questions/916797/emacs-global-set-key-to-c-tab
(define-key origami-mode-map (kbd "<C-tab>") 'origami-recursively-toggle-node)
(global-origami-mode 1)
;; Smooth Scrolling
(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
;; Ligatures
;;(mac-auto-operator-composition-mode)
(when (window-system)
  (set-default-font "Fira Code"))
(let ((alist '(
               (33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               ;;(123 . ".\\(?:-\\)")
               ;;(124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               ;;(126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))
;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-ac jedi-direx fill-column-indicator neotree web-mode smooth-scroll py-autopep8 origami material-theme jedi flycheck exec-path-from-shell elpy ein better-defaults)))
 '(send-mail-function (quote sendmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
