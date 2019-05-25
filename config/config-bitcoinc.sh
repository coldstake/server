function setMainVars() {
## set network dependent variables
NETWORK=""
NODE_USER=${FORK}${NETWORK}
COINCORE=/home/${NODE_USER}/.${FORK}
COINPORT=
COINRPCPORT=
}

function setTestVars() {
## set network dependent variables
NETWORK="-testnet"
NODE_USER=${FORK}${NETWORK}
COINCORE=/home/${NODE_USER}/.${FORK}
COINPORT=
COINRPCPORT=
}

function setGeneralVars() {
## set general variables
#COINGITHUB=https://github.com/Bitcoin-Confidential/BitcoinC-Core.git
COINGITHUB=https://github.com/Bitcoin-Confidential/BitcoinC-Core/releases/download/v1.0.2/bitcoinc-1.0.2-x86_64-linux-gnu.tar.gz
COINDSRCLOC=/bitcoinc-1.0.2/bin/
COINDSRC=/home/${NODE_USER}/code
CONF=release
COINDAEMON=${FORK}d
COINCONFIG=${FORK}.conf
COINCONF="onlynet=onion\naddnode=77.56.24.222\naddnode=152.208.101.206\naddnode=95.179.138.28\naddnode=45.32.82.77\naddnode=103.43.75.6\naddnode=168.181.50.166"
COINSTARTUP=/home/${NODE_USER}/${FORK}d.sh
COINDLOC=/home/${NODE_USER}/${FORK}node
COINRUNCMD="sudo ${COINDLOC}/${COINDAEMON} -daemon ${NETWORK} -datadir=${COINCORE} -staking"
COINSERVICELOC=/etc/systemd/system/
COINSERVICENAME=${COINDAEMON}@${NODE_USER}
SWAPSIZE="1024" ## =1GB
}