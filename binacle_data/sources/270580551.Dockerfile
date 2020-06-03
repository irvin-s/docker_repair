FROM microsoft/dotnet:2.0-sdk-jessie AS build-env
WORKDIR /app

COPY . ./
RUN dotnet publish -c Release -o ../../bin/ ./src/Launchpad/Launchpad.csproj

FROM microsoft/dotnet:2-runtime-jessie

WORKDIR /app

WORKDIR /app
COPY --from=build-env /app/bin ./bin

ENTRYPOINT ["dotnet", "bin/Launchpad.dll"]

CMD ["-n"]
