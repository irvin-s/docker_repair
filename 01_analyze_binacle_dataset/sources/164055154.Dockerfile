FROM node:0.10-onbuild
MAINTAINER Eugeny Vlasenko <mahnunchik@gmail.com>

ADD run.sh run.sh
RUN chmod +x run.sh

EXPOSE 8080
ENV PORT 8080

CMD ["start"]
ENTRYPOINT ["./run.sh"]
