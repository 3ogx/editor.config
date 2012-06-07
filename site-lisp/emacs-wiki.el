;; emacs-wiki
(add-to-list 'load-path "~/elisp/emacs-wiki-2.72/")
;; Load emacs-wiki
(setq emacs-wiki-index-page "~/Wiki/WelcomePage.html")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;emacs-wiki
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'emacs-wiki)
(require 'emacs-wiki-table)
(require 'emacs-wiki-menu)  ;使用导航菜单
(setq emacs-wiki-index-page  "./WelcomePage.html")


(add-hook 'emacs-wiki-mode-hook
	    (lambda ()
             (define-key emacs-wiki-mode-map (kbd "C-c C-h") 'emacs-wiki-preview-html)
	     (define-key emacs-wiki-mode-map (kbd "C-c C-c") 'emacs-wiki-preview-source)
	     (define-key emacs-wiki-mode-map (kbd "C-c C-v") 'emacs-wiki-change-project)
             (define-key emacs-wiki-mode-map (kbd "C-c C-n") 'emacs-wiki-unlink-toggle)

))

;; (setq emacs-wiki-grep-command "glimpse -nyi \"%W\"")

;;设置wiki页面存储的目录
(setq emacs-wiki-directories '("~/Wiki"))
;;设置存储源文件使用的默认的文字编码
(setq emacs-wiki-meta-charset "utf8")
;; 设置发布HTML页面使用的charset（字符集），
(setq emacs-wiki-charset-default "utf8")
(setq emacs-wiki-style-sheet
      "")
(setq emacs-wiki-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" href=\"./core.css\">")

;; 设置你的mail地址，它将做为不存在页面的默认链接地址
(setq emacs-wiki-maintainer "mailto:3ogx.com@gmail.com")


;; 启用changelog美化支持，为真时会将changelog也当作Wiki页面发布
(setq emacs-wiki-pretty-changelogs t)

(setq emacs-wiki-inline-relative-to 'emacs-wiki-publishing-directory)

(defun emacs-wiki-preview-source ()
  (interactive)
  (emacs-wiki-publish-this-page)
  (find-file (emacs-wiki-published-file)))

(defun emacs-wiki-preview-html ()
  (interactive)
  (emacs-wiki-publish-this-page)
  (browse-url (emacs-wiki-published-file)))

(setq emacs-wiki-projects
	   `(("Linux" . ((emacs-wiki-directories . ("~/WiKi/draft/Linux"))
				   (emacs-wiki-publishing-directory . "~/WiKi/publish/Linux")
				   (emacs-wiki-default-page . "../Linux/WelcomePage.html")))
	   ("Programming" . ((emacs-wiki-directories . ("~/WiKi/draft/Programming"))
						 (emacs-wiki-publishing-directory . "~/Wiki/publish/Programming")
						 (emacs-wiki-default-page . "../Programming/WelcomePage.html")))
	   ("Other" . ((emacs-wiki-directories . ("~/Wiki/draft/Other"))
				   (emacs-wiki-publishing-directory . "~/Wiki/publish/Other")
				   (emacs-wiki-default-page . "../Other/WelcomePage.html")))
	   ("Life" . ((emacs-wiki-directories . ("~/Wiki/draft/Life"))
					  (emacs-wiki-publishing-directory . "~/Wiki/publish/Life")
					  (emacs-wiki-default-page . "../Life/WelcomePage.html")))
	   ("Tex" . ((emacs-wiki-directories . ("~/Wiki/draft/Tex"))
				 (emacs-wiki-publishing-directory . "~/Wiki/publish/Tex")
				 (emacs-wiki-default-page . "../Tex/WelcomePage.html")))
	   ("Default" . ((emacs-wiki-directories . ("~/Wiki/draft/Default"))
					 (emacs-wiki-publishing-directory . "~/Wiki/publish/Default")
					 (emacs-wiki-default-page . "../Default/WelcomePage.html")))))

(setq emacs-wiki-menu-definition '(("Default" "../Default/WelcomePage.html" "")
                                   ("Linux" "../Linux/WelcomePage.html" "")
                                   ("Tex" "../Tex/WelcomePage.html" "")
                                   ("Programming" "../Programming/WelcomePage.html" "")
                                   ("Life" "../Life/WelcomePage.html" "")
                                   ("Others" "../Others/WelcomePage.html" "")))

;;css 可以让你的网页不那么呆板
(setq emacs-wiki-style-sheet
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"../core.css\">")


;;要在多个项目之间相互引用，首先要设置 emacs-wiki-inter-names
(setq emacs-wiki-interwiki-names
      '(("Default" .
         (lambda (tag)
           (concat "../Default/" tag ".html")))
        ("Linux" .
         (lambda (tag)
           (concat "../Linux/" tag ".html")))
        ("History" .
         (lambda (tag)
           (concat "../Tex/" tag ".html")))
        ("Music" .
         (lambda (tag)
           (concat "../Life/" tag ".html")))
        ("Others" .
         (lambda (tag)
           (concat "../Others/" tag ".html")))))

;; 自定义函数emacs-wiki-unline-toggle，用于自动对WikiName添加/删除<nop>标记
;;{{{ copy from yason@emacswiki, modified by Yu Li
(defun emacs-wiki-unlink-toggle ()
  "Toggle <nop> string in the beginning of the current word, to
un/make a word emacs-wiki link. The current word depends on the
point: if the cursor is on a non-whitespace character, it's
considered a word surrounded by whitespace. If the cursor is on a
whitespace character, the next word is looked up. This way
addressing a word works intuitively after having arrived on the
spot using forward-word."
  (interactive)
  (save-excursion
    (with-current-buffer (current-buffer)
    (if (looking-at "[ \t]")
        (goto-char (- (re-search-forward "[A-Za-z<>]") 1))
      (goto-char (+ (re-search-backward "[^A-za-z<>]") 1)))
    (if (looking-at "<nop>")
        (delete-char 5)
      (insert "<nop>")))))
;;}}}

;;在保存的时候自动发布为html文件，很省事，这是Sacha的代码：
;;;_+ Automatically publish files upon saving
 (defun sacha-emacs-wiki-auto-publish ()
   (when (derived-mode-p 'emacs-wiki-mode)
     (unless emacs-wiki-publishing-p
       (let ((emacs-wiki-publishing-p t)
             (emacs-wiki-after-wiki-publish-hook nil))
    (emacs-wiki-publish-this-page)))))
 (add-hook 'emacs-wiki-mode-hook
           (lambda () (add-hook 'after-save-hook
                                'sacha-emacs-wiki-auto-publish
                                nil t)))

;; 用于显示公式
;(load "latex2png.el")
;(push '("latex" t t t gs-latex-tag) emacs-wiki-markup-tags)
;(setq gs-latex2png-scale-factor 1.5)

;; 设置预览所用的WWW浏览器，我使用的firefox，请把它改为你使用的浏览器的名字
(setq browse-url-generic-program "firefox")

;;header
(setq emacs-wiki-publishing-header "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">
<html>
  <head>
    <title><lisp>(emacs-wiki-page-title)</lisp></title>
    <meta name=\"generator\" content=\"emacs-wiki.el\" />
    <meta http-equiv=\"<lisp>emacs-wiki-meta-http-equiv</lisp>\"
          content=\"<lisp>emacs-wiki-meta-content</lisp>\" />
    <link rel=\"made\" href=\"<lisp>emacs-wiki-maintainer</lisp>\" />
    <link rel=\"home\" href=\"<lisp>(emacs-wiki-published-name
                                     emacs-wiki-default-page)</lisp>\" />
    <link rel=\"index\" href=\"<lisp>(emacs-wiki-published-name
                                      emacs-wiki-index-page)</lisp>\" />
    <lisp>emacs-wiki-style-sheet</lisp>
  </head>
  <body>

    <!-- If you want a menu, uncomment the following lines and
    put (require 'emacs-wiki-menu) in your Emacs setup somewhere.
     -->
    <lisp>(when (boundp 'emacs-wiki-menu-factory)
            (funcall emacs-wiki-menu-factory))</lisp>


    <h1 id=\"top\"><lisp>(emacs-wiki-page-title)</lisp></h1>

    <!-- Page published by Emacs Wiki begins here -->
")

;;footer
(setq emacs-wiki-publishing-footer
  "
    <!-- Page published by Emacs Wiki ends here -->
    <div class=\"navfoot\">
      <hr />
      <table width=\"100%\" border=\"0\" summary=\"Footer navigation\">
        <col width=\"33%\" /><col width=\"34%\" /><col width=\"33%\" />
        <tr>
          <td align=\"left\">
            <lisp>
              (if buffer-file-name
                  (concat
                   \"<span class=\\\"footdate\\\">Updated: \"
                   (format-time-string emacs-wiki-footer-date-format
                    (nth 5 (file-attributes buffer-file-name)))
                   (and emacs-wiki-serving-p
                        (emacs-wiki-editable-p (emacs-wiki-page-name))
                        (concat
                         \" / \"
                         (emacs-wiki-link-href
                          (concat \"editwiki?\" (emacs-wiki-page-name))
                          \"Edit\")))
                   \"</span>\"))
            </lisp>
          </td>
          <td align=\"center\">
            <span class=\"foothome\">
              <lisp>
                (concat
                 (and (emacs-wiki-page-file emacs-wiki-default-page t)
                      (not (emacs-wiki-private-p emacs-wiki-default-page))
                      (concat
                       (emacs-wiki-link-href emacs-wiki-default-page \"Home\")
                       \" / \"))
                 (emacs-wiki-link-href emacs-wiki-index-page \"Index\")
                 (and (emacs-wiki-page-file \"ChangeLog\" t)
                      (not (emacs-wiki-private-p \"ChangeLog\"))
                      (concat
                       \" / \"
                       (emacs-wiki-link-href \"ChangeLog\" \"Changes\"))))
              </lisp>
            </span>
          </td>
          <td align=\"right\">
            <lisp>
              (if emacs-wiki-serving-p
                  (concat
                   \"<span class=\\\"footfeed\\\">\"
                   (emacs-wiki-link-href \"searchwiki?get\" \"Search\")
                   (and buffer-file-name
                        (concat
                         \" / \"
                         (emacs-wiki-link-href
                          (concat \"searchwiki?q=\" (emacs-wiki-page-name))
                          \"Referrers\")))
                   \"</span>\"))
            </lisp>
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>\n"
)