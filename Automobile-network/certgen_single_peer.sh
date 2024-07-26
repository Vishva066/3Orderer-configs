#!/bin/bash

export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/manufacturer.auto.com/

#Registering new peer

fabric-ca-client register --caname ca-manufacturer --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"

#Generating peer msp by enrolling

fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-manufacturer -M "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"

cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/msp/config.yaml"

#Generating tls certificates
echo "Generating the peer1-tls certificates, use --csr.hosts to specify Subject Alternative Names"

fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-manufacturer -M "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls" --enrollment.profile tls --csr.hosts peer1.manufacturer.auto.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/manufacturer/ca-cert.pem"

# Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config

cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/ca.crt"

cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/server.crt"

cp "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/server.key"

