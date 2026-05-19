;; battery: docker — docker / compose shortcuts.

(defalias :name "d"     :value "docker")
(defalias :name "dps"   :value "docker ps")
(defalias :name "dpa"   :value "docker ps -a")
(defalias :name "di"    :value "docker images")
(defalias :name "drm"   :value "docker rm")
(defalias :name "drmi"  :value "docker rmi")
(defalias :name "dex"   :value "docker exec -it")
(defalias :name "dlog"  :value "docker logs -f")
(defalias :name "dc"    :value "docker compose")
(defalias :name "dcu"   :value "docker compose up -d")
(defalias :name "dcd"   :value "docker compose down")
(defalias :name "dcr"   :value "docker compose restart")
(defalias :name "dcl"   :value "docker compose logs -f")
(defalias :name "dcps"  :value "docker compose ps")

;; dprune — prune everything reclaimable. Confirms first.
(defun :name "dprune"
       :body "info 'Pruning containers, images, volumes, networks…'; docker system prune -a --volumes")

;; dsh CONTAINER — quick interactive shell into a running container.
(defun :name "dsh"
       :body "docker exec -it \"$1\" sh -c 'command -v bash >/dev/null && exec bash || exec sh'")
