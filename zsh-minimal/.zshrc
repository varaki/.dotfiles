# Locale settings
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Editor settings
export EDITOR="nvim"
export VISUAL="nvim"

# Path
export PATH=${HOME}/.local/bin:${HOME}/go/bin:/usr/sbin:/usr/local/go/bin:${PATH}

# Additional zsh configs
export ZSH_CONFIG_DIR="${HOME}/.config/zsh"
export ZSH_PLUGINS_DIR="${ZSH_CONFIG_DIR}/plugins"

# Download eza if not present
if ! command -v eza >& /dev/null; then
    echo "Downloading eza, a modern, maintained replacement for ls..."
    ARCH=$(uname -a | awk '{print $(NF-1)}')
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
    EZA_BIN_DEST_DIR="${HOME}/.local/bin/"
    TMP_DIR=$(mktemp -d)
    wget --no-check-certificate -q ${EZA_URL} -P ${TMP_DIR}
    mkdir -p ${EZA_BIN_DEST_DIR}
    tar xzf ${TMP_DIR}/${EZA_PKG_NAME} -C ${EZA_BIN_DEST_DIR}
    rm -rf ${TMP_DIR}
    echo "eza is now successfully installed"
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

# Expand aliases
bindkey "^Xa" _expand_alias

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
alias ll="eza -lag"
alias l="eza -lg"
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

# Setup auto-completion
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

# Set prompt
fpath=(${ZSH_CONFIG_DIR}/themes $fpath)
autoload -Uz prompt_varaki_setup && prompt_varaki_setup

# Run pfetch
pfetch
