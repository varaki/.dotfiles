# Export machine hostname
export MACHINE="$(uname -n)"

# Export machine architecture
export ARCH=$(uname -a | awk '{print $(NF-1)}')

# Locale settings
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Editor settings
export EDITOR="nvim"
export VISUAL="nvim"
export SYSTEMD_EDITOR="nvim"

# Path
export PATH=${HOME}/.local/bin:/usr/sbin:${HOME}/go/bin:/usr/local/go/bin:${PATH}

# Additional zsh configs
export LOCAL_BIN_DIR="${HOME}/.local/bin"
export XDG_CONFIG_DIR="${HOME}/.config"
export ZSH_CONFIG_DIR="${XDG_CONFIG_DIR}/zsh"
export ZSH_PLUGINS_DIR="${ZSH_CONFIG_DIR}/plugins"

# Set up asdf version manager
if [[ ! -d "${HOME}/.asdf" || -z "$(ls -A ${HOME}/.asdf)" ]]; then
    echo "Setting up asdf version manager..."
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.14.0
    install_asdf_plugins=true
fi
source ${HOME}/.asdf/asdf.sh

# Install asdf plugins
if [[ ! -z ${install_asdf_plugins} ]] && [[ -e ${HOME}/.tool-versions ]]; then
    awk '{ print $1 }' ${HOME}/.tool-versions | xargs -n1 asdf plugin-add
    asdf install 2> /dev/null
    rm -rf ${HOME}/.asdf/downloads/*
fi

# Append asdf completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# Download utilities
download_and_extract() {
    local url=${1}
    local dest=${2}
    local tempdir=$(mktemp -d)
    local pkg_name=$(basename ${url})

    wget --no-check-certificate -q ${url} -P ${tempdir}
    tar xzf ${tempdir}/${pkg_name} -C ${dest}
    rm -rf ${tempdir}
}

# Download otpgen
if ! command -v otpgen >& /dev/null; then
    echo "Downloading otpgen 2FA code generator..."
    OTPGEN_PKG_NAME="otpgen-${ARCH}.tar.gz"
    OTPGEN_URL="https://github.com/varaki/otpgen/releases/download/v1.0.0/${OTPGEN_PKG_NAME}"
    download_and_extract ${OTPGEN_URL} ${LOCAL_BIN_DIR}
fi

# Download eza
if ! command -v eza >& /dev/null; then
    echo "Downloading eza, a modern, maintained replacement for ls..."
    case ${ARCH} in
        x86_64)
            EZA_PKG_NAME="eza_${ARCH}-unknown-linux-musl.tar.gz"
        ;;
        aarch64)
            EZA_PKG_NAME="eza_${ARCH}-unknown-linux-gnu.tar.gz"
        ;;
        *)
            echo "Could not find eza package for architecture '${ARCH}'"
    esac
    EZA_URL="https://github.com/eza-community/eza/releases/latest/download/${EZA_PKG_NAME}"
    download_and_extract ${EZA_URL} ${LOCAL_BIN_DIR}
fi

# Options
export HISTFILE="${HOME}/.zsh_history"   # Set history file location
export HISTSIZE=10000                    # Maximum events for internal history
export SAVEHIST=10000                    # Maximum events stored in history file
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
setopt AUTO_PUSHD                        # Push the current directory to the stack
setopt PUSHD_IGNORE_DUPS                 # Don't store duplicates in the stack
setopt PUSHD_SILENT                      # Make pushd and popd silent
setopt INTERACTIVE_COMMENTS              # Allow interactive comments
setopt AUTOCD                            # Enter directories by just typing their names

# Expand aliases
bindkey "^Xa" _expand_alias

# Make sure CTRL+A, CTRL+E works fine in tmux too
bindkey -e

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
export FZF_DEFAULT_COMMAND="fd --unrestricted"
export FZF_CTRL_T_COMMAND="fd --unrestricted"
export FZF_ALT_C_COMMAND="fd --unrestricted --type d"

# Aliases
alias dots="cd ${HOME}/.dotfiles"
alias less="less -i"
alias ls="ls --color=tty"
alias ll="eza -lag"
alias l="eza -lg"
alias man="man -i"
alias xtar="tar --use-compress-program='xz --compress --keep -T 0 -9' -cf"
alias ptar="tar --use-compress-program=\"pigz -k \" -cf"
alias xuntar="tar --use-compress-program='xz --decompress --keep -T 0' -xf"
alias puntar="tar --use-compress-program=\"pigz -k \" -xf"
alias stmux="tmux has-session -t ${MACHINE} >& /dev/null || tmux new -s ${MACHINE} -d; tmux a"
alias hdd="cd /mnt/hdd/"
alias hdd2="cd /mnt/hdd2/"
alias hdd="cd /mnt/hdd"
alias hdd2="cd /mnt/hdd2"
alias data="cd /mnt/hdd/data"
alias data2="cd /mnt/hdd2/data"
alias share="cd /mnt/hdd/share"
alias share2="cd /mnt/hdd2/share"
alias rt="tmux -L rt-socket attach -t rt-session"
alias dc="docker-compose"
alias cleardlogs="sudo sh -c 'truncate -s 0 /var/lib/docker/containers/*/*-json.log'"

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

# Send keys to tmux with delay
delayed_send_keys() {
    local keys=${*}
    local delay=0.75
    sleep "${delay}"

    # Separate "Enter" from the keys as it is not getting interpreted otherwise
    if [[ ${keys} == *"Enter" ]]; then
        tmux send-keys "${keys// Enter/}" Enter
    else
        tmux send-keys ${keys}
    fi
}

# Bash-like word deletion
autoload -U select-word-style; select-word-style bash

# Setup autocompletion
autoload -U compinit; compinit
zstyle ':completion:*' special-dirs false
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
_comp_options+=(globdots)

# Install plugins
plugins=(
    zsh-completions https://github.com/zsh-users/zsh-completions
    zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting
    zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
    sudo https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
)
for plugin url in "${(@kv)plugins}"; do
    current_plugin_dir="${ZSH_PLUGINS_DIR}/${plugin}"
    if [ ! -d ${current_plugin_dir} ]; then
	echo "Downloading zsh plugin: ${plugin}..."

        if [[ "${url}" == *"raw.githubusercontent.com"* ]]; then
	    # Single plugin
	    mkdir -p "${current_plugin_dir}"
	    wget --quiet --no-check-certificate "${url}" -O "${current_plugin_dir}/$(basename ${url})"
	else
	    # Plugin repository
	    rm -rf "${current_plugin_dir}"
	    mkdir -p "${ZSH_PLUGINS_DIR}"
	    git -C "${ZSH_PLUGINS_DIR}" clone --quiet "${url}"
	fi
    fi
done

# Setup plugins
fpath=(${ZSH_PLUGINS_DIR}/zsh-completions/src $fpath)
source ${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ${ZSH_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ${ZSH_PLUGINS_DIR}/sudo/sudo.plugin.zsh

# Override default comment styling (requires zsh-syntax-highlighting)
ZSH_HIGHLIGHT_STYLES[comment]='fg=008,bold'

# Set prompt
fpath=(${ZSH_CONFIG_DIR}/themes $fpath)
autoload -Uz prompt_varaki_setup && prompt_varaki_setup

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

# Source server zsh config
if [[ "${MACHINE}" == "sero"* ]]; then
    [ -e ${HOME}/.zshrc-work-sero ] && source ${HOME}/.zshrc-work-sero
fi

# Run pfetch
pfetch
