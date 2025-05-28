unbind C-b
set -g prefix C-Space
bind C-Space send-prefix

set -g mouse on

setw -g xterm-keys on
setw -g mode-keys emacs
set -g status-keys emacs
unbind '"'
unbind %
unbind &
unbind s
unbind C-z
bind v split-window -h
bind s split-window -v
bind k confirm kill-window
bind K confirm kill-server
bind -r < swap-window -t -1
bind -r > swap-window -t +1
