ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases sublime zsh-syntax-highlighting history-substring-search pyenv ssh-agent)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)
# export PATH=./bin:./node_modules/.bin:/home/muna/.nvm/versions/node/v16.15.1/bin:/home/muna/.pyenv/bin:/home/muna/.rbenv/shims:/home/muna/.rbenv/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Program\ Files/Common\ Files/Oracle/Java/javapath:/mnt/c/Program\ Files\ \(x86\)/Common\ Files/Oracle/Java/javapath:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program\ Files\ \(x86\)/NVIDIA\ Corporation/PhysX/Common:/mnt/c/Program\ Files/NVIDIA\ Corporation/NVIDIA\ NvDLISR:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/Program\ Files\ \(x86\)/Windows\ Kits/10/Windows\ Performance\ Toolkit/:/mnt/c/Program\ Files\ \(x86\)/Windows\ Kits/10/Microsoft\ Application\ Virtualization/Sequencer/:/mnt/c/Program\ Files\ \(x86\)/dotnet/:/mnt/c/Program\ Files/dotnet/:/mnt/c/Program\ Files/Docker/Docker/resources/bin:/mnt/c/Users/Muna/AppData/Local/Programs/Eclipse\ Adoptium/jdk-17.0.3.7-hotspot/bin:/mnt/c/Users/Muna/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/Muna/AppData/Local/Programs/Microsoft\ VS\ Code/bin:/mnt/c/Program\ Files\ \(x86\)/Java/jre1.8.0_331/bin/:/usr/local/sbin:/home/muna/.rvm/bin:/home/muna/.local/bin:/home/muna/.local/lib:/home/muna/linuxbrew/.linuxbrew/bin/python3
# Load rbenv if installed (to manage your Ruby versions)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Load pyenv (to manage your Python versions)
export PATH="${HOME}/.pyenv/bin:${PATH}" # Needed for Linux/WSL
export PYENV_VIRTUALENV_DISABLE_PROMPT=1 # https://github.com/pyenv/pyenv-virtualenv/issues/135
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[🐍 $(pyenv_prompt_info)]'

# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use --silent
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    nvm use default --silent
  fi
}
type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm > /dev/null && load-nvmrc

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"
#sudo /etc/init.d/postgresql start

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# Add Python3 lib to PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/lib"
# export PGDATA="/usr/local/var/postgres"
export PGDATA="/home/linuxbrew/.linuxbrew/var/postgresql@14"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/muna/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/muna/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/muna/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/muna/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/home/linuxbrew/.linuxbrew/opt/postgresql@16/bin:$PATH"
#sudo /etc/init.d/postgresql start

# pnpm
export PNPM_HOME="/home/muna/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# phpbrew
export PHPBREW_ROOT="/home/muna/.phpbrew"
[[ -e /home/muna/.phpbrew/bashrc ]] && source /home/muna/.phpbrew/bashrc
export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/lib/pkgconfig"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/include"

# phpbrew end

# flutter
export PATH="$PATH:`pwd`/flutter/bin"

# flutter end
# Android SDK path
#export ANDROID_HOME=/mnt/c/Users/Muna/AppData/Local/Android/Sdk
# # avdmanager, sdkmanager
#export PATH="$PATH:$ANDROID_HOME/tools"
# # adb, logcat
#export PATH="$PATH:$ANDROID_HOME/platform-tools"
# # emulator
#export PATH="$PATH:$ANDROID_HOME/emulator"
# 
# # apksigner and zipalign
#export PATH="$PATH:$ANDROID_HOME/build-tools/34.0.0"
#export PATH="$PATH:$ANDROID_HOME/build-tools/34.0.0"
#export PATH="$PATH:$ANDROID_HOME/build-tools/33.0.2"
# 
# #jvm
#export JVM_HOME=/mnt/c/'Program Files'/Android/'Android Studio'
#export PATH="$PATH:$JVM_HOME"
#export JBR_HOME="$JVM_HOME/jbr"

# proxy
# proxy setting
proxy () {
  export HTTPS_PROXY="http://192.168.1.64:10809";
  export HTTP_PROXY="http://192.168.1.64:10809";
  export ALL_PROXY="socks5://192.168.1.64:10808";
  git config --global http.proxy "socks5://192.168.1.64:10808";
  git config --global https.proxy "socks5://192.168.1.64:10808";
  echo "Proxy on"
}
noproxy () {
  unset HTTPS_PROXY;
  unset HTTP_PROXY;
  unset ALL_PROXY;
  git config --global --unset  http.proxy;
  git config --global --unset  https.proxy;
  echo "HTTP Proxy off"
}
# proxy end
PROMPT='%(?.%F{245}.%F{red})[%n@%m]%f%F{green}➜%f  %F{87}%~%f '

# user bus
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
# user bus end
