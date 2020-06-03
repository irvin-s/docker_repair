# Pull Ubuntu as base image
FROM       dockerfile/ubuntu
MAINTAINER Hardy Ferentschik <hardy@hibernate.org>

# Install Java 8
RUN        echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
           echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
           add-apt-repository -y ppa:webupd8team/java && \
           apt-get update && \
           apt-get install -y oracle-java8-installer

# Install supervisor to allow start/manage mutliple processes (http://supervisord.org/)
RUN        apt-get -y install supervisor && \
           mkdir -p /var/log/supervisor && \
           mkdir -p /etc/supervisor/conf.d
RUN        mkdir /var/log/supervisord
# Add supervisor configuration
ADD        etc/supervisor/supervisor.conf /etc/supervisor.conf

# Install Apache and enable CGI
RUN        apt-get install -y apache2
ADD        etc/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN        a2enmod cgi

# Install system monitoring tools
RUN        apt-get install -y sysstat
ADD        etc/sysstat/sysstat /etc/default/sysstat
RUN        apt-get install -y lsof
RUN        apt-get install -y tcpdump
RUN        apt-get install -y strace

# Add the java-rmi.cgi script in order to proxy RMI calls (RMI opens next to the main
# registry port 1099 dynamic ports for client/server commuication. This needs to be proxied,
# since Docker does not allow to expose a port range)
# Note: As of Java 8 HTTP RMI proxying is actually deprecated! Use this just for demo purposes.
ADD        etc/java/java-rmi.cgi /usr/lib/cgi-bin/java-rmi.cgi
RUN        chmod 755 /usr/lib/cgi-bin/java-rmi.cgi

# Add Java policy file (needed for running the jstad process)
ADD        etc/java/all.policy /demo/jvm-config/all.policy

# Add the demo source
ADD 	    src /demo

# Compile the demo
RUN 	    cd /demo; javac Demo.java;

# Make /demo the default directory
WORKDIR     /demo

# Expose the default Java RMI port
EXPOSE      1099

# At start run the supervisor daemon
# Use -n to run supervisord in the foreground to avoid the Docker container to exit
CMD []
ENTRYPOINT  ["supervisord", "-n", "-c", "/etc/supervisor.conf"]

