from stackbrew/ubuntu:12.04
maintainer Shipyard Project "http://shipyard-project.com"
run apt-get update
run apt-get install -y libdevmapper1.02.1 libsqlite3-0
add shipyard-agent /usr/local/bin/shipyard-agent
add .docker/run.sh /usr/local/bin/run
expose 4500
cmd ["/usr/local/bin/run"]
