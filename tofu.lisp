;; battery: tofu — opentofu / terraform shortcuts.
;;
;; Defaults to `tofu`; falls back to `terraform` via the `_tf` resolver.

(defun :name "_tf"
       :body "if command -v tofu >/dev/null 2>&1; then echo tofu; elif command -v terraform >/dev/null 2>&1; then echo terraform; else die 'install tofu or terraform'; fi")

(defun :name "ti"   :body "$(_tf) init \"$@\"")
(defun :name "tp"   :body "$(_tf) plan \"$@\"")
(defun :name "ta"   :body "$(_tf) apply \"$@\"")
(defun :name "tac"  :body "$(_tf) apply -auto-approve \"$@\"")
(defun :name "td"   :body "$(_tf) destroy \"$@\"")
(defun :name "tdc"  :body "$(_tf) destroy -auto-approve \"$@\"")
(defun :name "tfmt" :body "$(_tf) fmt -recursive \"$@\"")
(defun :name "tvar" :body "$(_tf) validate \"$@\"")
(defun :name "tout" :body "$(_tf) output \"$@\"")
(defun :name "tsta" :body "$(_tf) state list \"$@\"")
(defun :name "tw"   :body "$(_tf) workspace list \"$@\"")
(defun :name "twn"  :body "$(_tf) workspace new \"$@\"")
(defun :name "tws"  :body "$(_tf) workspace select \"$@\"")
