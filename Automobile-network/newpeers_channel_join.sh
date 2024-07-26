#!/bin/bash

export FABRIC_CFG_PATH=./peercfg
export CHANNEL_NAME=autochannel
export CORE_PEER_LOCALMSPID=ManufacturerMSP
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/manufacturer.auto.com/users/Admin@manufacturer.auto.com/msp
export CORE_PEER_ADDRESS=localhost:5010
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/auto.com/orderers/orderer.auto.com/msp/tlscacerts/tlsca.auto.com-cert.pem
export MANUFACTURER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/manufacturer.auto.com/peers/peer1.manufacturer.auto.com/tls/ca.crt
export DEALER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/dealer.auto.com/peers/peer0.dealer.auto.com/tls/ca.crt
export MVD_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/mvd.auto.com/peers/peer0.mvd.auto.com/tls/ca.crt


peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

peer channel list

peer lifecycle chaincode install kbaauto.tar.gz

peer lifecycle chaincode queryinstalled