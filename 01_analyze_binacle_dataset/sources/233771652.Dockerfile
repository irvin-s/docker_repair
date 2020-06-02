FROM multi_base

MAINTAINER Tim Co <tim@pinn.ai>

ENV DEBIAN_FRONTEND noninteractive

#   Run docker container
#
#   Application based container building off of the base container.
#   Application specific commands are initiated here
#   making Pinnface functionality accessible. 

# Copy API into /var/www/app
ADD . .
VOLUME ["/var/www/app"]

# Expose logging
RUN ln -sf /dev/stdout /var/log/uwsgi/app.log

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/app.conf"]
