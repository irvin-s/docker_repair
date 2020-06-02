FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
RUN apt-get -y update
RUN apt-get install -y net-tools
RUN apt-get install -y netcat
WORKDIR /app
COPY wait-for .
RUN chmod 777 wait-for
EXPOSE 50379

FROM microsoft/dotnet:2.1-sdk AS publish
COPY PKICertificate/PKI-Root_CA2.crt /usr/local/share/ca-certificates/
COPY PKICertificate/PKI-Issuing_CA2.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
WORKDIR /src
COPY . .
RUN dotnet restore
WORKDIR "/src/OcelotSample.WeatherService"
RUN dotnet publish "OcelotSample.WeatherService.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "OcelotSample.WeatherService.dll"]
