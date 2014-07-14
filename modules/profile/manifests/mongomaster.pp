
class profile::mongomaster inherits profile::base	{
	notify	{"You have hit the mongomaster profile...": }
	package	{"mongodb":
		ensure		=> installed,
		provider	=> apt,
	}
}
