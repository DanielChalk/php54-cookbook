include_recipe "yum-epel"

node['php54']['software_collections'].each do |name, cfg|
	# installs the repo but wait for notification
	execute "install #{name} repo" do
		command "yum install -y #{cfg.src}"
		not_if {File.exists?("/etc/yum.repos.d/#{cfg.creates}")}
	end
end

%w(php54 php54-php).each do |pkg|
	package pkg  do 
		action :install
	end
end
