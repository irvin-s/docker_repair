FROM mhtsbt/dotnet:1.1.0

ADD ./src/GogsBoard/package.json /app/src/GogsBoard/package.json
RUN cd /app/src/GogsBoard && npm install -y && npm install gulp -g -y

COPY ./ /app/

WORKDIR /app

RUN ["dotnet", "restore"]

WORKDIR /app/src/GogsBoard

ENV gogsurl=url
ENV gogstoken=token

EXPOSE 5000
ENTRYPOINT ["dotnet", "run"]