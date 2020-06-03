FROM microsoft/dotnet:2.0-sdk as base
RUN apt-get update
RUN apt-get -y install ghostscript

FROM base AS final 
WORKDIR /publish
COPY . ./
ENTRYPOINT ["dotnet", "publish/QueueStorage.Consumer.dll"]