#!/usr/bin/env bash

cp ../orderer/mychannel.tx .
export CORE_PEER_TLS_ENABLED=true
ORDERER_CA=${PWD}/../orderer/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export PEER0_HYPERSOFTADMIN_CA=${PWD}/crypto-config-ca/peerOrganizations/hypersoftAdmin.com/peers/peer0.hypersoftAdmin.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../config

export CHANNEL_NAME=mpos_channel

setGlobalsForPeer0HypersoftAdmin() {
  export CORE_PEER_LOCALMSPID="HypersoftAdminMSP"
  export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_HYPERSOFTADMIN_CA
  export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config-ca/peerOrganizations/hypersoftAdmin.com/users/Admin@hypersoftAdmin.com/msp
  export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer1HypersoftAdmin() {
  export CORE_PEER_LOCALMSPID="HypersoftAdminMSP"
  export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_HYPERSOFTADMIN_CA
  export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config-ca/peerOrganizations/hypersoftAdmin.com/users/Admin@hypersoftAdmin.com/msp
  export CORE_PEER_ADDRESS=localhost:8051

}

createChannel() {

  setGlobalsForPeer0HypersoftAdmin

  peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./${CHANNEL_NAME}.tx --outputBlock ./${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}

joinChannel() {
  setGlobalsForPeer0Org1
  peer channel join -b ./$CHANNEL_NAME.block

  setGlobalsForPeer1HypersoftAdmin
  peer channel join -b ./$CHANNEL_NAME.block
}

updateAnchorPeers() {
  setGlobalsForPeer0Org1
  peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}

createChannel
sleep 2
joinChannel
sleep 2
updateAnchorPeers
