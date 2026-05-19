#!/usr/bin/env bash
# estante-cloud :: init.bash — kubernetes / docker / tofu shortcuts.

if [ -n "${__ESTANTE_CLOUD_LOADED:-}" ]; then return 0 2>/dev/null || true; fi
__ESTANTE_CLOUD_LOADED=1

# ── k8s ────────────────────────────────────────────────────────────
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kap="kubectl apply -f"
alias kex="kubectl exec -it"
alias klog="kubectl logs -f"
alias kgp="kubectl get pods -A"
alias kgs="kubectl get svc -A"
alias kgi="kubectl get ingress -A"
alias kgn="kubectl get nodes"
alias kgns="kubectl get ns"
alias kga="kubectl get all -A"
alias kctx="kubectl config use-context"
alias knsdef="kubectl config set-context --current --namespace"

kctxs() { kubectl config get-contexts -o name; }
knstoggle() {
  if command -v fzf >/dev/null 2>&1; then
    local ns; ns=$(kubectl get ns -o name | sed 's|^namespace/||' | fzf) && \
      kubectl config set-context --current --namespace "$ns"
  else
    echo "install fzf" >&2
  fi
}

# ── docker ─────────────────────────────────────────────────────────
alias d="docker"
alias dps="docker ps"
alias dpa="docker ps -a"
alias di="docker images"
alias drm="docker rm"
alias drmi="docker rmi"
alias dex="docker exec -it"
alias dlog="docker logs -f"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcr="docker compose restart"
alias dcl="docker compose logs -f"
alias dcps="docker compose ps"

dprune() {
  echo "Pruning containers, images, volumes, networks..."
  docker system prune -a --volumes
}

dsh() {
  docker exec -it "$1" sh -c 'command -v bash >/dev/null && exec bash || exec sh'
}

# ── tofu ───────────────────────────────────────────────────────────
_tf() {
  if   command -v tofu >/dev/null 2>&1;     then echo tofu
  elif command -v terraform >/dev/null 2>&1; then echo terraform
  else echo "install tofu or terraform" >&2; return 1; fi
}

ti()   { $(_tf) init "$@";              }
tp()   { $(_tf) plan "$@";              }
ta()   { $(_tf) apply "$@";             }
tac()  { $(_tf) apply -auto-approve "$@"; }
td()   { $(_tf) destroy "$@";           }
tdc()  { $(_tf) destroy -auto-approve "$@"; }
tfmt() { $(_tf) fmt -recursive "$@";    }
tvar() { $(_tf) validate "$@";          }
tout() { $(_tf) output "$@";            }
tsta() { $(_tf) state list "$@";        }
tw()   { $(_tf) workspace list "$@";    }
twn()  { $(_tf) workspace new "$@";     }
tws()  { $(_tf) workspace select "$@";  }
