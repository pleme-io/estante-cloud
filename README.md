# estante-cloud

Three cloud-native batteries. Fail-soft when the upstream tool isn't
installed.

| Battery | Helpers |
|---|---|
| `k8s` | `k`/`kg`/`kd`/`kap`/`kex`/`klog`/`kgp`/`kgs`/`kgi`/`kgn`/`kgns`/`kga` + `kctx`/`kctxs`/`knsdef`/`knstoggle` |
| `docker` | `d`/`dps`/`dpa`/`di`/`drm`/`drmi`/`dex`/`dlog` + compose (`dc`/`dcu`/`dcd`/`dcr`/`dcl`/`dcps`) + `dprune`/`dsh` |
| `tofu` | `ti`/`tp`/`ta`/`tac`/`td`/`tdc`/`tfmt`/`tvar`/`tout`/`tsta`/`tw`/`twn`/`tws` — auto-detects `tofu` → `terraform` |

## Install

```bash
estante add github:pleme-io/estante-cloud@v0.1.0
estante lock && estante install
```

`(defload :pkg "estante-cloud")` or `. .../store/estante-cloud/init.bash`.
