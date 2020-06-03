FROM debian:jessie-slim

RUN apt-get update
RUN apt-get upgrade -y

# Minimal tools required by acme-dns-tiny CI
RUN apt-get install -y --no-install-recommends \
	python3-dnspython \
	python3-coverage \
	python3-pip

# Allows run python3-coverage with same command than manual install by pip
RUN update-alternatives --install \
	/usr/bin/python3-coverage \
	coverage \
	/usr/bin/python3.4-coverage \
	1

RUN ln -s /etc/alternatives/coverage /usr/bin/coverage
