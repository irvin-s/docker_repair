FROM debian:jessie
COPY docker /docker
RUN sh docker/setup.sh
EXPOSE 80 8085 1080 1025 3306
CMD ["/usr/bin/supervisord", "-n"]
