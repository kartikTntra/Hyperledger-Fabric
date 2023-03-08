  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config-ca/peerOrganizations/platformer.com/

registerPeer() {
  echo
  echo "Register peer2"
  echo
  fabric-ca-client register --caname ca.platformer.com --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/../fabric-ca/platformer/tls-cert.pem

}

createMSPPeer2() {
  # Peer2

  mkdir -p crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com

  echo
  echo "## Generate the peer2 msp"
  echo
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:7054 --caname ca.platformer.com -M ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/msp --csr.hosts peer2.platformer.com --tls.certfiles ${PWD}/../fabric-ca/platformer/tls-cert.pem

  sleep 5
  cp ${PWD}/../crypto-config-ca/peerOrganizations/platformer.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/msp/config.yaml

  echo
  echo "## Generate the peer2-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:7054 --caname ca.platformer.com -M ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/tls --enrollment.profile tls --csr.hosts peer2.platformer.com --csr.hosts localhost --tls.certfiles ${PWD}/../fabric-ca/platformer/tls-cert.pem
  sleep 5
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/platformer.com/peers/peer2.platformer.com/tls/server.key

  # --------------------------------------------------------------------------------------------------

}
registerPeer
createMSPPeer2
