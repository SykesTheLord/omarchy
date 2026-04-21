# Install AM package manager
[ -z "$AM_BRANCH" ] && AM_BRANCH="main"

# The ISO builder stages AM here so the installer works offline.
AM_OFFLINE_DIR="/opt/packages/am"

sudo mkdir -p /opt/am/modules /usr/local/bin

sudo tee /opt/am/remove >/dev/null <<'EOF'
#!/bin/sh

set -e

if [ "$(id -u)" -ne 0 ]; then echo "Permission denied"; exit 1; fi
rm -f /usr/local/bin/am
rm -R -f /opt/am
EOF
sudo chmod a+x /opt/am/remove

if [[ -f $AM_OFFLINE_DIR/APP-MANAGER ]]; then
  sudo cp "$AM_OFFLINE_DIR/APP-MANAGER" /opt/am/APP-MANAGER
elif ! sudo wget -q -O /opt/am/APP-MANAGER "https://raw.githubusercontent.com/ivan-hc/AM/$AM_BRANCH/APP-MANAGER"; then
  echo "ERROR: Cannot download AM"
  exit 1
fi
sudo chmod a+x /opt/am/APP-MANAGER

if uname -a | grep -qi "Linux deck \|Linux steamdeck "; then
  BINDIR="/home/$USER/.local/bin"
  mkdir -p "$BINDIR"
  sudo ln -fs /opt/am/APP-MANAGER "$BINDIR/am"
  sudo sed -i "s#/usr/local/bin#$BINDIR#g" /opt/am/remove
else
  sudo ln -fs /opt/am/APP-MANAGER /usr/local/bin/am
fi

MODULES=$(tr '"' '\n' </opt/am/APP-MANAGER | grep "[a-z]\.am$")
if [[ -z $MODULES ]]; then
  echo "ERROR: Cannot determine AM modules"
  exit 1
fi

for module_name in $MODULES; do
  if [[ -f /opt/am/modules/$module_name ]]; then
    continue
  fi
  if [[ -f $AM_OFFLINE_DIR/modules/$module_name ]]; then
    sudo cp "$AM_OFFLINE_DIR/modules/$module_name" "/opt/am/modules/$module_name"
  elif ! sudo wget -q -O "/opt/am/modules/$module_name" "https://raw.githubusercontent.com/ivan-hc/AM/$AM_BRANCH/modules/$module_name"; then
    echo "ERROR: Cannot fetch AM module $module_name"
    exit 1
  fi
  sudo chmod a+x "/opt/am/modules/$module_name"
done

sudo chown -R "$USER" /opt/am
