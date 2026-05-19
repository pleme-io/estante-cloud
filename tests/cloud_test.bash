#!/usr/bin/env bash
# tests/cloud_test.bash — surface smoke tests. Actual kubectl/docker/
# tofu commands aren't invoked.

set -u

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "$__dir/init.bash"

__stdlib_init="$HOME/code/github/pleme-io/estante-stdlib/init.bash"
if [ -f "$__stdlib_init" ]; then
  . "$__stdlib_init"
else
  describe()     { printf '\n\033[1m%s\033[0m\n' "$1"; _ESTANTE_TEST_PASS=${_ESTANTE_TEST_PASS:-0}; _ESTANTE_TEST_FAIL=${_ESTANTE_TEST_FAIL:-0}; }
  end_describe() { :; }
  it()           { _CUR=$1; _F=0; _FR=""; }
  end_it()       { [ "${_F:-0}" -eq 0 ] && { printf '  \033[32m✓\033[0m %s\n' "$_CUR"; _ESTANTE_TEST_PASS=$((_ESTANTE_TEST_PASS+1)); } || { printf '  \033[31m✗\033[0m %s — %s\n' "$_CUR" "$_FR"; _ESTANTE_TEST_FAIL=$((_ESTANTE_TEST_FAIL+1)); }; }
  _test_fail()    { _F=1; _FR="$*"; }
  expect_truthy() { eval "$*" >/dev/null 2>&1 || _test_fail "expected truthy: $*"; }
  estante_test_summary() {
    local total=$((_ESTANTE_TEST_PASS+_ESTANTE_TEST_FAIL))
    [ "${_ESTANTE_TEST_FAIL:-0}" -gt 0 ] && { printf '\n\033[31m%s examples, %s failures\033[0m\n' "$total" "$_ESTANTE_TEST_FAIL"; exit 1; } || \
      printf '\n\033[32m%s examples, 0 failures\033[0m\n' "$total"
  }
fi

describe "estante-cloud :: k8s battery"

it "kubectl aliases (k / kg / kd / kdel / kap / kex / klog) defined"
  for a in k kg kd kdel kap kex klog; do
    expect_truthy "alias $a >/dev/null 2>&1"
  done
end_it

it "resource-list aliases (kgp / kgs / kgi / kgn / kgns / kga) defined"
  for a in kgp kgs kgi kgn kgns kga; do
    expect_truthy "alias $a >/dev/null 2>&1"
  done
end_it

it "kctx / kctxs / knsdef / knstoggle defined"
  expect_truthy 'alias kctx    >/dev/null 2>&1'
  expect_truthy 'alias knsdef  >/dev/null 2>&1'
  expect_truthy 'declare -F kctxs     >/dev/null 2>&1'
  expect_truthy 'declare -F knstoggle >/dev/null 2>&1'
end_it

end_describe

describe "estante-cloud :: docker battery"

it "docker aliases (d / dps / dpa / di / drm / drmi / dex / dlog) defined"
  for a in d dps dpa di drm drmi dex dlog; do
    expect_truthy "alias $a >/dev/null 2>&1"
  done
end_it

it "docker-compose aliases (dc / dcu / dcd / dcr / dcl / dcps) defined"
  for a in dc dcu dcd dcr dcl dcps; do
    expect_truthy "alias $a >/dev/null 2>&1"
  done
end_it

it "dprune / dsh functions defined"
  expect_truthy 'declare -F dprune >/dev/null 2>&1'
  expect_truthy 'declare -F dsh    >/dev/null 2>&1'
end_it

end_describe

describe "estante-cloud :: tofu battery"

it "_tf resolver + 12 tofu shortcuts defined"
  expect_truthy 'declare -F _tf >/dev/null 2>&1'
  for f in ti tp ta tac td tdc tfmt tvar tout tsta tw twn tws; do
    expect_truthy "declare -F $f >/dev/null 2>&1"
  done
end_it

end_describe

describe "estante-cloud :: idempotency"

it "re-sourcing is a no-op"
  . "$__dir/init.bash"
  . "$__dir/init.bash"
  expect_truthy '[ -n "$__ESTANTE_CLOUD_LOADED" ]'
end_it

end_describe

estante_test_summary
