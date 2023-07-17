#!/usr/bin/env bash

# Copyright (C) 2022 Skale-5 <ops@skale-5.com>


FILE="/tmp/merged-chart.yaml"

SERVICE=$1
ENV=$2

find_gnu=$(strings "$(which find)" | grep GNU)

if [ -n "${find_gnu}" ]; then
  files=$(find "${SERVICE}/values.yaml" "${SERVICE}/values/${ENV}" "${SERVICE}/values/${ENV}/secrets/" -maxdepth 1 -name "*.y*ml" -type f -printf "%p ")
else
  echo "On MAC find is not GNU find, you have to install findutils and put it in your path!"
  exit 1
fi


custom_merge_vars=false

# shellcheck disable=SC2206
files_tab=($files)

if [ "${#files_tab[@]}" -ge 2 ]; then
    [ "${#files_tab[@]}" -gt 2 ] && echo -e "\e[38;5;214mWARNING\e[0m: using multiple values files will be deprecated. You must use only the « values.yaml » environment file."
    custom_merge_vars=true
elif [ "${#files_tab[@]}" -eq 0 ]; then
  echo "No values found"
  exit 1
fi


if $custom_merge_vars; then
  # shellcheck disable=SC2086
  yq ea '. as $item ireduce ({}; . *+ $item )' $files > ${FILE}
else
  cat "${SERVICE}/values/${ENV}/values.yaml" > ${FILE}
fi
