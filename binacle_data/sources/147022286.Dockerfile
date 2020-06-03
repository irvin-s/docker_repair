FROM phusion/baseimage:latest

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get -y update
RUN apt-get -y install mongodb
RUN apt-get -y install git
RUN apt-get -y install ca-certificates
RUN apt-get -y install python python-flask python-markdown python-pymongo

RUN git clone https://github.com/dwwkelly/note /root/note

EXPOSE 5000

ADD note.conf.docker /root/.note.conf

ENTRYPOINT /root/note/web.py

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
