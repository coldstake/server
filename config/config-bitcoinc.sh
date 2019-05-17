function setMainVars() {
## set network dependent variables
NETWORK=""
NODE_USER=${FORK}${NETWORK}
COINCORE=home/${NODE_USER}/.${FORK}
COINPORT=
COINRPCPORT=
}

function setTestVars() {
## set network dependent variables
NETWORK="-testnet"
NODE_USER=${FORK}${NETWORK}
COINCORE=/root/.${FORK}
COINPORT=
COINRPCPORT=

}

function setGeneralVars() {
## set general variables
COINRUNCMD="sudo /home/${NODE_USER}/${FORK}d -daemon ${NETWORK} -datadir=${COINCORE} -staking"
COINGITHUB=https://github.com/Bitcoin-Confidential/BitcoinC-Core.git
COINDSRC=/home/${NODE_USER}/code/
CONF=release
COINDAEMON=${FORK}d
COINCONFIG=${FORK}.conf
COINSTARTUP=/home/${NODE_USER}/${FORK}d.sh
COINDLOC=/home/${NODE_USER}/${FORK}node
COINSERVICELOC=/etc/systemd/system/
COINSERVICENAME=${COINDAEMON}@${NODE_USER}
SWAPSIZE="1024" ## =1GB
}