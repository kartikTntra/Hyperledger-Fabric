#!/usr/bin/env bash

mkdir -p crypto-config-ca/peerOrganizations/platformer.com/peers

createMSPPeer0() {
  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.platformer.com -M ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/msp --csr.hosts peer0.platformer.com --tls.certfiles ${PWD}/fabric-ca/platformer/tls-cert.pem

  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.platformer.com -M ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls --enrollment.profile tls --csr.hosts peer0.platformer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/platformer/tls-cert.pem
  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/tlsca
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/tlsca/tlsca.platformer.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/ca
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer0.platformer.com/msp/cacerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/ca/ca.platformer.com-cert.pem

  # ------------------------------------------------------------------------------------------------
}
createMSPPeer1() {
  # Peer1

  mkdir -p crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com

  echo
  echo "## Generate the peer1 msp"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.platformer.com -M ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/msp --csr.hosts peer1.platformer.com --tls.certfiles ${PWD}/fabric-ca/platformer/tls-cert.pem

  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.platformer.com -M ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/tls --enrollment.profile tls --csr.hosts peer1.platformer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/platformer/tls-cert.pem
  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer1.platformer.com/tls/server.key

  # --------------------------------------------------------------------------------------------------

}
generateUserMSP() {
  mkdir -p crypto-config-ca/peerOrganizations/platformer.com/users
  mkdir -p crypto-config-ca/peerOrganizations/platformer.com/users/User1@platformer.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.platformer.com -M ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/users/User1@platformer.com/msp --tls.certfiles ${PWD}/fabric-ca/platformer/tls-cert.pem

	cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/users/User1@platformer.com/msp

}
generateAdminMSP() {
  echo
  echo "## Generate the platformer admin msp"
  echo
  fabric-ca-client enroll -u https://platformeradmin:platformeradminpw@localhost:7054 --caname ca.platformer.com -M ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/users/Admin@platformer.com/msp --tls.certfiles ${PWD}/fabric-ca/platformer/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/users/Admin@platformer.com/msp/config.yaml

}
createMSPPeer0
createMSPPeer1
generateUserMSP
generateAdminMSP
sleep 10
docker-compose -f docker-compose-peer.yaml up -d
sleep 10
docker ps -a
