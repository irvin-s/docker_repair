FROM ubuntu:14.04

# dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y ucspi-tcp
RUN apt-get install -y tmpreaper

# Create users
# ed user -- everything will run under this one
RUN adduser --disabled-password --gecos '' ed
RUN adduser --disabled-password --gecos '' flaguser

ADD crontab /etc/cron.d/ed-cron
RUN chmod 0644 /etc/cron.d/ed-cron
RUN crontab /etc/cron.d/ed-cron
RUN touch /var/log/cron.log

WORKDIR /home/ed

# setup flag
COPY ./data/flag /home/ed
RUN chown -R root:root /home/ed/
RUN chown flaguser:ed /home/ed/flag
RUN chmod 440 /home/ed/flag

# assorted permissions
RUN chmod 1733 /tmp /var/tmp /dev/shm

# TODO: Resource limits

# setup ed challenge
COPY ./ed /home/ed

RUN chown flaguser:ed /home/ed/ed
RUN chmod +x /home/ed/ed
RUN chmod u+s /home/ed/ed

EXPOSE 8000
CMD (cron -f &) && tcpserver -l1000 0.0.0.0 8000 /home/ed/ed
