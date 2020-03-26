FROM oddlid/debian-base:stretch
MAINTAINER Odd Eivind Ebbesen <oddebb@gmail.com>

# Change this to your preference
RUN ln -fs /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

RUN apt-get update -qq --fix-missing \
		&& \
		apt-get install -y --no-install-recommends \
		python2.7 \
		python2.7-dev \
		python-pip \
		python-setuptools \
		python-virtualenv \
		&& \
		pip install -I gmvault==1.9.1 \
		&& \
		apt-get clean autoclean \
		&& \
		apt-get autoremove -y \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY gmvault.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/gmvault.sh
RUN useradd -m -u 1000 -U gmvault

VOLUME ["/home/gmvault/.gmvault", "/home/gmvault/gmvault-db"]

ENTRYPOINT ["tini", "-g", "--", "gmvault.sh"]
CMD ["bash"]

