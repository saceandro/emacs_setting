;;; global設定
;;;----------------------------------------------------------------------------
;; \C-hを後ろ一文字消去に、\C-c \C-hをヘルプに使う
;; \C-mを、改行後インデントにする
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-c\C-h" 'help-command)
(global-set-key "\C-m" 'newline-and-indent)

;; 自動でimenuのインデックスを作る
(setq imenu-auto-rescan t)

(global-set-key (kbd "C-x b") 'anything-for-files)

;; 閉じ括弧に対応する括弧を光らせる
(show-paren-mode)

(setq make-backup-files nil)

(setq auto-save-default nil)

(global-linum-mode t)

(column-number-mode t)

(setq-default indent-tabs-mode nil)

;; don't indent when paste
(electric-indent-mode 0)

;; don't display menu-bar
(menu-bar-mode -1)

(remove-hook 'comint-output-filter-functions
             'comint-postoutput-scroll-to-bottom)

;; 反対側のウィンドウにいけるように
(setq windmove-wrap-around t)
;; C-M-{h,j,k,l}でウィンドウ間を移動
(define-key global-map (kbd "C-M-k") 'windmove-up)
(define-key global-map (kbd "C-M-j") 'windmove-down)
(define-key global-map (kbd "C-M-l") 'windmove-right)
(define-key global-map (kbd "C-M-h") 'windmove-left)

;; font-lockを有効にする
					;(global-font-lock-mode t)

;; sdic
(autoload 'sdic-describe-word "sdic" "単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)


;;; cの設定
;;;--------------------------------------------------------------------
;; cの設定,一度にまとめて空白を消去
(add-hook 'c-mode-hook
	  (lambda ()
	    (c-toggle-hungry-state 1)
	    (c-toggle-auto-newline 1)
            (flymake-mode 1)))

;; cのコード編集時、compile, next-error, gdbを簡単に呼び出す
(add-hook 'c-mode-hook
	  (lambda ()
	    (define-key c-mode-base-map "\C-cc" 'compile)
	    (define-key c-mode-base-map "\C-ce" 'next-error)
	    (define-key c-mode-base-map "\C-cd" 'gdb)))

(add-to-list 'load-path "~/.emacs.d/site-lisp/flymake-cursor")
(load "flymake-cursor.el")

;; gdbをかっこよく使う
(setq gdb-many-windows t)
;(setq flymake-gui-warnings-enabled nil)
;(setq flymake-display-err-menu-for-current-line t)

;;; c++
;;;-------------------------------------------------------------------------
;(require 'flymake)

(add-hook 'c++-mode-hook
  (lambda ()
    (setq indent-tabs-mode nil)
    (flymake-mode 1)
    (c-toggle-auto-newline 1)))

(defun my-c-common-mode ()
  (define-key c-mode-base-map "\C-cc" 'compile)
  (define-key c-mode-base-map "\C-ce" 'next-error)
  (define-key c-mode-base-map "\C-cd" 'gdb)
  (c-toggle-hungry-state 1))
(add-hook 'c-mode-common-hook 'my-c-common-mode)

;; ;;; haskell
;; ;;;-----------------------------------------------------------------------
;; (add-hook 'haskell-mode-hook
;; 	  (lambda ()
;;             (define-key haskell-mode-map "\C-cc" 'compile)
;;             (define-key haskell-mode-map "\C-ce" 'next-error)
;;             (define-key haskell-mode-map "\C-c\C-c" 'comment-region)))

;; ;;; java
;; ;;;-----------------------------------------------------------------------
;; ;(require 'flymake)
;; ;(add-hook 'java-mode-hook 'flymake-mode-on)
;; ;(defun my-java-flymake-init ()
;; ;  (list "javac" (list (flymake-init-create-temp-buffer-copy
;; ;                       'flymake-create-temp-with-folder-structure))))
;; ;(add-to-list 'flymake-allowed-file-name-masks '("\\.java$" my-java-flymake-init flymake-simple-cleanup))
;; ;(when (require 'flymake)
;; ;  (set-variable 'flymake-log-level 9)
;; ;  (setq flymake-start-syntax-check-on-newline nil)
;; ;  (setq flymake-no-changes-timeout 10)
;; ;  (add-hook 'java-mode-hook 'flymake-mode-on))

;; ;;; scheme(karetta.jpや、wagavulinを参照)
;; ;;;-----------------------------------------------------------------------
;; ;; gauchのパス
;; (setq scheme-program-name "/usr/bin/gosh")
;; ;; scheme-modeとrun-schemeモードにcmuscheme.elを使用
;; (autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
;; (autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
;; ;; run-scheme時にウィンドウを分割
;; (defadvice run-scheme (before split-window activate)
;;   (if (= (count-windows) 1) (split-window))
;;   (other-window 1))
;; ;; scheme-mode時にファイルをロードする際、*scheme*バッファを開いてそれに移動
;; (defun scheme-load-current-file ()
;;   (interactive)
;;   (scheme-load-file (buffer-file-name (current-buffer))))
;; (defun scheme-load-current-file-and-switch ()
;;   (interactive)
;;   (scheme-load-current-file)
;;   (switch-to-buffer-other-window "*scheme*"))
;; ;; scheme-modeのkey設定
;; (add-hook 'scheme-mode-hook
;;   (lambda ()
;;     (define-key scheme-mode-map "\C-cs" 'run-scheme)
;;     (define-key scheme-mode-map "\C-c\C-l" 'scheme-load-current-file-and-switch)))

;;; python
(add-hook 'python-mode-hook
          'jedi:setup
          (lambda ()
            (define-key python-mode-map "\C-c\C-c" 'comment-region)
            (define-key python-mode-map "\C-cd" 'pdb)))
(setq jedi:complete-on-dot t)

;;; erlang
;;;----------------------------------------------------------------------
; (setq load-path
;       (append
;        (list
; 	(expand-file-name "~/.emacs.d/elpa/erlang-2.4.1/")
; 	)
;        load-path))
; (setq erlang-root-dir "/opt/local/lib/erlang")
; (setq exec-path (cons (concat erlang-root-dir "/bin") exec-path))
; (setq load-path (cons  (let ((erl-lib-base-dir (concat erlang-root-dir "/lib")))
; 			  (concat erl-lib-base-dir  "/"
; 				   (file-name-completion "tools-" erl-lib-base-dir )
; 				    "emacs"))
; 		              load-path))
; (require 'erlang-start)
 

(setenv "PATH"
        (concat (getenv "PATH") ":/usr/texbin"))

;;
;; YaTeX
;;
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-latex-message-code 'utf-8)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-dvi2-command-ext-alist
      '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
(setq tex-command ;"/usr/texbin/ptex2pdf -u -l -ot '-synctex=1'"
      "platex -synctex=1 -interaction=nonstopmode -shell-escape"
      )
                                        ;(setq tex-command "/usr/texbin/platex-ng -synctex=1")
                                        ;(setq tex-command "/usr/texbin/pdflatex -synctex=1")
                                        ;(setq tex-command "/usr/texbin/lualatex -synctex=1")
                                        ;(setq tex-command "/usr/texbin/luajitlatex -synctex=1")
                                        ;(setq tex-command "/usr/texbin/xelatex -synctex=1")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -u > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/platex-ng %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -norc -gg -pdf")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/pdflatex %O -synctex=1 %S/' -e '$bibtex=q/bibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/makeindex %O -o %D %S/' -norc -gg -pdf")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/lualatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -norc -gg -pdf")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/luajitlatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -norc -gg -pdf")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/xelatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -norc -gg -pdf")
;(setq bibtex-command "/usr/texbin/latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
(setq bibtex-command "upbibtex")
(setq makeindex-command "/usr/texbin/latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
(setq dvi2-command "/usr/bin/open -a Skim")
                                        ;(setq dvi2-command "/usr/bin/open -a Preview")
                                        ;(setq dvi2-command "/usr/bin/open -a TeXShop")
                                        ;(setq dvi2-command "/Applications/TeXworks.app/Contents/MacOS/TeXworks")
                                        ;(setq dvi2-command "/Applications/texstudio.app/Contents/MacOS/texstudio --pdf-viewer-only")
(setq tex-pdfview-command "/usr/bin/open -a Skim")
                                        ;(setq tex-pdfview-command "/usr/bin/open -a Preview")
                                        ;(setq tex-pdfview-command "/usr/bin/open -a TeXShop")
                                        ;(setq tex-pdfview-command "/Applications/TeXworks.app/Contents/MacOS/TeXworks")
                                        ;(setq tex-pdfview-command "/Applications/texstudio.app/Contents/MacOS/texstudio --pdf-viewer-only")
(setq dviprint-command-format "/usr/bin/open -a \"Adobe Acrobat Reader DC\" `echo %s | gsed -e \"s/\\.[^.]*$/\\.pdf/\"`")

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))

(setq YaTeX-template-file "~/.LaTeX-template.tex")

(defun skim-forward-search ()
  (interactive)
  (process-kill-without-query
   (start-process
    "displayline"
    nil
    "~/Applications/Skim.app/Contents/SharedSupport/displayline"
    (number-to-string (save-restriction
                        (widen)
                        (count-lines (point-min) (point))))
    (expand-file-name
     (concat (file-name-sans-extension (or YaTeX-parent-file
                                           (save-excursion
                                             (YaTeX-visit-main t)
                                             buffer-file-name)))
             ".pdf"))
    buffer-file-name)))

;;
;; RefTeX with YaTeX
;;
                                        ;(add-hook 'yatex-mode-hook 'turn-on-reftex)

(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)
             (define-key YaTeX-mode-map (kbd "C-c s") 'skim-forward-search)))

(setq reftex-default-bibliography '("/Users/yk/bitbucket/androsace/cge2/thesis/library.bib"))

;; aspell
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

(require 'package)
;; melpa
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; ;; marmalade
;; (add-to-list 'load-path "~/.emacs.d/site-lisp")
;; (load "lisp_emacs-lisp_package.el")

;; ;; egison
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/egison")
;; (load "egison-mode.el")
;; (autoload 'egison-mode "egison-mode" "Major mode for editing Egison code." t)
;; (setq auto-mode-alist
;;       (cons `("\\.egi$" . egison-mode) auto-mode-alist))

;; ;; auto-complete-mode
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete-1.3.1")
;; (load "auto-complete-config.elc")
;; (load "auto-complete.elc")
;; (load "fuzzy.elc")
;; (load "popup.elc")
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete-1.3.1/dict")
;; (require 'auto-complete-config)
;; (ac-config-default)

;; ;; auto-complete-latex
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete-latex")
;; (load "auto-complete-latex.elc")
;; (require 'auto-complete-latex)
;; (setq ac-l-dict-directory "/.emacs.d/ac-l-dict")
;(add-to-list 'ac-modes 'latex-mode)
;; (add-hook 'latex-mode-hook 'ac-l-setup)

;; ;; for YaTeX
;; (when (require 'auto-complete-latex nil t)
;;   (setq ac-l-dict-directory "~/.emacs.d/site-lisp/auto-complete-latex/ac-l-dict/")
;(add-to-list 'ac-modes 'yatex-mode)
;;   (add-hook 'yatex-mode-hook 'ac-l-setup))

;; (add-hook 'yatex-mode-hook
;;           '(lambda ()
;;              (add-to-list 'ac-dictionary-files "~/.emacs.d/site-lisp/auto-complete-1.3.1/dict/latex-mode")
;;              ))
;; ;; gnuplot
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/gnuplot")
;; (load "gnuplot-mode.elc")
;; (require 'gnuplot-mode)
;; (setq auto-mode-alist
;;       (append '(("\\.gpt$" . gnuplot-mode)) auto-mode-alist))

;; ;; auto-complete-acr
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete-acr")
;; (load "auto-complete-acr.elc")
;; (require 'auto-complete-acr)

;; (add-to-list 'ac-modes 'haskell-mode)

;; ;; gnu global (gtags)
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/gnu-global")
;; (require 'gtags)
;; ;; (require 'anything-gtags)
;; ;; (setq gtags-prefix-key "\C-c")
;; (setq gtags-mode-hook
;;       '(lambda ()
;;          (define-key gtags-mode-map "\M-s" 'gtags-find-symbol)
;;          (define-key gtags-mode-map "\M-," 'gtags-find-rtag)
;;          (define-key gtags-mode-map "\M-t" 'gtags-find-tag)
;;          (define-key gtags-mode-map "\M-f" 'gtags-parse-file)
;;          (define-key gtags-mode-map "\M-r" 'gtags-pop-stack)))
;; ;; gtags-mode を使いたい mode の hook に追加する
;; (add-hook 'c-mode-common-hook
;;           '(lambda()
;;              (gtags-mode 1)))

;; google-translate
(load "google-translate-2.el")

(require 'w3m)
(require 'markdown-mode)

(defun w3m-browse-url-other-window (url &optional newwin)
  (let ((w3m-pop-up-windows t))
    (if (one-window-p) (split-window))
    (other-window 1)
    (w3m-browse-url url newwin)))

(defun markdown-render-w3m (n)
  (interactive "p")
  (message (buffer-file-name))
  (call-process "/usr/local/bin/grip" nil nil nil
                "--gfm" "--export"
                (buffer-file-name)
                "/tmp/grip.html")
  (w3m-browse-url-other-window "file://tmp/grip.html")
  )
(define-key markdown-mode-map "\C-c \C-c" 'markdown-render-w3m)

;; proverif
(add-to-list 'load-path "~/.emacs.d/site-lisp/proverif")
(setq auto-mode-alist
      (cons '("\\.horn$" . proverif-horn-mode) 
            (cons '("\\.horntype$" . proverif-horntype-mode) 
                  (cons '("\\.pv$" . proverif-pv-mode) 
                        (cons '("\\.pi$" . proverif-pi-mode) auto-mode-alist)))))
(autoload 'proverif-pv-mode "proverif" "Major mode for editing ProVerif code." t)
(autoload 'proverif-pi-mode "proverif" "Major mode for editing ProVerif code." t)
(autoload 'proverif-horn-mode "proverif" "Major mode for editing ProVerif code." t)
(autoload 'proverif-horntype-mode "proverif" "Major mode for editing ProVerif code." t)

;; ess
(require 'ess-site)
