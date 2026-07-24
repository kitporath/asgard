#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
EXCLUDES=(
  --exclude-dir=.git
  --exclude='check-redaction.sh'
  --exclude='SANITIZATION.md'
  --exclude='.gitignore'
  --exclude='LICENSE'
)
fail=0
if grep -RInE "${EXCLUDES[@]}" \
  '\b10\.(0|1|2|10|20|100)\.[0-9]+\.[0-9]+\b|\b192\.168\.[0-9]+\.[0-9]+\b|\b172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]+\.[0-9]+\b' \
  . 2>/dev/null; then
  echo "FAIL: private IPv4-looking addresses found"
  fail=1
fi
if grep -RInE "${EXCLUDES[@]}" \
  '\.lan\b|BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY|sealedsecrets?\.bitnami\.com|client-certificate-data:|client-key-data:' \
  . 2>/dev/null; then
  echo "FAIL: internal DNS / key / sealed-secret / kubeconfig credential material"
  fail=1
fi
if [[ "$fail" -ne 0 ]]; then
  echo "Redaction check failed."
  exit 1
fi
echo "OK: generic redaction heuristics clean."
