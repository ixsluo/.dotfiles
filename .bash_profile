export UU_ORDER="$UU_ORDER:~/.bash_profile"


# .bash_profile

# Get the alias and functions
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/.local/bin:$HOME/bin

test -e ~/.iterm2_shell_integration.bash && source ~/.iterm2_shell_integration.bash || true
