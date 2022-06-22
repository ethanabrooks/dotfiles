if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi
if [ -e /Users/ethanbrooks/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/ethanbrooks/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
