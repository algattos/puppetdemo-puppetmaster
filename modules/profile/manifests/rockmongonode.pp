
class profile::rockmongonode inherits profile::base	{
	notify	{"You have hit the rockmongonode profile...": }

	exec	{"apt_get_update": 
		command	=> "/usr/bin/apt-get update",
	}

	package	{"git":
		ensure		=> installed,
		provider	=> apt,
		require 	=> Exec['apt_get_update']
	}

	package	{"php5":
		ensure		=> installed,
		provider	=> apt,
		require 	=> Exec['apt_get_update']
	}

	package	{"libapache2-mod-php5":
		ensure		=> installed,
		provider	=> apt,
		require		=> Package['php5']
	}


	package	{"php5-dev":
		ensure		=> installed,
		provider	=> apt,
		require		=> Package['php5']
	}

}
