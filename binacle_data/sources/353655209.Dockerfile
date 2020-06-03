# container-agent Dockerfile
FROM clusterhq/flocker-core:1.8.0
MAINTAINER Madhuri Yechuri <madhuri.yechuri@clusterhq.com>

CMD ["/usr/sbin/flocker-container-agent"]
