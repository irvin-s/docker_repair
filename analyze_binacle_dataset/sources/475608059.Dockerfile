FROM microsoft/dotnet:1.0.0-preview2-sdk
RUN mkdir -p /WebApi
WORKDIR /WebApi
COPY . /WebApi
RUN ["dotnet", "restore"]
EXPOSE 57391/tcp
ENTRYPOINT ["dotnet", "run"]