FROM gliderlabs/registrator:v7
LABEL maintainer="Dwolla Platform Team"
COPY registrator_on_ec2_hostname.sh /usr/local/bin/registrator_on_ec2_hostname.sh
RUN apk-install bash curl jq
ENTRYPOINT ["registrator_on_ec2_hostname.sh"]
