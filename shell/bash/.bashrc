export DOTFILES_PATH="/Users/jordi.pulido/.dotfiles"
export DOTLY_PATH="$DOTFILES_PATH/modules/dotly"
export DOTLY_THEME="agnoster"

source "$DOTFILES_PATH/shell/init.sh"

PATH=$(
  IFS=":"
  echo "${path[*]}"
)
export PATH

# Initialize Starship prompt
eval "$(starship init bash)"

for bash_file in "$DOTLY_PATH"/shell/bash/completions/_*; do
  source "$bash_file"
done

if [ -n "$(ls -A "$DOTFILES_PATH/shell/bash/completions/")" ]; then
  for bash_file in "$DOTFILES_PATH"/shell/bash/completions/_*; do
    source "$bash_file"
  done
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jordi.pulido/.lmstudio/bin"
