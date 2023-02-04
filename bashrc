while read file
do 
  source ~/.config/shell/bash/$file.bash
done <<-EOF
alias
prompt
settings
plugins
EOF
