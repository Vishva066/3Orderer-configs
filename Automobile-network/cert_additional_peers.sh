#!/bin/bash

function peermanufacturer(){

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/manufacturer.auto.com/

  echo "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-manufacturer --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-manufacturer -M "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/msp/config.yaml"

  echo "Generating the peer1-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-manufacturer -M "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls" --enrollment.profile tls --csr.hosts peer1.manufacturer.auto.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
  cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/server.key"

  echo "Registering peer2"
  set -x
  fabric-ca-client register --caname ca-manufacturer --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer2 msp"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:7054 --caname ca-manufacturer -M "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/msp/config.yaml"

  echo "Generating the peer2-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:7054 --caname ca-manufacturer -M "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/tls" --enrollment.profile tls --csr.hosts peer2.manufacturer.auto.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
  cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer2.manufacturer.auto.com/tls/server.key"

}

function peerdealer (){
  echo "Registering additional peers"

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/dealer.auto.com/


  echo "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-dealer --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/dealer/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-dealer -M "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/dealer/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/dealer.auto.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/msp/config.yaml"

  echo "Generating the peer1-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-dealer -M "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/tls" --enrollment.profile tls --csr.hosts peer1.dealer.auto.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/dealer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
  cp "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer1.dealer.auto.com/tls/server.key"


  echo "Registering peer2"
  set -x
  fabric-ca-client register --caname ca-dealer --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/dealer/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer2 msp"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:8054 --caname ca-dealer -M "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/dealer/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/dealer.auto.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/msp/config.yaml"

  echo "Generating the peer2-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:8054 --caname ca-dealer -M "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/tls" --enrollment.profile tls --csr.hosts peer2.dealer.auto.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/dealer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
  cp "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer2.dealer.auto.com/tls/server.key"

}

function peermvd (){

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/mvd.auto.com/

  echo "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-mvd --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/mvd/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:11054 --caname ca-mvd -M "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/mvd/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/mvd.auto.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/msp/config.yaml"

  echo "Generating the peer1-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:11054 --caname ca-mvd -M "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/tls" --enrollment.profile tls --csr.hosts peer1.mvd.auto.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/mvd/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
  cp "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer1.mvd.auto.com/tls/server.key"

  echo "Registering peer2"
  set -x
  fabric-ca-client register --caname ca-mvd --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/mvd/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer2 msp"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:11054 --caname ca-mvd -M "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/mvd/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/mvd.auto.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/msp/config.yaml"

  echo "Generating the peer2-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:11054 --caname ca-mvd -M "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/tls" --enrollment.profile tls --csr.hosts peer2.mvd.auto.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/mvd/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
  cp "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer2.mvd.auto.com/tls/server.key"


}

peermanufacturer
peerdealer
peermvd