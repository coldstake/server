#!/bin/bash
# =================== YOUR DATA ========================
WEBSERVERBASHFILE="bash <( curl -s https://raw.githubusercontent.com/trustaking/server/master/reinstall-web.sh )"
SERVER_IP=$(curl --silent ipinfo.io/ip)
SERVICE_DESC="12 months Trustaking service"
PRICE="15\.00"
# =================== YOUR DATA ========================

read -p "Which Fork (redstone, x42, impleum, city, stratis)? " fork
read -p "Mainnet (m) or Testnet (t)? " net

SERVER_NAME="$fork.trustaking.com"
REDIRECTURL="http:\/\/${SERVER_NAME}\/activate.php"
DNS_NAME="$fork.trustaking.com"
USER="$fork-web"
SUDO_PASSWORD="$fork-web"
MYSQL_ROOT_PASSWORD="$fork-web"
COINSERVICEINSTALLER="https://raw.githubusercontent.com/trustaking/server-install/master/install-fork.sh"
COINSERVICECONFIG="https://raw.githubusercontent.com/trustaking/server-install/master/config/config-$fork.sh"
WEBFILE="https://github.com/trustaking/trustaking-server.git"

if [[ "$net" =~ ^([tT])+$ ]]; then
    case $fork in
         stratis)
            apiport="38221"; # "37221" <Main Stratis
            ;;
         redstone)
            apiport="38222"; # "37222" <Main Redstone
            ;;
        x42)
           apiport="42221"; # "42220" <Main X42
           ;;
        city)
           apiport="24335"; # "4335" <Main City
        ;; 
        impleum)
           apiport="38222"; # "39222" <Main Impleum
            ;;
         *)
           echo "$fork has not been configured."
           exit
           ;;
    esac
else 
    case $fork in
        stratis)
            apiport="37221";
            ;;
         redstone)
            apiport="37222";
            ;;
         x42)
            apiport="42220";
            ;;
         city)
            apiport="4335";
            ;; 
         impleum)
            apiport="39222";
            ;;
         *)
            echo "$fork has not been configured."
            exit
            ;;
    esac
fi

read -p "Are you using IP(y) or DNS(n)?" response

if [[ "$response" =~ ^([yY])+$ ]]; then
    DNS_NAME=$(curl --silent ipinfo.io/ip)
fi

# Re-Install Website
rm -rf /home/${USER}/${SERVER_NAME}
mkdir /home/${USER}/${SERVER_NAME}
cd /home/${USER}/
git clone ${WEBFILE} ${SERVER_NAME}
chown ${USER}:www-data /home/${USER}/${SERVER_NAME} -R
chmod g+rw /home/${USER}/${SERVER_NAME} -R
chmod g+s /home/${USER}/${SERVER_NAME} -R
cd /home/${USER}/${SERVER_NAME}
php /usr/local/bin/composer require trustaking/btcpayserver-php-client:dev-master
## Inject apiport & ticker into /include/config.php
sed -i "s/^\(\$ticker='\).*/\1${fork}';/" /home/${USER}/${SERVER_NAME}/include/config.php
sed -i "s/^\(\$api_port='\).*/\1${apiport}';/" /home/${USER}/${SERVER_NAME}/include/config.php
sed -i "s/^\(\$price='\).*/\1${PRICE}';/" /home/${USER}/${SERVER_NAME}/include/config.php
sed -i "s/^\(\$redirectURL='\).*/\1${REDIRECTURL}';/" /home/${USER}/${SERVER_NAME}/include/config.php
sed -i "s/^\(\$service_desc='\).*/\1${SERVICE_DESC}';/" /home/${USER}/${SERVER_NAME}/include/config.php

## Inject apiport into /scripts/trustaking-*.sh files
sed -i "s/^\(apiport=\).*/\1$apiport/" /home/${USER}/${SERVER_NAME}/scripts/trustaking-cold-wallet-add-funds.sh
sed -i "s/^\(apiport=\).*/\1$apiport/" /home/${USER}/${SERVER_NAME}/scripts/trustaking-cold-wallet-balance.sh
sed -i "s/^\(apiport=\).*/\1$apiport/" /home/${USER}/${SERVER_NAME}/scripts/trustaking-cold-wallet-setup.sh
sed -i "s/^\(apiport=\).*/\1$apiport/" /home/${USER}/${SERVER_NAME}/scripts/trustaking-cold-wallet-withdraw-funds.sh
sed -i "s/^\(apiport=\).*/\1$apiport/" /home/${USER}/${SERVER_NAME}/scripts/hot-wallet-setup.sh

# Display information

echo "Website URL: "${DNS_NAME}
echo "Requires keys.php, btcpayserver.pri & pub in /var/secure/"