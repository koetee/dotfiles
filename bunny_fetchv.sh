#!/bin/bash
# Tiny colored fetch script with dynamic bunny eyes

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
d=$'\e[1m'
t=$'\e[0m'

# Человеческий формат времени
uptime_seconds=$(awk '{printf "%.0f", $1}' /proc/uptime)
uptime_days=$((uptime_seconds / 86400))
uptime_hours=$(( (uptime_seconds % 86400) / 3600 ))
uptime_minutes=$(( (uptime_seconds % 3600) / 60 ))

if ((uptime_days > 0)); then
  uptime_display="${uptime_days}d ${uptime_hours}.${uptime_minutes}h"
elif ((uptime_hours > 0)); then
  uptime_display="${uptime_hours}.${uptime_minutes}h"
else
  uptime_display="${uptime_minutes}m"
fi

h=id
username="$(whoami)"

k=kr
kernel="$(uname -r | cut -d '-' -f1)"

sh=sh
shell=$(basename $SHELL)

r=up

# Состояния кролика: Бодр, Устал, Спит
eyes=("· ·" ". ." "- -")
sleep_eyes=("Zzz...")
idx=$(( $(date +%s) / 15 % 3 ))

# (\ /)
# ( · ·)
# c(")(")

# (\ /)
# ( . .)
# c(")(")

# (\ /) Zzz...
# ( - -)
# c(")(")

tput clear
cat << EOF

             $d$f1$h  $t$username
   (\ /)     $f3$k  $t$kernel
   ( $d${eyes[idx]}$t)    $f2$sh  $t$shell
   c($f1"$t)($f1"$t)   $f5$r  $t${uptime_display}

EOF
