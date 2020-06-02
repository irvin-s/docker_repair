FROM python:2.7
ENV TERM xterm
RUN apt-get update && apt-get install -y python-dev libldap2-dev libsasl2-dev libssl-dev
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
CMD /entrypoint.sh
