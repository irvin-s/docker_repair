FROM ubuntu:14.04

# See https://github.com/tianon/dockerfiles

ENV DEBIAN_FRONTEND noninteractive

RUN apt update &&\
    apt install -y ca-certificates procps apt-transport-https curl

WORKDIR /opt/cookbooks
RUN curl -Lo windows.tar.gz https://supermarket.chef.io/cookbooks/windows/versions/4.3.4/download && \
    tar -xzf windows.tar.gz

RUN curl -Lo /tmp/chef.deb https://packages.chef.io/files/stable/chef/14.0.190/ubuntu/14.04/chef_14.0.190-1_amd64.deb && \
    dpkg -i /tmp/chef.deb

RUN rm /usr/sbin/policy-rc.d; \
	rm /sbin/initctl; dpkg-divert --rename --remove /sbin/initctl

RUN /usr/sbin/update-rc.d -f ondemand remove; \
	for f in \
		/etc/init/u*.conf \
		/etc/init/mounted-dev.conf \
		/etc/init/mounted-proc.conf \
		/etc/init/mounted-run.conf \
		/etc/init/mounted-tmp.conf \
		/etc/init/mounted-var.conf \
		/etc/init/hostname.conf \
		/etc/init/networking.conf \
		/etc/init/tty*.conf \
		/etc/init/plymouth*.conf \
		/etc/init/hwclock*.conf \
		/etc/init/module*.conf\
	; do \
		dpkg-divert --local --rename --add "$f"; \
	done; \
	echo '# /lib/init/fstab: cleared out for bare-bones Docker' > /lib/init/fstab

COPY tests/packaging/images/socat /bin/socat

# Insert our fake certs to the system bundle so they are trusted
COPY tests/packaging/images/certs/*.signalfx.com.* /
RUN cat /*.cert >> /etc/ssl/certs/ca-certificates.crt

COPY tests/packaging/images/init-fake.conf /etc/init/fake-container-events.conf

COPY deployments/chef /opt/cookbooks/signalfx_agent

WORKDIR /opt

CMD ["/sbin/init", "-v"]
