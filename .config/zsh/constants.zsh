export LC_COLLATE=C
export EDITOR='vi'
export VISUAL='vi'
export LESS='-FRXK'

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Add ~/.local/bin to $PATH if it is not there
local_bin=$HOME/.local/bin
if [[ -d $local_bin ]]; then
	if [[ ${path[(i)$local_bin]} -gt ${#path} ]]; then
		export PATH=$PATH:$local_bin
	fi
fi
unset local_bin
