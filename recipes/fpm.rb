php_package "fpm"

service "php54-php-fpm" do
	service_name "php54-php-fpm"
	supports :start => true, :stop => true, :restart => true, :reload => true
	action [ :enable, :start ]
end