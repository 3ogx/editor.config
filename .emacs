;; -*-mode:elisp-*-
;; 终端为utf-8
;; (set-language-environment "UTF-8")
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (modify-coding-system-alist 'process "*" 'utf-8)

(setq default-directory "~/")
(defconst lisp-path "~/.emacs.d/lisp/")
(add-to-list 'load-path lisp-path)
(add-to-list 'Info-default-directory-list "~/emacs/tramp/info/")
(require 'tramp)

;; 去掉滚动条
(set-scroll-bar-mode nil)

;; 禁止鼠标中键滚动
(mouse-wheel-mode nil)

;; 关闭烦人的出错时的提示声
(setq ring-bell-function 'ignore)

;; 禁用产生备份文件
(setq-default make-backup-files nil)
(setq inhibit-startup-message t)

(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
    try-expand-dabbrev-all-buffers
    try-expand-dabbrev-from-kill
    try-complete-file-name-partially
    try-complete-file-name
    try-complete-lisp-symbol-partially
    try-complete-lisp-symbol
    try-expand-whole-kill))

;; 自动匹配括号
;; see http://www.builder.com.cn/2008/0212/733323.shtml
(setq skeleton-pair t)
(local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "<") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)


;; 自动补全插件 auto-complate
;; see http://cx4a.org/software/auto-complete/manual.html#Installation
;; support php python c++ java javascript css
(add-to-list 'load-path "~/elisp/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/elisp/auto-complete/ac-dict")
(ac-config-default)

(setq column-number-mode t)

;; color-theme
(require 'color-theme)
;; (setq color-theme-is-global t)
;; (color-theme-initialize)
;; (color-theme-dark-blue2)
(setq my-themes [color-theme-classic color-theme-dark-blue2 color-theme-dark-blue
                                     color-theme-snow color-theme-gray30 color-theme-montz color-theme-deep-blue])
(add-hook 'after-init-hook
          '(lambda()
             (funcall (aref my-themes (% (string-to-int(format-time-string "%d")) (length my-themes))))))


(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (set c-basic-offset 4)
(c-set-offset 'case-label '+)

;; 顯示行號
(require 'linum)
(global-linum-mode t)
;; company-0.5
(autoload 'company-mode "company" nil t)
;; goto-line
(global-set-key (kbd "M-l") 'goto-line)

;; 自动折行
(setq auto-fill-mode nil)
(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
    try-expand-dabbrev-all-buffers
    try-expand-dabbrev-from-kill
    try-complete-file-name-partially
    try-complete-file-name
    try-complete-lisp-symbol-partially
    try-complete-lisp-symbol
    try-expand-whole-kill))


(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (set c-basic-offset 4)
(c-set-offset 'case-label '+)

;;yasnippet 模板
(add-to-list 'load-path "~/elisp/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/elisp/yasnippet-0.6.1c/snippets")

;; fullscreen
;; (defun fullscreen()
;;   (interactive)
;;   (set-frame-parameter nil 'fullscreen
;;                (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;; 總是不顯示工具欄
(tool-bar-mode -1)
;; 設置用戶名和帳號
(setq user-full-name "beiwei")
(setq user-mail-address "3ogx.com@gmail.com")
;; 關閉括號匹配跳到前面
(show-paren-mode t)
;; 標題顯示buffer，爾不是用戶
(setq frame-title-format "Emacs@%b")
;; 高亮顯示要拷貝的區域
(transient-mark-mode t)

;;用空格代替tab
(setq-default tab-width 4)
;; (setq tab-stop-list ())
;; (loop for x downfrom 40 to 1 do
;;       (setq tab-stop-list
;;             (cons (* x 2) tab-stop-list)))
(setq-default indent-tabs-mode nil)

;; 使用y∕n代替yes∕no
(fset 'yes-or-no-p 'y-or-n-p)

;; 使用cummode
(cua-mode t)

;;鼠标滚轮，默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

;;设置 sentence-end 可以识别中文标点
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

;; session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; unicad
(require 'unicad)

;; desktop
(load "desktop")
(desktop-load-default)
(desktop-save-mode t)
(desktop-read)

;; ido
(require 'ido)
(ido-mode t)

;; 默认启用文本模式 禁用启动信息
(setq default-major-mode 'text-mode)
;; 默認全屏
(fullscreen)

;; 最近打開的文件
(require 'recentf)
(recentf-mode t)
(global-set-key (kbd "C-c C-r") 'recentf-open-files)

;; (setq mac-option-key-is-meta nil)
;; (setq mac-command-key-is-meta t)
;; (setq mac-command-modifier t)
;; (setq mac-option-modifier nil)

;; 保存文件時刪除默認的空格
(setq whitespace-global-mode t)
(add-hook 'before-save-hook
          '(lambda()
             (whitespace-cleanup)))

;; 保存文件之前刪除行尾的空格
(add-hook 'before-save-hook
          '(lambda()
             (delete-trailing-whitespace)))


;; 設置默認字體
(set-default-font "-apple-monaco-medium-r-normal--16-140-72-72-m-140-mac-roman")

;; 方便的 electric-buffer-list 執行
;; 之后：
;; 光标自动转到 Buffer List buffer 中；
;; n, p 上下移动选择 buffer；
;; S 保存改动的 buffer；
;; D 删除 buffer。
;; 除此之外，不错的选择还有 ibuffer，不妨试试 M-x ibuffer。
(global-set-key (kbd "C-x C-b") 'electric-buffer-list)

;; Dired-x 在 Dired 之上又提供了很多有用的功能，这是其中之一。可以方便的在任
;; 何时候跳转到当前目录的 Dired buffer 中。
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; occur 功能，列出当前 buffer 中匹配的行。如果你在 Emacs 阅读这篇说明，试试
;; M-x occur RET file RET 和 C-u 2 M-x occur RET file RET。
(global-set-key (kbd "C-x C-o") 'occur)

;; 自动补全，M-/ 原来的绑定 dabbrev-expand 也是这个功能，然而 hippie-expand
;; 功能更强而且可以扩展。
(global-set-key (kbd "M-/") 'hippie-expand)

;; 撤銷
(global-set-key (kbd "C-/") 'undo)

;; 除了在 Dired buffer 中，基本都可以用来 other-window。
(global-set-key (kbd "M-o") 'other-window)

;; 取消默認的 C-@
(global-set-key (kbd "C-@") nil)
(global-set-key (kbd "C-\\") 'set-mark-command)

;; 很多文件的时候，在几个文件中跳转到曾经用过的 mark 地方。
(global-set-key (kbd "C-c C-z") 'pop-global-mark)

;; 回車後自動縮進
(global-set-key (kbd "RET") 'newline-and-indent)


;; 直接注释一行
(defun my-comment-dwim (&optional args)
  "Toggle comment"
  (interactive "p*")
  (apply 'comment-or-uncomment-region
         (if (and mark-active transient-mark-mode)
             (list (region-beginning) (region-end))
           (if (> args 0)
               (list (line-beginning-position) (line-end-position args))
             (list (line-beginning-position n) (line-end-position))))))
(global-set-key (kbd "M-;") 'my-comment-dwim)

;; 注釋一段
(global-set-key (kbd "C-M-;") 'comment-or-uncomment-region)

;; 在行首 C-k 时，同时删除该行。
(setq-default kill-whole-line t)
(setq resize-mini-windows nil)

;; markdown-mode
(require 'markdown-mode)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; hide
(defun hide-ctrl-m()
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?/ []))
(global-set-key (kbd "C-c m") 'hide-ctrl-m)

;; vim: ft=lisp
