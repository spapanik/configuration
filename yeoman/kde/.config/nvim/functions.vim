function! SudoSaveFile() abort
    execute (has('gui_running') ? '' : 'silent') 'write suda://%'
    let &modified = v:shell_error
endfunction
