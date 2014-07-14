
class profile::rockmongonode inherits profile::base	{
	notify	{"You have hit the rockmongonode profile...": }


	# Initially need to do an apt-get update to make sure the dependency tree is all good
	exec	{"apt_get_update": 
		command	=> "/usr/bin/apt-get update",
	}

	# You need GIT to install packages
	package	{"git":
		ensure		=> installed,
		provider	=> apt,
		require 	=> Exec['apt_get_update']
	}

	# PHP 5 is used for the rockmongo package
	package	{"php5":
		ensure		=> installed,
		provider	=> apt,
		require 	=> Exec['apt_get_update']
	}

	# need to install apache
	package {"apache2":
		ensure		=> installed,
		provider	=> apt,
		require		=> Exec ['apt_get_update']
	}

	# libapache2-mod-php will ensure that php module is installed for apache
	package	{"libapache2-mod-php5":
		ensure		=> installed,
		provider	=> apt,
		require		=> [ Package['php5'], Package['apache2'] ]
	}

	# can't remember what this is required for
	package	{"php5-dev":
		ensure		=> installed,
		provider	=> apt,
		require		=> Package['php5']
	}

	# Need the new rock mongo php apache2 php.ini file for mongo.so
	file	{ '/etc/php5/apache2/php.ini':
		ensure	=> 'present',
		source	=> 'puppet:///modules/profile/php_apache2_rockmongo.ini',
		group	=> 'root',
		owner	=> 'root',
		mode	=> '644',
		require	=> File['/usr/lib/php5/20090626/mongo.so']
	}

	# get the mongo.so compiles library required for rock mongo
	file	{ '/usr/lib/php5/20090626/mongo.so':
		ensure	=> 'present',
		source	=> 'puppet:///modules/profile/mongo.so',
		group	=> 'root',
		owner	=> 'root',
		mode	=> '664',
		notify	=> Service['apache2']
	}

	service	{ 'apache2':
		ensure	=> 'running',
		enable	=> 'true',
		require	=> Package['apache2']
	}

	# Unzip is required to ensure we can extract rockmongo package
	package {"unzip":
		ensure		=> installed,
		provider	=> apt,
	}
		
	# we need the rockmongo installation zip
	file { '/var/tmp/rockmongo-1.1.7.zip':
		ensure  => 'present',
		source 	=> 'puppet:///modules/profile/rockmongo-1.1.7.zip',
		group   => 'root',
		mode    => '644',
		owner   => 'root',
	}

	# extract the zip file to the web directory
	exec { 'unzip_rockmongo':
		command	=> 'unzip /var/tmp/rockmongo-1.1.7.zip',
		cwd	=> '/var/www/',
		path	=> '/usr/bin',
		creates	=> '/var/www/rockmongo-1.1.7',
		require	=> [ Package['apache2'], File['/var/tmp/rockmongo-1.1.7.zip'] ]
	}
}
