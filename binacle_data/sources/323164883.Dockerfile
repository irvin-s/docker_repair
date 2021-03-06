#altinn-runtime with sdk
FROM altinntjenestercontainerregistry.azurecr.io/altinn-runtime:latest AS build
WORKDIR /AltinnService/
COPY AltinnService.csproj ./
COPY Implementation/* ./
COPY Model/*.cs ./
RUN dotnet publish -o publish/

FROM microsoft/dotnet:2.2-aspnetcore-runtime AS final
WORKDIR /app

#copy altinn-runtime app
COPY --from=build /app .

#copy service
WORKDIR /AltinnService/bin/
COPY --from=build /AltinnService/publish/AltinnService* ./
WORKDIR /AltinnService/
COPY . .
WORKDIR /app

#entrypoint
ENTRYPOINT ["dotnet", "AltinnCore.Runtime.dll"]
