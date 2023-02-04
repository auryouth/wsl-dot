# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/bin"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$PATH:$HOME/.local/bin"
fi

# set texlive environment variables
if [ -d "/usr/local/texlive/2022/bin/x86_64-linux" ] ; then
    export PATH="$PATH:/usr/local/texlive/2022/bin/x86_64-linux"
fi
if [ -d "/usr/local/texlive/2022/texmf-dist/doc/man" ] ; then
    export MANPATH="$MANPATH:/usr/local/texlive/2022/texmf-dist/doc/man"
fi
if [ -d "/usr/local/texlive/2022/texmf-dist/doc/info" ] ; then
    export INFOPATH="$INFOPATH:/usr/local/texlive/texmf-dist/doc/info"
fi

host_ip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
export HTTP_PROXY="http://$host_ip:7890"
export HTTPS_PROXY="http://$host_ip:7890"
