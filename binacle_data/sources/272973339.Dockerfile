FROM microsoft/dotnet:2-runtime
 
WORKDIR /app
COPY artifacts .
ENV ASPNETCORE_URLS=http://+:80

COPY ./startup.sh .
RUN chmod 755 /app/startup.sh

EXPOSE 80

CMD ["sh", "/app/startup.sh"]
