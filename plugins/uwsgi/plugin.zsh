### uwsgi / zeesh! plugin
### wrapper for uwsgi to make restarting a bit easier

fpath=( ~/.zsh/plugins/uwsgi/func $fpath )
autoload -U ~/.zsh/plugins/uwsgi/func/*(:t)

## aliases
alias uwsgi=uwsgi-wrapper
