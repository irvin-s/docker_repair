FROM rickcarlino/rmq_base:rc1
# TODO: Move this into base image on dockerhub

RUN apt-get update && apt-get install curl --yes

ADD ./rabbitmq.config /etc/rabbitmq/
ADD ./start.sh /
RUN chmod +x /start.sh

ENV APIHOST="your_domain_or_ip" \
	APIPORT="3000" \
	PKAPIURL="http://your_domain_or_ip:3000/api/public_key" \
	VHOST="/"

EXPOSE 5672 5672
EXPOSE 1883 1883
EXPOSE 8883 8883
EXPOSE 15675 15675

CMD ["/bin/bash","-c","/start.sh"]
