#!/bin/bash
# =================== YOUR DATA ========================
WEBSERVERBASHFILE="bash <( curl -s https://raw.githubusercontent.com/coldstake/server/master/reinstall-web.sh )"
SERVER_IP=$(curl --silent ipinfo.io/ip)
SERVICE_DESC="12 months coldstake.co.in service"
PRICE="15\.00"

if [ "$(id -u)" != "0" ]; then
    echo -e "${RED}* Sorry, this script needs to be run as root. Do \"sudo su root\" and then re-run this script${NONE}"
    exit 1
    echo -e "${NONE}${GREEN}* All Good!${NONE}";
fi

read -p "Which coin (bitcoinc)? " coin
read -p "Mainnet (m) or Testnet (t)? " net

SERVER_NAME="${coin}.coldstake.co.in"
REDIRECTURL="http:\/\/${SERVER_NAME}\/activate.php"
DNS_NAME="${coin}.coldstake.co.in"
USER="${coin}-web"
SUDO_PASSWORD="${coin}-web"
MYSQL_ROOT_PASSWORD="${coin}-web"
COINSERVICEINSTALLER="https://raw.githubusercontent.com/coldstake/server/master/install-coin.sh"
COINSERVICECONFIG="https://raw.githubusercontent.com/coldstake/server/master/config/config-${coin}.sh"
WEBFILE="https://github.com/coldstake/node.git"

if [[ "$net" =~ ^([tT])+$ ]]; then
    case ${coin} in
         bitcoinc)
            apiport="38221";
            ;;
         *)
           echo "${coin} has not been configured for testnet."
           exit
           ;;
    esac
else 
    case ${coin} in
        bitcoinc)
            apiport="37221";
            ;;
         *)
            echo "${coin} has not been configured for mainnet."
            exit
            ;;
    esac
fi

read -p "Are you using IP(y) or DNS(n)?" response

if [[ "$response" =~ ^([yY])+$ ]]; then
    DNS_NAME=$(curl --silent ipinfo.io/ip)
fi

# Remove Website
rm -rf /home/${USER}/${SERVER_NAME}
# Install Website
mkdir /home/${USER}/${SERVER_NAME}
cd /home/${USER}/
git clone ${WEBFILE} ${SERVER_NAME}
chown ${USER}:www-data /home/${USER}/${SERVER_NAME} -R
chmod g+rw /home/${USER}/${SERVER_NAME} -R
chmod g+s /home/${USER}/${SERVER_NAME} -R
cd /home/${USER}/${SERVER_NAME}
php /usr/local/bin/composer require trustaking/btcpayserver-php-client:dev-master
## Inject apiport & ticker into /include/config.php
sed -i "s/^\(\$ticker='\).*/\1${coin}';/" /home/${USER}/${SERVER_NAME}/include/config.php
sed -i "s/^\(\$api_port='\).*/\1${apiport}';/" /home/${USER}/${SERVER_NAME}/include/config.php
sed -i "s/^\(\$price='\).*/\1${PRICE}';/" /home/${USER}/${SERVER_NAME}/include/config.php
sed -i "s/^\(\$redirectURL='\).*/\1${REDIRECTURL}';/" /home/${USER}/${SERVER_NAME}/include/config.php
sed -i "s/^\(\$service_desc='\).*/\1${SERVICE_DESC}';/" /home/${USER}/${SERVER_NAME}/include/config.php

# Display information

echo "Website URL: "${DNS_NAME}
echo "Requires keys.php, btcpayserver.pri & pub in /var/secure/"