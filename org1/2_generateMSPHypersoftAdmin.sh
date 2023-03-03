#!/usr/bin/env bash

mkdir -p crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers

createMSPPeer0() {
  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.hyersoftAdmin.com -M ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/msp --csr.hosts peer0.hyersoftAdmin.com --tls.certfiles ${PWD}/fabric-ca/hypersoft-admin/tls-cert.pem

  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.hyersoftAdmin.com -M ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls --enrollment.profile tls --csr.hosts peer0.hyersoftAdmin.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hypersoft-admin/tls-cert.pem
  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/tlsca
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/tlsca/tlsca.hyersoftAdmin.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/ca
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer0.hyersoftAdmin.com/msp/cacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/ca/ca.hyersoftAdmin.com-cert.pem

  # ------------------------------------------------------------------------------------------------
}
createMSPPeer1() {
  # Peer1

  mkdir -p crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com

  echo
  echo "## Generate the peer1 msp"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.hyersoftAdmin.com -M ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/msp --csr.hosts peer1.hyersoftAdmin.com --tls.certfiles ${PWD}/fabric-ca/hypersoft-admin/tls-cert.pem

  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.hyersoftAdmin.com -M ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/tls --enrollment.profile tls --csr.hosts peer1.hyersoftAdmin.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hypersoft-admin/tls-cert.pem
  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/peers/peer1.hyersoftAdmin.com/tls/server.key

  # --------------------------------------------------------------------------------------------------

}
generateUserMSP() {
  mkdir -p crypto-config-ca/peerOrganizations/hyersoftAdmin.com/users
  mkdir -p crypto-config-ca/peerOrganizations/hyersoftAdmin.com/users/User1@hyersoftAdmin.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.hyersoftAdmin.com -M ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/users/User1@hyersoftAdmin.com/msp --tls.certfiles ${PWD}/fabric-ca/hypersoft-admin/tls-cert.pem

	cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/users/User1@hyersoftAdmin.com/msp

}
generateAdminMSP() {
  echo
  echo "## Generate the hypersoft-admin admin msp"
  echo
  fabric-ca-client enroll -u https://hypersoftAdminadmin:hypersoftAdminadminpw@localhost:7054 --caname ca.hyersoftAdmin.com -M ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/users/Admin@hyersoftAdmin.com/msp --tls.certfiles ${PWD}/fabric-ca/hypersoft-admin/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/hyersoftAdmin.com/users/Admin@hyersoftAdmin.com/msp/config.yaml

}
createMSPPeer0
createMSPPeer1
generateUserMSP
generateAdminMSP
sleep 10
docker-compose -f docker-compose-peer.yaml up -d
sleep 10
docker ps -a
