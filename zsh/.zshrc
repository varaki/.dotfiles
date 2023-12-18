# -----------------------------------------------------------------------------
# Global configuration
# -----------------------------------------------------------------------------
# Export machine hostname
export MACHINE="$(hostname -s)"

# Source server zsh config
if [[ "${MACHINE}" == "sero"* ]]; then
    # Takes ages to load, not really needed
    # [ -e /etc/home/zshrc ] && source /etc/home/zshrc

    # The only important part is this module function
    export MODULEPATH=/env/common/modules
    module(){
        {
            eval `/app/modules/0/bin/modulecmd zsh "$@"`
        } 2>&1
    }
    # Load modules if not already loaded
    module list --terse | grep -q "No Modulefiles Currently Loaded." && source ${HOME}/.modules
fi

# Editor settings
export EDITOR="nvim"
export VISUAL="nvim"

# Locale settings
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Editor settings
export EDITOR="nvim"
export VISUAL="nvim"

# Path
export PATH=${HOME}/.local/bin:/usr/local/go/bin:${HOME}/go/bin:/usr/local/pulse:${PATH}

# Set prompt
fpath=(${HOME}/.zsh-themes $fpath)
autoload -Uz prompt_varaki_setup && prompt_varaki_setup

# Set up ASDF version manager
if [[ ! -d "${HOME}/.asdf" ]]; then
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.10.2
fi
source ${HOME}/.asdf/asdf.sh
# Append ASDF completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# Options
export HISTFILE="${HOME}/.zsh_history"   # Set history file location
setopt EXTENDED_HISTORY                  # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY                # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY                     # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST            # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS                  # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS              # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS                 # Do not display a previously found event.
setopt HIST_IGNORE_SPACE                 # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS                 # Do not write a duplicate event to the history file.
setopt HIST_VERIFY                       # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY                    # append to history file
setopt HIST_NO_STORE                     # Don't store history commands

# load zgenom
if [[ ! -d "${HOME}/.zgenom" ]]; then
    git clone https://github.com/jandamm/zgenom.git ${HOME}/.zgenom
fi
export ZSH="${HOME}/.zgenom/sources/ohmyzsh/ohmyzsh/___" # Needed for oh-my-zsh to work properly with zgenom
export ZSH_DISABLE_COMPFIX=true                          # To be able to use this config symlinked to root user
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"

    # Add this if you experience issues with missing completions or errors mentioning compdef.
    # zgenom compdef

    # Ohmyzsh base library
    zgenom ohmyzsh

    # load plugins
    zgenom ohmyzsh plugins/sudo
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zsh-users/zsh-syntax-highlighting

    # save all to init script
    zgenom save

    # Compile your zsh files
    for zshfile in $(find ${HOME} -maxdepth 1 -name "*.zshrc*" -a ! -name "*.enc" -a ! -name "*.zwc"); do
        zgenom compile "$zshfile"
    done
fi

# Override oh-my-zsh default comment styling
ZSH_HIGHLIGHT_STYLES[comment]=fg=008,bold

# Initialize completion (probably not required because zgenom does it)
# autoload -Uz compinit; compinit;

# Complete hidden files
zstyle ':completion:*' special-dirs false # disable oh-my-zsh nonsense ./ and ../ completion
_comp_options+=(globdots)

# Expand aliases
bindkey "^Xa" _expand_alias

# Disable git autocompletion
# compdef -d git

# -----------------------------------------------------------------------------
# User configuration
# -----------------------------------------------------------------------------
# Set up correct terminal-overrides in tmux.conf
if [[ -z ${TMUX} ]]; then
    grep -qE "^set-option -ga terminal-overrides.*${TERM}" ~/.tmux.conf || sed --follow-symlinks -i 's%\(^set-option -ga terminal-overrides\).*%\1 ",'${TERM}':RGB"%g' ~/.tmux.conf
fi

# Disable loading default ranger config
export RANGER_LOAD_DEFAULT_RC="FALSE"

# Set ripgrep config path
export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"

# Setup fzf and fd
[ -e ${HOME}/.fzf-key-bindings.zsh ] && source ${HOME}/.fzf-key-bindings.zsh
export FZF_DEFAULT_COMMAND="fd --hidden"
export FZF_CTRL_T_COMMAND="fd --hidden"
export FZF_ALT_C_COMMAND="fd --hidden --type d"

# Aliases
alias dots="cd ${HOME}/.dotfiles"
alias less="less -i"
alias ll="ls -lah"
alias man="man -i"
alias xtar="tar --use-compress-program='xz --compress --keep -T 0' -cf"
alias ptar="tar --use-compress-program=\"pigz -k \" -cf"
alias xuntar="tar --use-compress-program='xz --decompress --keep -T 0' -xf"
alias puntar="tar --use-compress-program=\"pigz -k \" -xf"
alias stmux="tmux has-session -t $(hostname -s) >& /dev/null || tmux new -s $(hostname -s) -d; tmux a"
[ -e ${HOME}/.zshrc-otp-auth ] && source ${HOME}/.zshrc-otp-auth

# Encrypt and decrypt with openssl
crypt() {
    while [ "$#" -gt 1 ]; do
        case "$1" in
            "encrypt")
                shift
                infile="$1"
                openssl enc -aes-256-cbc -pbkdf2 -salt -in "${infile}" -out "${infile}.enc"
                break
            ;;
            "decrypt")
                shift
                infile="$1"
                outfile="$(echo ${infile} | sed 's/\.enc$//g')"
                openssl enc -aes-256-cbc -pbkdf2 -d -in "${infile}" -out "${outfile}"
                break
            ;;
        esac
    done
}
alias encrypt="crypt encrypt $*"
alias decrypt="crypt decrypt $*"

# -----------------------------------------------------------------------------
# Work configuration
# -----------------------------------------------------------------------------
# Set up work environment
work_env=false

case "${MACHINE}" in
    "sero"*|"elx"*)
        work_env=true
        ;;
esac

PRODUCT="$(test -f /sys/devices/virtual/dmi/id/product_name && cat /sys/devices/virtual/dmi/id/product_name)"
case "${PRODUCT}" in
    "OpenStack"*|"VMWare"*)
        work_env=true
        ;;
esac
${work_env} && [ -e ${HOME}/.zshrc-work ] && source ${HOME}/.zshrc-work

# Run pfetch
pfetch
