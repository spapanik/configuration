if-shell '[[ -r ~/.light ]]' {
    source-file ~/.config/tmux/themes/gruvbox_light.tmux
} {
    source-file ~/.config/tmux/themes/gruvbox_dark.tmux
}
