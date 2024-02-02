while read file
do 
  source "$ZDOTDIR/$file.zsh"
done <<-EOF
alias
settings
prompt
spectrum
plugins_before
plugins_after
EOF

# nvm
if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

# fzf configuration
if [ -f ~/.config/fzf/fzf.zsh ]; then
    source ~/.config/fzf/fzf.zsh
fi
