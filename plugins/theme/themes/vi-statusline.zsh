VIRTUAL_ENV_DISABLE_PROMPT=true

if [ $zeesh_plugins[vcs-info] ]; then
    VCS_INFO_BRANCH_FMT='%b'

    VCS_INFO_GIT_ACTION_FMT='%F{magenta}‹%b%c%u%0.10i %a%m%s›%f'
    VCS_INFO_GIT_FMT='%F{magenta}‹%b%c%u%0.10i%m%s›%f'

    VCS_INFO_HG_ACTION_FMT='%F{magenta}‹%b%c%u %i %a %m%s›%f'
    VCS_INFO_HG_FMT='%F{magenta}‹%b%c%u %i %m%s›%f'

    VCS_INFO_HG_BOOKMARK_FMT=''
    VCS_INFO_HG_REV_FMT='%r'

    VCS_INFO_STAGED_FMT='+'
    VCS_INFO_UNSTAGED_FMT='!'
    VCS_INFO_TIMESINCE_FMT='$s'

    source $plugin_dir/../vcs-info/style.zsh
fi

export ZEESH_THEME_NORMAL_CHAR='\n⊙'
export ZEESH_THEME_VISUAL_CHAR='\n⊡'
export ZEESH_THEME_INSERT_CHAR='\n›'
export ZEESH_THEME_PROMPT_CHAR=›

_prompt() {
    local mode=
    case $KEYMAP in
        vicmd)
            mode=$ZEESH_THEME_NORMAL_CHAR
        ;;
        vivis)
            mode=$ZEESH_THEME_VISUAL_CHAR
        ;;
        *)
            mode=$ZEESH_THEME_INSERT_CHAR
        ;;
    esac

    local s="%F{magenta}%B%n%b%f%F{magenta}@%f%F{magenta}%B%m%f%b %F{blue}%B${PWD/$HOME/~}%b%f"

    # display vcs info
    if [ "$vcs_info_msg_0_" ]; then
        s="$s $vcs_info_msg_0_"
    fi

    # print virtualenv name if active
    if [ $VIRTUAL_ENV ]; then
        s="$s %F{magenta}‹${${(s:/:)VIRTUAL_ENV}[-1]}›%f "
    fi

    echo -e "$s%F{magenta} $mode$ZEESH_THEME_PROMPT_CHAR%f "
}

_rprompt() {
    # print return code if non-zero
    local rc=$?

    if [[ $rc != 0 ]]; then
        local s="%F{red}% $(emoticon) $rc!%f"
    fi

    echo -e $s
}

PROMPT='$(_prompt)'
RPROMPT='$(_rprompt)'

zle-keymap-select() {
    zle reset-prompt
}
zle -N zle-keymap-select

zle-line-init() {
    zle reset-prompt
}
zle -N zle-line-init
