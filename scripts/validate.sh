#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

terraform -chdir="$repo_root/bootstrap" fmt -check
terraform -chdir="$repo_root/bootstrap" init -backend=false -input=false
terraform -chdir="$repo_root/bootstrap" validate

terraform -chdir="$repo_root/platform" fmt -check
terraform -chdir="$repo_root/platform" init -backend=false -input=false
terraform -chdir="$repo_root/platform" validate
terraform -chdir="$repo_root/platform" test

bash "$repo_root/scripts/check-repository.sh"
