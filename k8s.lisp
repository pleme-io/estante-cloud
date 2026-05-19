;; battery: k8s — kubectl shortcuts.

(defalias :name "k"     :value "kubectl")
(defalias :name "kg"    :value "kubectl get")
(defalias :name "kd"    :value "kubectl describe")
(defalias :name "kdel"  :value "kubectl delete")
(defalias :name "kap"   :value "kubectl apply -f")
(defalias :name "kex"   :value "kubectl exec -it")
(defalias :name "klog"  :value "kubectl logs -f")
(defalias :name "kgp"   :value "kubectl get pods -A")
(defalias :name "kgs"   :value "kubectl get svc -A")
(defalias :name "kgi"   :value "kubectl get ingress -A")
(defalias :name "kgn"   :value "kubectl get nodes")
(defalias :name "kgns"  :value "kubectl get ns")
(defalias :name "kga"   :value "kubectl get all -A")
(defalias :name "kctx"  :value "kubectl config use-context")
(defalias :name "knsdef":value "kubectl config set-context --current --namespace")

;; kctxs — list contexts.
(defun :name "kctxs"
       :body "kubectl config get-contexts -o name")

;; knstoggle — switch the current context's namespace via fzf, if present.
(defun :name "knstoggle"
       :body "if command -v fzf >/dev/null 2>&1; then local ns; ns=$(kubectl get ns -o name | sed 's|^namespace/||' | fzf) && kubectl config set-context --current --namespace \"$ns\"; else warn 'install fzf'; fi")
