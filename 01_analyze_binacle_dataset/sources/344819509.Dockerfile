FROM resin/rpi-raspbian
COPY ./start.sh /start.sh
RUN chmod u+x /start.sh
CMD /start.sh
