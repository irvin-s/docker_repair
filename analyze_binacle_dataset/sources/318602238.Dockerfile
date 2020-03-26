FROM ubuntu
LABEL maintainer="Mofe Salami (tsalami@uk.ibm.com)"
RUN apt-get update
RUN apt-get install -y nginx
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
