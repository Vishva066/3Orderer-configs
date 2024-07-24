# Orderer Configuration

In this repo we will see what happens when the orderer goes down. 

Here the consensus we are using is raft consensus.

Since we are using raft consensus the transaction may go through if it has maximum no of ordering nodes available. 

The formula to calculate how many nodes should be there for the txn to take place is 

((N/2) + 1) 

Here N - No of orderers

Eg If the no of orderers are 3 then with 2 orderes itself the transaction will go through

## Chaincode Invoking

Whenever we invoke a chaincode or we always pass a orderer endpoint. But if the orderer endpoint is down means we have to pass other orderer endpoints also. 

To test it out we have created a network with 3 orderers. 

If one orderer fails also we are creating a loop and trying the other ones. 

You can check out this logic in Automobile-network/```chaincode_exe.sh file```

## Client Application

In the client application also we will send the transaction to the orderer only but there we don't need to specify anything. 

We just need to increase the timeout of different txns. It will automatically handle the txn according to the orderer availability. 

