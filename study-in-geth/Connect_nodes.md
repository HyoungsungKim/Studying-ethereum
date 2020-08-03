# Connect nodes

https://geth.ethereum.org/docs/interface/private-network

https://geth.ethereum.org/getting-started/private-net

1. Make genesis file using ./puppeth
2. Init genesis file using ./geth
3. Run bootnode

example)

```
geth --datadir {data directory} --networkid {12345} --nat extip:{172.**.**.***} consloe
```

4. Get a bootnode info

example)

```
>admin.nodeInfo.enode
enode://8c544b4a07da02a9ee024def6f3ba24b2747272b64e16ec5dd6b17b55992f8980b77938155169d9d33807e501729ecb42f5c0a61018898c32799ced152e9f0d7@9[::]:30301 console
```

5. Connect member node

- Init geth using same genesis file of bootnode
- Use different directory with bootnode
- Use same networkid with bootnode
- Replace `<bootstrap-node-record> ` to result of `admin.nodeInfo.encode` 

```
geth --datadir {datadir} --networkid {12345} --port 30305 --bootnodes <bootstrap-node-record> console
```

example)

```
geth --datadir ~/data --networkid 12345 --port 30305 --bootnodes enode://8c544b4a07da02a9ee024def6f3ba24b2747272b64e16ec5dd6b17b55992f8980b77938155169d9d33807e501729ecb42f5c0a61018898c32799ced152e9f0d7@9[::]:30301 console
```

6. Monitor node states

```

```



