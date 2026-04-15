# FILE AUTOMATICALLY GENERATED FROM /Users/jordi.pulido/.zimrc
# EDIT THE SOURCE FILE AND THEN RUN zimfw build. DO NOT DIRECTLY EDIT THIS FILE!

if [[ -e ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]] zimfw() { source "${HOME}/.dotfiles/shell/zsh/.zim/zimfw.zsh" "${@}" }
fpath=("${HOME}/.dotfiles/shell/zsh/.zim/modules/git-info/functions" "${HOME}/.dotfiles/shell/zsh/.zim/modules/completion/functions" ${fpath})
autoload -Uz -- coalesce git-action git-info
source "${HOME}/.dotfiles/shell/zsh/.zim/modules/environment/init.zsh"
source "${HOME}/.dotfiles/shell/zsh/.zim/modules/input/init.zsh"
source "${HOME}/.dotfiles/shell/zsh/.zim/modules/completion/init.zsh"
source "${HOME}/.dotfiles/shell/zsh/.zim/modules/fzf-tab/fzf-tab.zsh"
source "${HOME}/.dotfiles/shell/zsh/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "${HOME}/.dotfiles/shell/zsh/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh"
