#!/bin/bash
# =================== YOUR DATA ========================
#bash <( curl -s https://raw.githubusercontent.com/coldstake/server/master/reinstall-coin.sh )
# =================== YOUR DATA ========================
if [ "$(id -u)" != "0" ]; then
    echo -e "${RED}* Sorry, this script needs to be run as root. Do \"sudo su root\" and then re-run this script${NONE}"
    exit 1
    echo -e "${NONE}${GREEN}* All Good!${NONE}";
fi

read -p "Which coin (bitcoinc)? " coin
read -p "Mainnet (m), Testnet (t) or Upgrade (u)? " NET
# =================== YOUR DATA ========================
USER="${coin}-web"
COINSERVICEINSTALLER="https://raw.githubusercontent.com/coldstake/server/master/install-coin.sh"
COINSERVICECONFIG="https://raw.githubusercontent.com/coldstake/server/master/config/config-${coin}.sh"
RPCUSER=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
RPCPASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
SERVER_IP=$(curl --silent ipinfo.io/ip)
# =================== YOUR DATA ========================

# Install Coins Service
wget ${COINSERVICEINSTALLER} -O /home/${USER}/install-coin.sh
wget ${COINSERVICECONFIG} -O /home/${USER}/config-${coin}.sh
chmod +x /home/${USER}/install-coin.sh
cd /home/${USER}/
./install-coin.sh -f ${coin} -u ${RPCUSER} -p ${RPCPASS} -n ${NET}

# Display information
echo
echo "Website URL: "${DNS_NAME}
echo "Requires keys.php, btcpayserver.pri & pub in /var/secure/ - run transfer.sh"