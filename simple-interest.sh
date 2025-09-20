#!/usr/bin/env bash
# simple-interest.sh
# Calculate Simple Interest: SI = (P * R * T) / 100
# Usage:
#   ./simple-interest.sh 1000 5 2
#   ./simple-interest.sh            
# prompts interactively

set -euo pipefail

read_input() {
  local prompt="$1" var
  while true; do
    read -r -p "$prompt" var
    # allow decimals; must be > 0
    if [[ "$var" =~ ^[0-9]*([.][0-9]+)?$ ]] && awk "BEGIN{exit !($var>0)}"; then
      echo "$var"
      return
    else
      echo "Enter a positive number (e.g., 1000 or 7.5)."
    fi
  done
}

main() {
  local P R T
  if [[ $# -eq 3 ]]; then
    P="$1"; R="$2"; T="$3"
  else
    echo "Simple Interest Calculator"
    P="$(read_input 'Principal (e.g., 1000): ')"
    R="$(read_input 'Rate (% per time period, e.g., 5): ')"
    T="$(read_input 'Time (in same period units, e.g., 2): ')"
  fi

  SI=$(awk -v p="$P" -v r="$R" -v t="$T" 'BEGIN { printf "%.2f", (p*r*t)/100 }')
  TOTAL=$(awk -v p="$P" -v si="$SI" 'BEGIN { printf "%.2f", p+si }')

  echo "Principal: $P"
  echo "Rate (%):  $R"
  echo "Time:      $T"
  echo "Simple Interest: $SI"
  echo "Total Amount:    $TOTAL"
}

main "$@"
