FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
RUN apt-get -y update
RUN apt-get install -y net-tools
RUN apt-get install -y netcat
WORKDIR /app
COPY wait-for .
RUN chmod 777 wait-for
EXPOSE 59495

FROM microsoft/dotnet:2.1-sdk AS publish
WORKDIR /src
COPY . .
RUN dotnet restore
WORKDIR "/src/OcelotSample.APIGateway"
RUN dotnet publish "OcelotSample.APIGateway.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
CMD ["dotnet", "OcelotSample.APIGateway.dll"]

