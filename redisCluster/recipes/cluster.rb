#
# Cookbook:: redisCluster
# Recipe:: default
#
# Copyright:: 2018, Andrea Alvarez
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

nodeinstance1 = search('aws_opsworks_instance', 'hostname:node1redis').first
node1ip = "#{nodeinstance1[:private_ip]}"

nodeinstance2 = search('aws_opsworks_instance', 'hostname:node2redis').first
node2ip = "#{nodeinstance2[:private_ip]}"

nodeinstance3 = search('aws_opsworks_instance', 'hostname:node3redis').first
node3ip = "#{nodeinstance3[:private_ip]}"

port = node.default[:redis][:server][:node_port]

file '/home/nodesip' do
  content "#{node1ip},#{node2ip},#{node3ip},#{port}"
end

execute 'cluster-meet-2' do
  command "redis-cli -c -h #{node1ip} -p #{port} cluster meet #{node2ip} #{port}"
end

execute 'cluster-meet-3' do
  command "redis-cli -c -h #{node1ip} -p #{port} cluster meet #{node3ip} #{port}"
end

execute 'cluster-addslots1' do
  command "redis-cli -c -h #{node1ip} -p #{port} cluster addslots {0..5461}"
end

execute 'cluster-addslots2' do
  command "redis-cli -c -h #{node2ip} -p #{port} cluster addslots {5462..10923}"
end

execute 'cluster-addslots3' do
  command "redis-cli -c -h #{node3ip} -p #{port} cluster addslots {10924..16383}"
end
# create cluster with redistrib utility
# execute 'redis-trib' do
#   command "#{node[:redis][:utility_dir]}redis-trib.rb create #{node1ip}:#{port} #{node2ip}:#{port} #{node3ip}:#{port} | yes"
#   user 'root'
# end
