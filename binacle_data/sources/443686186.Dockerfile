FROM phusion/baseimage:0.9.10
MAINTAINER Victor Lin <bornstub@gmail.com>

# Set correct environment variables.
ENV HOME /root

ADD hello_baby.sh /tmp/hello_baby_v{{ builder.image_version }}.sh
RUN chmod +x /tmp/hello_baby_v{{ builder.image_version }}.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init", "--", "bash", "-c", "/tmp/hello_baby_v{{ builder.image_version }}.sh"]
