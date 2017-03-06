;; Set python environment
(setq pyhome "~/miniconda2/envs/PCIENV")
(pythonic-activate pyhome)
(setq hy-mode-inferior-lisp-command (concat pyhome "/bin/hy"))

