#!/usr/bin/env bash

mkdir -p crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com
createMSPPeer0() {
  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.hypersoft.com -M ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/msp --csr.hosts peer0.hypersoft.com --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem
  sleep 2

  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.hypersoft.com -M ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls --enrollment.profile tls --csr.hosts peer0.hypersoft.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem

  sleep 2
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/tlsca
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/tlsca/tlsca.hypersoft.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/ca
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer0.hypersoft.com/msp/cacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/ca/ca.hypersoft.com-cert.pem

}
createMSPPeer1() {
  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.hypersoft.com -M ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/msp --csr.hosts peer1.hypersoft.com --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem

  sleep 2
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.hypersoft.com -M ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/tls --enrollment.profile tls --csr.hosts peer1.hypersoft.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem
  sleep 2

  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/peers/peer1.hypersoft.com/tls/server.key
}
generateUserMSP() {
  mkdir -p crypto-config-ca/peerOrganizations/hypersoft.com/users
  mkdir -p crypto-config-ca/peerOrganizations/hypersoft.com/users/User1@hypersoft.com

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.hypersoft.com -M ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/users/User1@hypersoft.com/msp --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem
  sleep 2

	cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/users/Admin@hypersoft.com/msp/config.yaml

}
generateAdminMSP() {
  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://hypersoftadmin:hypersoftadminpw@localhost:8054 --caname ca.hypersoft.com -M ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/users/Admin@hypersoft.com/msp --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/users/Admin@hypersoft.com/msp/config.yaml
}
createMSPPeer0
createMSPPeer1
generateUserMSP
generateAdminMSP
docker-compose -f docker-compose-peer.yaml up -d
docker ps -a
