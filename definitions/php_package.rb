
define :php_package, :action => :install do
	package "php54-php-#{params[:name]}" do
		action params[:action]
	end
end