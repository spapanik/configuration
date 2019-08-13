set -g status "on"
set -g status-interval 1
set -g status-bg "colour235"
set -g status-justify "centre"
set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left "#[fg=colour232,bg=colour154] #S #[fg=colour154,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour222,bg=colour238] #H #[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour121,bg=colour235] #(whoami) #[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour121,bg=colour235] #(date +%T) #[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour222,bg=colour238] %a #[fg=colour154,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour232,bg=colour154] #(date +%F) "

setw -g window-status-separator ""
setw -g window-status-format "#[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]#[default] #I#F: #W #[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=colour235,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour222,bg=colour238] #I#F: #W #[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]"
