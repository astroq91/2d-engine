#!/usr/bin/env bash
set -euo pipefail

./update.sh check
git diff
