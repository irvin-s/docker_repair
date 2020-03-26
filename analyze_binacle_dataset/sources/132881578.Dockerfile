FROM microsoft/dotnet:2.1.0-aspnetcore-runtime  AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1.300-sdk AS build
COPY ./ /src

WORKDIR /src/iFramework.Plugins/IFramework.KafkaTools
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "IFramework.KafkaTools.dll"]
