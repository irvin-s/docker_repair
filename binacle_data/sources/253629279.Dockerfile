FROM ubuntu:latest
RUN /bin/bash -c 'source /etc/lsb-release; echo "deb http://ppa.launchpad.net/george-edison55/cmake-3.x/ubuntu $DISTRIB_CODENAME main" >> /etc/apt/sources.list'
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated python cmake git build-essential libreadline-dev libncurses5-dev xinetd 
RUN useradd -m lolc0ded
RUN git clone https://github.com/justinmeza/lci.git
WORKDIR /lci
RUN git checkout future
RUN chmod u+x /lci/install.py
RUN chown -R lolc0ded:lolc0ded /lci/
RUN /lci/install.py
WORKDIR /var/www/
RUN mkdir -p /var/www/html/
COPY ./start.sh /var/www/start.sh
RUN chmod u+x /var/www/start.sh
COPY ./lolc0ded.lol /var/www/lolc0ded.lol
ADD ./html/ /var/www/html/  
RUN chown -R lolc0ded:lolc0ded /var/www/
COPY ./flag.lol /home/lolc0ded/flag.lol
RUN chown -R lolc0ded:lolc0ded /home/lolc0ded/flag.lol
COPY ./lolc0dedservice /etc/xinetd.d/lolc0dedservice
EXPOSE 13337
CMD ["/usr/sbin/xinetd", "-d"]
