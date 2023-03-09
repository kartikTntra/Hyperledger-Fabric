#!/usr/bin/env bash

setupHypersoftCA() {
  echo "Setting Hypersoft CA"
  docker-compose -f ca-hypersoft.yaml up -d

  sleep 10
  mkdir -p /crypto-config-ca/peerOrganizations/hypersoft.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/
}
createCertificatHypersoft() {
  echo "Enroll the CA admin"

  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.hypersoft.com --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem
}
nodeOrgUnits() {

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-hypersoft-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-hypersoft-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-hypersoft-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-hypersoft-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config-ca/peerOrganizations/hypersoft.com/msp/config.yaml

}
registerUsers() {
  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.hypersoft.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.hypersoft.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.hypersoft.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.hypersoft.com --id.name hypersoftadmin --id.secret hypersoftadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/hypersoft/tls-cert.pem

}
setupHypersoftCA
createCertificatHypersoft
sleep 2
nodeOrgUnits
sleep 2
registerUsers
