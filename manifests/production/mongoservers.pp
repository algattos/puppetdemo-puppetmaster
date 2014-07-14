
node "ec2-54-193-121-212.us-west-1.compute.amazonaws.com" {
	include profile::mongomaster
	include profile::rockmongonode
	notify {"Something to notify":}
}
