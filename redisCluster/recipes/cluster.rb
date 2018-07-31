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

# create cluster with redistrib utility
execute 'redis-trib' do
  command "#{node[:redis][:utility_dir]}redis-trib.rb create #{node['opsworks']['layers']['redisnode']['instances']['node1redis']['private_ip']}:6380 #{node['opsworks']['layers']['redisnode']['instances']['node2redis']['private_ip']}:6380 #{node['opsworks']['layers']['redisnode']['instances']['node3redis']['private_ip']}:6380"
  user 'root'
end
