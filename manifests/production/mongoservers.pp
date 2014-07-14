

node "ec2-54-183-118-104.us-west-1.compute.amazonaws.com" {
	include profile::mongomaster
	include profile::rockmongonode
}

node "ec2-54-215-233-228.us-west-1.compute.amazonaws.com" {
	include profile::mongoreplica
}
