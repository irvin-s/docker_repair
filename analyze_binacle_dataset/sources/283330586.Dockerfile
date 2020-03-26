FROM microsoft/aspnetcore-build:2.0-jessie AS build

WORKDIR /build

COPY DaaS.Demo.sln nuget.config /build/
COPY src/Common.props /build/src/
COPY src/DaaSDemo.Api/*.csproj /build/src/DaaSDemo.Api/
COPY src/DaaSDemo.Common/*.csproj /build/src/DaaSDemo.Common/
COPY src/DaaSDemo.Crypto/*.csproj /build/src/DaaSDemo.Crypto/
COPY src/DaaSDemo.Data/*.csproj /build/src/DaaSDemo.Data/
COPY src/DaaSDemo.DatabaseProxy/*.csproj /build/src/DaaSDemo.DatabaseProxy/
COPY src/DaaSDemo.DatabaseProxy.Client/*.csproj /build/src/DaaSDemo.DatabaseProxy.Client/
COPY src/DaaSDemo.KubeClient/*.csproj /build/src/DaaSDemo.KubeClient/
COPY src/DaaSDemo.Logging/*.csproj /build/src/DaaSDemo.Logging/
COPY src/DaaSDemo.Models/*.csproj /build/src/DaaSDemo.Models/
COPY src/DaaSDemo.Provisioning/*.csproj /build/src/DaaSDemo.Provisioning/
COPY src/DaaSDemo.Provisioning.Host/*.csproj /build/src/DaaSDemo.Provisioning.Host/
COPY src/DaaSDemo.UI/*.csproj /build/src/DaaSDemo.UI/
COPY src/DaaSDemo.UI/package.json src/DaaSDemo.UI/npm-shrinkwrap.json /build/src/DaaSDemo.UI/

COPY test/DaaSDemo.TestHarness/*.csproj /build/test/DaaSDemo.TestHarness/

ARG VERSION_PREFIX=1.0.0
ARG VERSION_SUFFIX=dev

RUN dotnet restore /p:VersionPrefix=${VERSION_PREFIX} /p:VersionSuffix=${VERSION_Suffix}

COPY . /build
RUN dotnet publish src/DaaSDemo.DatabaseProxy/DaaSDemo.DatabaseProxy.csproj /p:VersionPrefix=${VERSION_PREFIX} /p:VersionSuffix=${VERSION_SUFFIX} -o /out

FROM microsoft/aspnetcore:2.0-jessie

WORKDIR /app

COPY --from=build /out /app

EXPOSE 5000
ENV IN_KUBERNETES=0 PORT=5000 ASPNETCORE_URLS=http://localhost:5000

ENTRYPOINT [ "dotnet", "DaaSDemo.DatabaseProxy.dll" ]
