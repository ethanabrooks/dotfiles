PKG_OK=$(dpkg-query -W --showformat='${Status}\n' rcm|grep "install ok installed")
echo Checking for somelib: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo "No somelib. Setting up somelib."
  sudo apt-get --force-yes --yes install rcm
fi


