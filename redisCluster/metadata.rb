name 'redisCluster'
maintainer 'Andrea Alvarez'
maintainer_email 'andreaalvarezgt@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures redisCluster'
long_description 'Installs/Configures redisCluster'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/redisCluster/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/redisCluster'

%w(debian ubuntu).each do |os|
  supports os
end
