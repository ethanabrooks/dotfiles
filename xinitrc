setxkbmap -option caps:escape
compton --inactive-dim 0.15 &
pgrep redshift &> /dev/null || redshift &> /dev/null &
~/.fehbg &
xbindkeys
i3
sudo ip link set wlp4s0 down
sudo systemctl restart netctl-auto@wlp4s0.service
