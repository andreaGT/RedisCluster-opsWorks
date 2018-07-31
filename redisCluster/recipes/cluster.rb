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

# Install ruby
package 'ruby' do
  action :install
end

execute 'gem-redis' do
  command 'gem install redis'
  user 'root'
end

# Give execution permission to utility file
file "#{node[:redis][:utility_dir]}/redis-trib.rb" do
  mode '0755'
end

# create cluster with redistrib utility
execute 'redis-trib' do
  command "#{node[:redis][:utility_dir]}redis-trib.rb create #{node[:redis][:master_server]}:6380 #{node[:redis][:master_server]}:6381 #{node[:redis][:master_server]}:6382"
  user 'root'
end
