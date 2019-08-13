unbind C-b
set -g prefix C-Space
bind C-Space send-prefix

set -g mouse on
bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xsel -i --clipboard"

setw -g xterm-keys on
setw -g mode-keys vi
unbind '"'
unbind %
unbind &
bind V split-window -h
bind S split-window -v
bind k confirm kill-window
bind K confirm kill-server
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -i --clipboard"
