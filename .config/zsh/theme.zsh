setopt prompt_subst

# prompt commands
local directory="%~"
local prompt_sign="%(!.#.$)"
local ret_status="%(?.%F{green}.%F{red})"

function user_info() {
	if [[ -n ${HIDE_USER} ]]; then
		local user="********"
		local server="********"
	else
		local user="%n"
		local server="%m"
	fi
	echo "${USER_INFO_PREFIX}${user}@${server}${USER_INFO_SUFFIX} "
}

# custom venv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
function venv_info() {
	if [[ -n ${VIRTUAL_ENV} ]]; then
		echo "${VENV_PROMPT_PREFIX}$(basename ${VIRTUAL_ENV})${VENV_PROMPT_SUFFIX} "
	fi
}

if [[ $(uname) == 'Darwin' ]]; then
	DIRCOLORS=gdircolors
else
	DIRCOLORS=dircolors
fi

# prompt variables
if [[ -a $HOME/.light ]]; then
	export BAT_THEME="ansi-light"
	USER_INFO_PREFIX=%F{black}
	eval $($DIRCOLORS ~/.config/zsh/dircolors/ansi-light.dircolors)
else
	export BAT_THEME="ansi-dark"
	USER_INFO_PREFIX=%F{white}
	eval $($DIRCOLORS ~/.config/zsh/dircolors/ansi-dark.dircolors)
fi
USER_INFO_SUFFIX="%f"

VENV_PROMPT_PREFIX="%F{blue}%Bvenv:(%b%F{red}"
VENV_PROMPT_SUFFIX="%F{blue})%B$%b%f"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue}%Bgit:(%b%F{red}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{blue}%B)"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{blue}%B) %F{yellow}✗"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b"

PROMPT='$(venv_info)%F{cyan}${directory}%f $(git_prompt_info)
$(user_info)${ret_status}${prompt_sign}%f '

autoload colors && colors
