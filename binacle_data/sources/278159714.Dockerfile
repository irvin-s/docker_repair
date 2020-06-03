FROM microsoft/dotnet:2.2-sdk AS build-env
#ARG version
WORKDIR /app

# copy csproj and restore as distinct layers
COPY . ./
#RUN dotnet tool install  -g dotnet-property   
#RUN dotnet tool list -g
#RUN /root/.dotnet/tools/dotnet-property "Stankinsv2/**/Stankins*.csproj" Version:$version
RUN dotnet publish -c Release -r linux-x64 -o out StankinsV2/StankinsData/StankinsDataWeb.csproj 

# build runtime image
FROM microsoft/dotnet:2.2-runtime-deps
WORKDIR /app
COPY --from=build-env /app/StankinsV2/StankinsData/out ./
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000/tcp
ENTRYPOINT ["./StankinsDataWeb"]

