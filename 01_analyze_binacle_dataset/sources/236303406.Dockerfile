FROM microsoft/dotnet:1.1.1-sdk

COPY . /service

WORKDIR /service

RUN chmod +x ./docker_init.sh

EXPOSE 40500/tcp

CMD ["./docker_init.sh"]
