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

# Install redis
package 'redis-server' do
  action :install
end

# Configure master node template
template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        'redis.conf.erb'
  owner         'root'
  group         'root'
  mode          '0644'
  variables     redis: node[:redis], redis_server: node[:redis][:server]
end

# Create cluster directory
directory node[:redis][:cluster_dir] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
