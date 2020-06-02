FROM beatrak/node-base

RUN mkdir -p /root/app

WORKDIR /root/app

#EXPOSE 8080

# this we need to call with below and then run
# /root/app/start-dev.sh
# k8s-shell:
#	kubectl exec ${CONTAINER_NAME_DEV} -i -t -- /bin/bash

COPY ./waitloop.sh ./start-dev.sh /
RUN chmod a+x /waitloop.sh && chmod a+x /start-dev.sh
CMD ["/waitloop.sh"]



