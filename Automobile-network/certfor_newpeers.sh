#!/bin/bash

echo "In which organization peer should be created?"
echo "1. manufacturer"
echo "2. dealer"
echo "3. mvd"
read -p "Enter the number (1-3): " org_choice

case $org_choice in
    1)
        ORG="manufacturer"
        PORT=7054
        ;;
    2)
        ORG="dealer"
        PORT=8054
        ;;
    3)
        ORG="mvd"
        PORT=11054
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected organization: $ORG"
echo "Using port for CA: $PORT"

read -p "How many peers do you want to create for $ORG? " num_peers

export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/${ORG}.auto.com/

export ca_name = "ca-${ORG}"

generate_peer_certs(){

local peer_num = $1

local peer_name = "peer${peer_num}.${ORG}.auto.com"

local peerid = "peer${peer_num}"

local peerpw = "${peerid}pw"

local url = "https://${peerid}:${peerpw}@localhost:${PORT}"

#Registering new peer

fabric-ca-client register --caname $ca_name --id.name $peerid --id.secret $peerpw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/${ORG}/ca-cert.pem"

#Generating peer msp by enrolling

fabric-ca-client enroll -u ${url} --caname $ca_name -M "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/${ORG}/ca-cert.pem"

cp "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/msp/config.yaml"

#Generating tls certificates
echo "Generating the ${peerid}-tls certificates, use --csr.hosts to specify Subject Alternative Names"

fabric-ca-client enroll -u $url --caname $ca_name -M "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/tls" --enrollment.profile tls --csr.hosts $peer_name --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/${ORG}/ca-cert.pem"

# Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config

cp "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/tls/ca.crt"

cp "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/tls/server.crt"

cp "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/tls/keystore/"* "${PWD}/organizations/peerOrganizations/${ORG}.auto.com/peers/${peer_name}/tls/server.key"

}

for i in $(seq 1 $num_peers)
do
    generate_peer_certs $i
done

echo "Certificate generation complete for $num_peers peers in the $ORG organization using port ${PORT}."

echo "Generate the docker compose files for these peers"

