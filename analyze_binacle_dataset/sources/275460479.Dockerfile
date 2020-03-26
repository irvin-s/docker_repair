FROM microsoft/dotnet:2.0-sdk
WORKDIR /publish
COPY . ./
ENTRYPOINT ["dotnet", "publish/Queue.Consumer.dll"]
