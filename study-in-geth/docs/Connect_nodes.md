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
> admin.nodeInfo.enode
"enode://5bd67e76c826c05ffd8120d96022e2fc02ae2c64705d0297d85e0374fd8a0f31c9df187a3edbe9a4db1ef6a0ca059a3f0f270992060daa3192e961205cdead2a@172.***.***.***:30305"

```

```
> admin.nodeInfo.enr
"enr:-Je4QFxGpRYN9wMTh7sxAoGGai_MTKg6ki1NbYU82e7_wcTCIrH7jdEhyowwjwkc-IkA3iNMHIE5jAH1t-AdUQZ4vYIDg2V0aMfGhAQ66A6AgmlkgnY0gmlwhKwaEHiJc2VjcDI1NmsxoQJb1n52yCbAX_2BINlgIuL8Aq4sZHBdApfYXgN0_YoPMYN0Y3CCdmGDdWRwgnZh"

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
geth --datadir ~/data --networkid 12345 --port 30305 enode://5bd67e76c826c05ffd8120d96022e2fc02ae2c64705d0297d85e0374fd8a0f31c9df187a3edbe9a4db1ef6a0ca059a3f0f270992060daa3192e961205cdead2a@172.***.***.***:30305 consol
```

6. Monitor node states

```
admin.peeros
```



