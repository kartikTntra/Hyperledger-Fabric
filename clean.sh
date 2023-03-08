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
removeOrg2CA() {

  echo "Removing Org2 CA"
  docker-compose -f ./org2/ca-org2.yaml down -v

}
removeOrderers() {
  echo "Removing orderers "
  docker-compose -f ./orderer/docker-compose-orderer.yaml down -v
}
removePlatformer() {

  echo "Removing Platformer Peers"
  docker-compose -f ./platformer/docker-compose-peer.yaml down -v
}
removeOrg2() {
  echo "Removing Org2 Peers"
  docker-compose -f ./org2/docker-compose-peer.yaml down -v
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
removeOrg2CA
removeOrderers
removePlatformer
removeOrg2
removeExplorer
removeGrafanaPrometheus
echo "Removing crypto CA material"
rm -rf ./orderer/fabric-ca
rm -rf ./platformer/fabric-ca
rm -rf ./org2/fabric-ca
rm -rf ./orderer/crypto-config-ca
rm -rf ./platformer/crypto-config-ca
rm -rf ./org2/crypto-config-ca
rm -rf ./platformer/platformerMSPanchors.tx
rm -rf ./org2/Org2MSPanchors.tx
rm -rf ./orderer/genesis.block
rm -rf ./orderer/mychannel.tx
rm -rf ./platformer/mychannel.tx
rm -rf ./platformer/mychannel.block
rm -rf ./org2/mychannel.tx
rm -rf ./org2/mychannel.block
rm -rf ./explorer/dockerConfig/crypto-config
rm -rf ./deployChaincode/*.tar.gz
rm -rf ./deployChaincode/node_modules
rm -rf ./deployChaincode/log.txt
rm -rf ./deployChaincode/npm-debug.log
rm -rf ./revokeIdentity/config*  ./revokeIdentity/modi* ./revokeIdentity/base64Cert
