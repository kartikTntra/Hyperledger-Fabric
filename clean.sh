#!/usr/bin/env bash

#if your using centos then enable below command
sudo setenforce 0

removeOrdererCA() {

  echo "Removing Orderer CA"
  docker-compose -f ./orderer/ca-orderer.yaml down -v

}
removePlatformerCA() {

  echo "Removing Platformer CA"
  docker-compose -f ./platformer/ca-platformer.yaml down -v

}
removeHypersoftCA() {

  echo "Removing Hypersoft CA"
  docker-compose -f ./hypersoft/ca-hypersoft.yaml down -v

}
removeOrderers() {
  echo "Removing orderers "
  docker-compose -f ./orderer/docker-compose-orderer.yaml down -v
}
removePlatformer() {

  echo "Removing Platformer Peers"
  docker-compose -f ./platformer/docker-compose-peer.yaml down -v
}
removeHypersoft() {
  echo "Removing Hypersoft Peers"
  docker-compose -f ./hypersoft/docker-compose-peer.yaml down -v
}
removeExplorer() {
  echo "Removing explorer"
  cd explorer
  docker-compose down -v
  cd ..
}
removeGrafanaPrometheus() {
  echo "Removing Grafana and Prometheus"
  cd monitoring
  docker-compose down -v
  cd ..
}
removeOrdererCA
removePlatformerCA
removeHypersoftCA
removeOrderers
removePlatformer
removeHypersoft
removeExplorer
removeGrafanaPrometheus
echo "Removing crypto CA material"
rm -rf ./orderer/fabric-ca
rm -rf ./platformer/fabric-ca
rm -rf ./hypersoft/fabric-ca
rm -rf ./orderer/crypto-config-ca
rm -rf ./platformer/crypto-config-ca
rm -rf ./hypersoft/crypto-config-ca
rm -rf ./platformer/platformerMSPanchors.tx
rm -rf ./hypersoft/HypersoftMSPanchors.tx
rm -rf ./orderer/genesis.block
rm -rf ./orderer/mychannel.tx
rm -rf ./platformer/mychannel.tx
rm -rf ./platformer/mychannel.block
rm -rf ./hypersoft/mychannel.tx
rm -rf ./hypersoft/mychannel.block
rm -rf ./explorer/dockerConfig/crypto-config
rm -rf ./deployChaincode/*.tar.gz
rm -rf ./deployChaincode/node_modules
rm -rf ./deployChaincode/log.txt
rm -rf ./deployChaincode/npm-debug.log
rm -rf ./revokeIdentity/config*  ./revokeIdentity/modi* ./revokeIdentity/base64Cert
