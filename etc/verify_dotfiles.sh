#!/bin/bash
# Local integration test using Docker.
# Simulates the CI environment for ubuntu:22.04 and CentOS Stream 9.
# Usage: bash etc/verify_dotfiles.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IMAGES=(
  "ubuntu:22.04"
  "quay.io/centos/centos:stream9"
)

run_test() {
  local image="$1"
  echo ""
  echo "==> Testing on $image"

  docker run --rm \
    -v "$REPO_ROOT":/dotfiles \
    -e DOTFILES_ROOT=/dotfiles \
    -e CI=true \
    "$image" \
    bash -c "
      set -e
      # install git if missing
      if ! command -v git &>/dev/null; then
        if command -v apt-get &>/dev/null; then
          apt-get update -y && apt-get install -y git
        elif command -v dnf &>/dev/null; then
          dnf install -y git
        fi
      fi
      bash /dotfiles/setup.sh
      bats /dotfiles/tests/
    "
  echo "==> PASSED: $image"
}

for image in "${IMAGES[@]}"; do
  run_test "$image"
done

echo ""
echo "All passed: ${IMAGES[*]}"
