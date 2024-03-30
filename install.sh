#!/usr/bin/env bash

HELP=$(
    cat <<EOF
Usage:
    $0 [OPTIONS]

Options:
    --base              Install base packages
    --keyd              Install keyd (custom keyboard layout daemon)
    --desktop DESKTOP   Install desktop packages
EOF
)

NEOVIM_DESKTOP_XZ_ARCHIVE="/Td6WFoAAATm1rRGBMCQGoCgASEBFgAAAAAAAHoeOfTgT/8NCF0AOpzKiwnF3EmyxS9LvYHmGmVXl0xYdIvZxblVgDLM0VmTB7Faalag6O3aPVbvs/0dt/X6PlRiv40+uS8GhfZAfaIYqn+otIWLcrZ8V4eCBFbXNOB9TRn9h7+4casshcR4fsnjJsm1Hkuk/wWBF3/4Vb/3/FMta2MizKqYIJcy/Csxe/MLqwoEGsbZZszjpWYkwo8QDPTf2s6C5fP9az2t6gwh3CX+OwmEmv8m4xst05CrLvEF+ay1RG+B0x6K+s5ZDu69pN5Kcnxiqc/DHVRiOmjxWfhRMF0JG2SYVk7veKxUu54UMnfgdDI5qPEz9vYcd3TDBzsDElsT+HEn0yOJ/dyT95APETrKm59kWzTegBQecdrB/wfJIdKQ7Uu7DIinHnxSxpOedEbkODb+cb9eWaaFVCwOSH+xRlk7snfkRXKEJY92Xy390ebtdDP6DdUM97HZY0R9Jzmy4ULb2ab+S/qptusiW+09ICzjGaBHFgXaSnH+jfHjlikznjqE5urMf+j6DQakHHeSr7r8XTsQHeCILDQag4r7Qwbyp/Vr0Rtw690pySAYcc99VjszNj5GMSYBBCBge9uNO52F6fVlOWC8qNBu+Bl+SRdMOXD4zInMCN5Cagl4335lH/uv+jmJ51xubydRPjXuHS4GKJXwsTqhUOwAODkkneoSlPRcYxT/xKsgSwxJi+xiFkAwQkLFlq7bZO/j4ulp9SJai/cPRD5qdQ0PL92Zd/0xllaya9kiO/e7Kle/RohmmLYdov+Xa0IplBDabHLfa52KiDiBVaoofy9zPaYtJnwnTOkeA+EFvaEcoyuRpldrSoCZa7pYLfJxJ1do8I4pUgyQdUvqR5pGErT7zEu35xQlvFM15hbfeJWiUFGTdmHlGqe0WqkfwU3odo8/ziWvyEr9LiZO9ZgvrQQX+z8CedAxzr1ummLVaT6P+k1gyRJyROon3PeYsHh6LMFJD4ZF4DiDKToSuQK26JFJvrCoDPkxdDmxKt+u4c6w7dEugUhYwI1b+QzE2H0hqjM6v5BAfT10NnOXU9mQYKWA8vQCXHpFDiL0CQ8qx9qFULb9RHo8XquDV9yxcpym7rMR2UroBN3pBBV2iL2rIw6H/0xdiGRzcHR9kLdzi2Vjgo3/tlQXoWnrdfH/SNKq/yIvy0kUdiZDNDZvKqU5TgLBJsmq6620fc7ErtHNkF+6L3czb0JkbvTXKyGooQEZoZbSGnhoHX3qqMFcJwvDuSLXJXdqCog4q7VjPtLuSeYHA3HLlm+KKR5PcXyBK8vUKDNaTXHrdsUrJxK8M9a6QDubu4RC6KJYJCNLj54ANXJhOijfR44/PE/CNazo7nlUvmZBwxqLFaBEU6pLIlVkt55rf7yhgBk7kmisgO0jC3k1UNMg5IM7qX7ZVZHTlrWXWUBCs+2a2twykiNg6jZzNYIUzSnnrQrPeAbF1JHPde8EupVy8cXmnWRUb8gSbIsWX9iScIvpYYjPIWU0uQXiYo14rPIslTuxixwLbvH1A3ylzbcXR22j5sxEu6WBvzCNdr77H/cdMAZD/JxMjS7/hlUmGYOTOMInkki2ksYds7YTJrLwKO7v36YqbyHKjD/VADaqhjj5vdYBTxYauqnw1VcaogOeGs4QzeLh6jZ+DY6IZNlSxQqjzy9b9daLBsLAVuH4A2Vv83HmU2Dpj8vmLW7NA2XvNy9zH3as172ma5aZvObcnIHYfQI42eqVCjfUkkTv2Qq9QbEJ3z/xw436K3TOwzDHfeKDFOhckMdFClR2ytvKrvmEza2X/nrxbBKrk6+JAHw4AmOkca27gEWvsxyybtAw3KufFBTFfg2HI7tGLxoahwhY7kHZNP+UZrS8u1FxC2yrAX2irSMqDcpfcZeYbZIayCmtDeGsE80uSfQ87fi4c5+rzbW1v4OR5Onb9k3FdYBk+16rb+NFrPU4x8bxv2MXX/HPBi/Dm1cZCKoK4wCj2sTkCenn4jReCLzfCaHdB7yyVjxfXvPDXQDVFK6i0dZmU0/ESrSRhjkrup3JYzBP962vMGwhFM7pvsUxdIA/LCbzL8XF0HlTKu8/CNPvOQny/zE6lQVTqX8ELyY1sQSkfbB7ubLTt900B0v1dsjSBtFUPegNkouBJ99oJ4pATpvmOBkvxQv75HRIHM0eiZrGdDBGmOzms3mEKjHZooWCz6DYqXGPOsTN08VQLve2fF0Us1LU3l9z61E11JN/y0GqpOJHHvuaA6bKybdE1oTai58QroIT6EvCU+ioR8ymW/aw0GSLabmx1D3Ap1NgzsWth2gCuMg6DVOEKgSFvffauR4DNg/2D29usd3AtVAng4aRarWYPD1CNn6JLNW1mnr+T+O/dlpJ383/Eh03P73Tdwed4SU8MFUl0dMG9dODzJGAaMJaUQFblHTr45YDXdAZAHj/jf5q0etrZbEMFzf6/1nB0BSqzbcT4G9LJgs2WQ1rv0zKX26HmlUDys3j/ydPaeHktcj/cT0MUd3DSMjRDwAXkNUseauRp9PYUCgT95FENBJir9PNC1s2n8oGoBNDTTyBOLWCNZA20eovD931pN9OX2WPnZZmaS45evL2rqy6d2jcHqVEWbLsg5aHArUmD5VS35NWBQNkc5Q86r1UV7wFcxxYbOzXMU3BLIUNBMmoDhSCzE/WnNIo32aPGYWiHVs/u/JC5JCN1diYZCZaLU2I/eZSIzICvv4S6JzLaQYcTsS0mwBnZhtlcdgATycTsvBqxr7URp1vmXkpJ4bzRphOdKoBseJ3+JFX8fqAWWtYDalgprdeMkJ5aimj1dIYFvNRRZiAqjNtLhXafNNSe5JwF3HABipaBv32hkvYOxxQMXZOKbkbRaTU2YCyaXL2iEEz9pe7g7GK5irw3cPRQzHkX8zkZpNP2SCoELMHC4+Y45w59XM8xroaUXXEiJwMHBj1y2IGv4EFzGg7yNJz5G9M+FcHVqVr+w4IKfVegSVYda8We91qwgGW3Zqd0NNVGrTVLViSTUgS2OpqtivzDdWeN+jNENDNVfhrC/tFH6yhUHQUZuzXEddKtopqTsA0WMew4e/yCFkGkyHi+acISI0rJE+YzH3vXR8iXCs44E1NxAsjYblyP3XP0radUNHrOcFSNtxhqPlSZqv8A6b1eU8P4jL9bQk+GSVPHyMCez86z1n7pPTlIZXUjQP1QwkvgLlr7IimlWL+4fHPWfnwBBzgB4pqb3e32loEZ7KHnTmlJhsNFhguQzKBxdV+n6+s3LsPTsNH3MYYZwwAeGpIbXNW1lcUUq0o7ziUvX2xTVEZjXPekx2A70svC5JmLTSwX4z76XMUb8kRMMbq8yWV+xGV2urPLx5T0KL/d1jxoYcVsLE+IvPZAHxRg+jmtsOsd69SnNOkuHvLoGXXc2dfZrTvyXsfddc4OoyTBXdLMFjyagbu7d2ZSkii43oKPDY9h8Pf4zR/6NROCXGcbaBSBkxpXqtTKFZIL4gZFim1mu12wHH5Y6prsiHdRgJvyBCB/j4/MG/YMvH/fAojA1QMrsLa0Cw/ZM7zX5PKyy+224/7oD/GWGm6YdT5BSJ/kAhUuIOjMBC+LcHkGav3uVNaP0ZGCO+IVJuJEDiSqK9fA/tyu/eWzLZVDVootHxo7LLWRD/X1DbpxM3yXYrZXib10OS6WGExBFzkrQ1TZNEA7h7vgyAT/vGr8mZTe5zWXB2vsqWMWQq7XZaadUbxsXWkicmI1Wyw1dNJhaBFpMTzECFK//iFTLABlKJgIRgO02U6aaZ8N+HEra+RWvwvEn/Lrjmdfe/aN9Ia4wCad2rpqvl0pEf/iXqLrn3nbcjhMgkRNQ+sVafjR27nSWC7NAuoKbVCJWHkg8NiJ2wcevM6VB6gntI2RjHq2VVm2PBClvBNAIB3CHxh1I7dv4YQExs4B8RDi25TWEfDQgy4qSqudl5HDfdwJ8cH4mo7kqGJyJ61Ga6NYI1OqU1iOxf8xTTGF1rcGNuRZLu/fCHRRrr4thPYUx38ZHESgiqgL/PXK+j0ntqPVTSK3w/Hsdtq7G/wlKMBJJN+edqwYTrTSg/FQPbN3VMhc9X6Up/DiZNZTwweNDm6c6r+GVJO7e+m81K4E5kZEbQRSavkCfKbof1qEH7OwfCqRBEXz2t0t0S027nCQ2pXAYP5wrDuHDayItLcmw5PO5o8TWviKnepIc9BHnym4fd4WjI/m7oKUScS16u0muFCDQPS3u8H71OJcPK4lXJXH9cvEOUHUmO03Swf5cGyRGt/mqgfzbmLcAFzCLsMWWFHtv1DTbxFLsEDXGaRlUPgMzPPEpr9ZPkN8XoetthKvCJNMEpNwhJZLYRNXPjl+AedoYM5Wu0eqCosktwnh/2ZAg0fwRhrgj8bkd9ZrYoucRqWVKFCBc6xTQjc6l9O3XfIeHh8Mf4Fklo1y4fFqwm2h28vTRiHiGVIvzgYHbIAAAmUk+7nyKYTAAGsGoCgAQBxUOGqscRn+wIAAAAABFla"

declare -a BASE
BASE=(
    "build-essential"
    "fd-find"
    "fonts-recommended"
    "fuse3"
    "fzf"
    "git"
    "htop"
    "kbd"
    "locales"
    "ripgrep"
    "stow"
    "tmux"
    "wget"
    "zip"
    "unzip"
    "zsh"
)

declare -a XFCE
XFCE=(
    "xfdesktop4"
    "xfwm4"
    "xfconf"
    "xfce4-notifyd"
    "xfce4-panel"
    "xfce4-power-manager"
    "xfce4-pulseaudio-plugin"
    "xfce4-session"
    "xfce4-settings"
    "thunar"
)

function install_packages() {
    local pkgs=${*}
    echo "Packages:"
    for pkg in ${pkgs[*]}; do
        echo "- ${pkg}"
    done
    apt install ${pkgs[*]} --yes
}

function install_desktop() {
    local desktop=${1:-XFCE}
    case ${desktop^^} in
        "XFCE")
            packages=${XFCE[*]}
            ;;
        *)
            echo "Unknown destkop: ${desktop}"
            exit 1
            ;;
    esac
    echo "Installing ${desktop} packages..."
    install_packages ${packages[*]}
}

function install_neovim() {
    local neovim_url="https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage"
    local neovim_path="/usr/local/bin/nvim"

    if [ ! -e ${neovim_path} ]; then
        wget ${neovim_url} -O /usr/local/bin/nvim
        chmod +x /usr/local/bin/nvim
    fi

    # Set up .desktop file and icon
    echo "${NEOVIM_DESKTOP_XZ_ARCHIVE}" | base64 -d | tar xJvf - -C /

    # Remove regular vim
    apt purge --autoremove vim* --yes
}

function install_keyd() {
    local temp_dir=$(mktemp -d)
    local user=${SUDO_USER:-${USER}}
    git -C ${temp_dir} clone https://github.com/rvaiya/keyd
    cd ${temp_dir}
    make && make install
    stow --dir=/home/${user}/.dotfiles --target=/ keyd
    systemctl enable keyd && systemctl start keyd
}

function stow_configs() {
    local user=${SUDO_USER:-${USER}}
    local dotfiles="/home/${user}/.dotfiles"
    local dotfiles_url="https://codeberg.org/varaki/.dotfiles"
    git -C /home/${user} clone ${dotfiles_url}

    declare -a configs
    configs=(
        "git"
        "htop"
        "nvim"
        "tmux"
        "zsh"
    )
    for config in ${configs[@]}; do
        sudo --login --user ${user} stow --restow --dir ${dotfiles} --target /home/${user} ${config}
        if [ "${config}" == "zsh" ]; then
            local curr_lang=$(locale | grep LANG= | cut -d'=' -f2)
            sudo --login --user ${user} sed -i 's%en_US.UTF-8%'${curr_lang}'%g' /home/${user}/.zshrc
        fi
    done
}

function enable_silent_login() {
    local user=${SUDO_USER:-${USER}}
    sudo --login --user ${user} touch /home/${user}/.hushlogin
}

INSTALL_BASE=false
INSTALL_DESKTOP=false
INSTALL_KEYD=false

while [ $# -gt 0 ]; do
    case ${1} in
        --base)
            INSTALL_BASE=true
            ;;
        --desktop)
            INSTALL_DESKTOP=true
            shift
            DESKTOP=${1}
            ;;
        --keyd)
            INSTALL_KEYD=true
            ;;
        -h | --help)
            echo "${HELP}"
            exit
            ;;
        *)
            echo "Unkown option: ${1}"
            echo "${HELP}"
            exit 1
            ;;
    esac
    shift
done

if [ "$(whoami)" != "root" ]; then
    echo "Run this script with sudo"
    exit 1
fi

if ${INSTALL_BASE}; then
    echo "Installing BASE packages..."
    install_packages ${BASE[*]}
    install_neovim
    stow_configs
    enable_silent_login
    ${INSTALL_KEYD} && install_keyd
fi

if ${INSTALL_DESKTOP}; then
    install_desktop ${DESKTOP}
fi
