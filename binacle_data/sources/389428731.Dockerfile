FROM ubuntu:14.04

RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y lib32z1 libc6-i386 apache2 
RUN apt-get install -y libstdc++6 lib32stdc++6
RUN apt-get install -y gcc
RUN apt-get install -y libcurl3 libcurl4-openssl-dev

RUN useradd -m ctf

COPY ./bin/ /home/ctf/
COPY ./start.sh /start.sh
RUN chmod +x /start.sh
RUN chmod +x /home/ctf/setup.sh
RUN mv /home/ctf/flag /flag
RUN chown root:www-data /flag
RUN chmod 440 /flag
RUN bash /home/ctf/setup.sh
WORKDIR /

CMD ["/start.sh"]

EXPOSE 80
