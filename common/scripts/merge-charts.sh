#!/usr/bin/env bash

# Copyright (C) 2022 Skale-5 <ops@skale-5.com>


FILE="/tmp/merged-chart.yaml"

SERVICE=$1
ENV=$2

find_gnu=$(strings "$(which find)" | grep GNU)

if [ -n "${find_gnu}" ]; then
  files=$(find "${SERVICE}/values.yaml" "${SERVICE}/values/${ENV}" -name "*.yaml" -type f -printf "%p ")
else
  echo "On MAC find is not GNU find, you have to install findutils and put it in your path!"
  exit 1
fi
# shellcheck disable=SC2086
yq ea '. as $item ireduce ({}; . *+ $item )' $files > ${FILE}
