define :php_fpm_pool, :template => "pool.erb", :enable => true do

	#raise required fields
	raise "listen required" if params[:listen].nil?

	listen_owner = params[:listen_owner] || node['php54']['fpm']['listen_owner']
	listen_group = params[:listen_group] || node['php54']['fpm']['listen_group']
	listen_user = params[:listen_user] || node['php54']['fpm']['listen_user']

	pool_name = params[:name]
	php_options = {}.merge!(params[:php_options] || {})
	conf_file = "#{node['php54']['fpm']['pool_conf_dir']}/#{pool_name}.conf"
	error_log = "#{node['php54']['fpm']['log_dir']}/php54-#{pool_name}-error.log"
	php_options['php_admin_flag[log_errors]'] = php_options['php_admin_flag[log_errors]'] || error_log

	include_recipe "php54::default"
	include_recipe "php54::fpm"

	directory node['php54']['fpm']['pool_conf_dir'] do
		owner "root"
		group "root"
		mode "00644"
		recursive true
		action :create
	end

	if params[:enable]
		template conf_file do
			source params[:template]
			owner "root"
			group "root"
			mode 00644
			cookbook params[:cookbook] || "php54"
			variables(
				:pool_name => pool_name,
				:listen => params[:listen],
				:listen_owner => params[:listen_owner],
				:listen_group => params[:listen_group],
				:listen_mode => params[:listen_mode],
				:allowed_clients => params[:allowed_clients],
				:user => params[:user],
				:group => params[:group],
				:process_manager => params[:process_manager],
				:max_children => params[:max_children],
				:start_servers => params[:start_servers],
				:min_spare_servers => params[:min_spare_servers],
				:max_spare_servers => params[:max_spare_servers],
				:max_requests => params[:max_requests],
				:catch_workers_output => params[:catch_workers_output],
				:security_limit_extensions => params[:security_limit_extensions],
				:php_options => php_options,
				:params => params
			)
			notifies :restart, "service[php54-php-fpm]"
		end
	else
		cookbook_file conf_file do
			action :delete
			notifies :restart, "service[php54-php-fpm]"
		end
	end
end