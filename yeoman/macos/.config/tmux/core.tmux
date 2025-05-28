set -sg escape-time 10

set -g base-index 1
setw -g pane-base-index 1

set-option -g default-shell /bin/zsh

set -g default-terminal "screen-256color"
set -sa terminal-overrides ',xterm-256color:Tc'

set -g history-limit 10000
