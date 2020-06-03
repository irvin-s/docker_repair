FROM microsoft/dotnet:2.1.402-sdk AS build-env
WORKDIR /app

# bootstrap as separate layer
COPY .paket/paket.bootstrapper.proj .paket/
COPY .paket/paket.bootstrapper.props .paket/
COPY .paket/paket.bootstrapper.exe.config .paket/
RUN dotnet restore .paket

# paket restore as separate layer
COPY paket.dependencies .
COPY paket.lock .

RUN .paket/paket restore

# now copy everything and build
COPY src src/
RUN dotnet publish src/c1 -c Release -o /app/out

# build runtime image
FROM microsoft/dotnet:2.1.4-runtime-alpine
WORKDIR /app
COPY --from=build-env /app/out ./
ENTRYPOINT ["dotnet", "c1.dll"]
