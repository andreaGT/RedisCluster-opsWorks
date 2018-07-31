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

# Master-slave mode
# node.default[:redis][:slave] = 'yes'

# Cluster group mode
node.default[:redis][:clusterenable] = 'yes'

# Configure new redis instance for each port defined in attributes/default file

node[:redis][:ports].each do |port|
  node.default[:redis][:pid_file]          = "/var/run/redis-#{port}.pid"
  node.default[:redis][:server][:port]     = port
  node.default[:redis][:log_dir]           = "/var/log/redis-#{port}"
  node.default[:redis][:data_dir]          = "/var/lib/redis-#{port}"

  # Create node directory into cluster directory
  directory "#{node[:redis][:cluster_dir]}/node#{port}" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  # Create log directory for redis slave
  directory node[:redis][:log_dir] do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  # Create lib directory for the new instance
  directory node[:redis][:data_dir] do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  # Configure new instance node template
  template "#{node[:redis][:cluster_dir]}/node#{port}/redis#{port}.conf" do
    source        'redis.conf.erb'
    owner         'root'
    group         'root'
    mode          '0644'
    variables     redis: node[:redis], redis_server: node[:redis][:server]
  end

  # Start redis node instance
  execute 'redis-server' do
    command "redis-server #{node[:redis][:cluster_dir]}/node#{port}/redis#{port}.conf"
    user 'root'
  end
end
