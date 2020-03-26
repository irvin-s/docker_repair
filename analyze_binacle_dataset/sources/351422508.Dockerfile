FROM debian:8
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach
RUN apt-get update \
  && apt-get install -y socat wget jq \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD infect.sh /infect.sh
ADD LICENSE /LICENSE
ENTRYPOINT [ "/infect.sh" ]
CMD [ "" ]
