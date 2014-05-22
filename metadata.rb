name 'php54'
maintainer 'Daniel Chalk'
maintainer_email 'daniel-chalk@hotmail.co.uk'
license'Apache 2.0'
description'Installs/Configures php54'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version'0.1.0'

%w(redhat centos fedora).each do |platform|
	supports platform
end

%w(yum yum-epel).each do |cookbook|
	depends cookbook
end