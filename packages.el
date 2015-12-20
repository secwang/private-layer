;;; packages.el --- sec Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq sec-packages
      '(
        avy
        pinyin-search
        ace-pinyin
        thrift
        ))



(defun sec/init-pinyin-search ()
  (use-package pinyin-search))

(defun sec/init-ace-pinyin ()
  "Initialize ace-pinyin"
  (use-package ace-pinyin
    :config
    (ace-pinyin-global-mode 1)))


(defun sec/init-avy ()
  (use-package avy
    :defer t
    :init
    (progn
      (require 'ace-pinyin)
      (setq ace-pinyin-use-avy t)
      (setq avy-keys '(?a ?s ?d ?f   ?j ?k ?l ?;))
                          (global-set-key (kbd "M-s") 'avy-goto-char-2)
                          (evil-leader/set-key "SPC" 'avy-goto-char-2))))


    (defun sec/init-thrift ()
      (use-package thrift
        :defer t
        :mode ("\\.thrift\\'" . thrift-mode)))


    ;; For each package, define a function sec/init-<package-sec>

    (defun sort-words (reverse beg end)
      "Sort words in region alphabetically, in REVERSE if negative.
  Prefixed with negative \\[universal-argument], sorts in reverse.
  The variable `sort-fold-case' determines whether alphabetic case
  affects the sort order.
  See `sort-regexp-fields'."
      (interactive "*P\nr")
      (sort-regexp-fields reverse "\\(\\sw\\|\\s_\\)+" "\\&" beg end))

    (defun refresh-safari ()
      (interactive)
      (shell-command "re.sh"))


;; -----------------------------------------------------------------------------
;; increment/decrement region
;; -----------------------------------------------------------------------------
(defun increment-region (&optional beg end arg)
"Increment all decimal numbers in region between `beg' and
`end' by `arg'. If no prefix arg is given, increment by 1. If the
mark is not active, try to build a region using
`symbol-at-point'."
(interactive "r\np")
(or arg (setq arg 1))
(unless (and mark-active transient-mark-mode)
(let ((bounds (bounds-of-thing-at-point 'symbol)))
(if bounds (setq beg (car bounds) end (cdr bounds)))))
(if (< end beg)
(let ((tmp end))
(setq beg end end tmp)))
(save-excursion
(goto-char beg)
(while (re-search-forward "-?[0-9]+" end t)
(replace-match (number-to-string (+ arg (string-to-number (match-string 0)))))))
(setq deactivate-mark nil))

(defun decrement-region (&optional beg end arg)
"Decrement all decimal numbers in region between `beg' and
`end' by `arg'. If no prefix arg is given, increment by 1. If the
mark is not active, try to build a region using
`symbol-at-point'."
(interactive "r\np")
(or arg (setq arg 1))
(unless (and mark-active transient-mark-mode)
(let ((bounds (bounds-of-thing-at-point 'symbol)))
(if bounds (setq beg (car bounds) end (cdr bounds)))))
(increment-region beg end (- arg)))


(defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))	


    (defun sec/init-my-package ()
      "Initialize my package"
      (use-package sec
        :init
        (progn
          ;; we will fall back to using the default completing-read function, which is helm once helm is loaded.
          )
        )
      )
    ;;
    ;; Often the body of an initialize function uses `use-package'
    ;; For more info on `use-package', see readme:
    ;; https://github.com/jwiegley/use-package
