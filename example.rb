require 'redis_client'
require 'redis_cluster_client'

puts '== without clustering & hash keys =='
simple_client = RedisClient.config(url: 'redis://127.0.0.1:7000/0').new_client
begin
  simple_client.call('SET', 'MYKEY', '1') # fails with "MOVED"
rescue RedisClient::CommandError => e
  puts e
end

puts '== with clustering & hash keys =='

cluster_client = RedisClient.cluster(nodes: 'redis://127.0.0.1:7000/0',
                                     connect_with_original_config: true).new_client
begin
  cluster_client.call('SET', '{0}MYKEY', '1')
  val = cluster_client.call('GET', '{0}MYKEY')
  puts "Found val=#{val}"
rescue RedisClient::CommandError => e
  puts e
end
