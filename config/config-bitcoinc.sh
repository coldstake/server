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
COINCORE=home/${NODE_USER}/.${FORK}
COINPORT=
COINRPCPORT=

}

function setGeneralVars() {
## set general variables
#COINGITHUB=https://github.com/Bitcoin-Confidential/BitcoinC-Core.git
COINGITHUB=https://github.com/Bitcoin-Confidential/BitcoinC-Core/releases/download/v1.0.0/bitcoinc-1.0.0.0-x86_64-linux-gnu.tar.gz
COINDSRC=/home/${NODE_USER}/code/
CONF=release
COINDAEMON=${FORK}d
COINCONFIG=${FORK}.conf
COINSTARTUP=/home/${NODE_USER}/${FORK}d.sh
COINDLOC=/home/${NODE_USER}/${FORK}node
COINRUNCMD="sudo ${COINDLOC}/${COINDAEMON} -daemon ${NETWORK} -datadir=${COINCORE} -staking"
COINSERVICELOC=/etc/systemd/system/
COINSERVICENAME=${COINDAEMON}@${NODE_USER}
SWAPSIZE="1024" ## =1GB
}