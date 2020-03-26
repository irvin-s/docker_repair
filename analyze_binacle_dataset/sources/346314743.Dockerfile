FROM bitnami/ruby:2.2.3-0-r01

USER root
RUN gem install fakes3

EXPOSE 8080
VOLUME ["/var/lib/fakes3"]
CMD ["fakes3", "-r", "/var/lib/fakes3", "-p", "8080"]
