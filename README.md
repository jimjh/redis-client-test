Setup a 3-node cluster as per https://redis.io/docs/management/scaling/.

Run

```
$ bundle
$ bundle exec ruby example1.rb
```

- Notice that the basic client fails with a `MOVED` error.
- Notice that the cluster client succeeds.
- Observe how we can use a hash key to force a fixed hash slot.

In a separate CLI, use

```
$ redis-cli -c -p 127.0.0.1:7000
redis> GET {0}MYKEY
```
