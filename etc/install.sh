#!/bin/bash

set -euo pipefail

ETC="$(cd "$(dirname "$0")" && pwd)"

bash "$ETC/cli_utils.sh"
bash "$ETC/dev_tools.sh"
