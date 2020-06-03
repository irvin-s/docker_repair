FROM microsoft/dotnet:1.0.0-preview2-sdk
RUN mkdir -p /IdSvrHost
WORKDIR /IdSvrHost
COPY . /IdSvrHost
RUN ["dotnet", "restore"]
EXPOSE 22530/tcp
ENTRYPOINT ["dotnet", "run"]