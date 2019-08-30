# Solarized colours
base03=brightblack
base02=black
base01=brightgreen
base00=brightyellow
base0=brightblue
base1=brightcyan
base2=white
base3=brightwhite
yellow=yellow
orange=brightred
red=red
magenta=magenta
violet=brightmagenta
blue=blue
cyan=cyan
green=green

set -g clock-mode-colour $base01
set -g clock-mode-style 24

set -g message-style bg=$base02,fg=$base00

set -g pane-active-border-style fg=$green
set -g pane-border-style fg=$base00

set -g status "on"
set -g status-interval 1
set -g status-justify "centre"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-style bg=$base02,fg=$base01
set -g status-left "#[bg=$base0,fg=$base3] #S #[bg=$base00,fg=$base0]#[bg=$base00,fg=$base3] #H #[bg=$base01,fg=$base00]#[bg=$base01,fg=$base3] #(whoami) #[bg=$base02,fg=$base01]"
set -g status-right "#[bg=$base02,fg=$base01]#[bg=$base01,fg=$base3] #(date +%R) #[bg=$base01,fg=$base00]#[bg=$base00,fg=$base3] %a #[bg=$base00,fg=$base0]#[bg=$base0,fg=$base3] #(date +%F) "

setw -g window-status-separator ""
setw -g window-status-current-style fg=$blue
setw -g window-status-format " #I#F: #W "
setw -g window-status-current-format " #I#F: #W "
