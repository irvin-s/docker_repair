FROM tutum/lamp

RUN rm -rf /app

WORKDIR /app

COPY ./www /app

EXPOSE 80

CMD ["/run.sh"]
