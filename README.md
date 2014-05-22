# php54 cookbook

Get php 5.4 installed on CentOS, RHEL and Fefora.

# Requirements

- yum cookbook
- yum-epel cookbook

# Usage

## Install PHP

Using a recpie
```ruby
include_recipe "php54"
```
Using a node json file
```json
{
	"runlist": ["recipe[php54]"]
}
```

## Installing PHP packages

The php_package definition uses the package definition but prefixes the package name with ```php54-php-``` to the package name.

```ruby
php_package "cli" do 
	action :install
end
```

## Using FPM

The php_fpm_pool definition from the php-fpm cookbook as been ripped off here with adjustments made to work with the php54 packages

```ruby
php_fpm_pool node['lemp']['app_name'] do
  listen node['lemp']['php_socket']
  user node['nginx']['user']
  group node['nginx']['user']
  enable :true
end
```

# Attributes

# Recipes

# Author

Author:: Daniel Chalk (<daniel-chalk@hotmail.co.uk>)
