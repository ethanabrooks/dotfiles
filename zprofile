path+=(
$HOME/.local/bin
$HOME/dotfiles/bin
/usr/local/bin
/usr/local/bin
/usr/local/opt/findutils/libexec/gnubin
)

PATH="/Users/ethanbrooks/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL_MB_OPT="--install_base \"/Users/ethanbrooks/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/ethanbrooks/perl5"; export PERL_MM_OPT;
export PATH="$HOME/.poetry/bin:$PATH"


# poetry
fpath+=~/.zfunc

export CURRENT_PROJECT_PATH=$HOME/.current-project
function current {
  if [[ -f $CURRENT_PROJECT_PATH  ]]; then 
    cd "$(cat $CURRENT_PROJECT_PATH)"
  fi
}
current
