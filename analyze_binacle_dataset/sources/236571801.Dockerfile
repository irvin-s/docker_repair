FROM ubuntu:16.04

ADD docker/publisher/publishOrders /home/publishOrders

WORKDIR /home

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y curl mysql-client

RUN chmod +x /home/publishOrders

ENTRYPOINT [ "/home/publishOrders" ]



# docker run -it -e DBUSER='' -e DBPASS='' -e ADMINLOGIN='' -e ADMINPASSWORD='' --net iexec-scheduler_iexec-net --name iexec-order-publisher iexechub/iexec-order-publisher