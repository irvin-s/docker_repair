FROM portworx/px-enterprise:2.0.3.6

WORKDIR /

ADD px-node-wiper.sh /px-node-wiper.sh

ENTRYPOINT ["bash", "/px-node-wiper.sh"]
CMD []
