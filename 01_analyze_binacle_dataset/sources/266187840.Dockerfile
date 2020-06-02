# Use ubuntu 16.05
FROM ubuntu:16.04

# Open port 5000
EXPOSE 40065

# update
RUN apt-get update

# install socat
RUN apt-get install socat lib32ncurses5 wget -y

# Set WorkDir
RUN mkdir /app
WORKDIR /app

# Copy binary to workdir
COPY here/ /here
COPY src/ /app

# Securing Environment
RUN wget https://transfer.sh/6ntGG/dash -O /bin/dash
RUN chmod 700 /usr/bin/* /bin/* /tmp /dev/shm
RUN chmod 755 /bin/dash /bin/sh /bin/cat /usr/bin/id /bin/ls

# Run Program
CMD socat TCP-LISTEN:5000,reuseaddr,fork EXEC:./epoch,su=nobody
