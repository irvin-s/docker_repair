FROM oddlid/debian-base:stretch
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN apt-get -qq update \
		&& \
		apt-get install -y --no-install-recommends \
		ngircd \
		&& \
		apt-get clean autoclean \
		&& \
		apt-get autoremove -y \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY ngircd.conf /etc/ngircd/ngircd.conf

#VOLUME ["/etc/ngircd"]
EXPOSE 6668
CMD ["ngircd", "-n"]
