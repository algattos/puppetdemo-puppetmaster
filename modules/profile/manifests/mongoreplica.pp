
class profile::mongoreplica inherits profile::base	{
	notify	{"You have hit the mongoreplica profile...": }
	package	{"mongodb":
		ensure		=> installed,
		provider	=> apt,
	}
}
