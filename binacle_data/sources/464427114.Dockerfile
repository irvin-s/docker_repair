FROM microsoft/dotnet:2.1-sdk AS restore
WORKDIR /app
COPY *.sln ./
COPY .editorconfig ./
COPY Directory.Build.props ./
COPY Directory.Build.targets ./
COPY build/. ./build/
COPY src/Microsoft.Atlas.CommandLine/*.csproj ./src/Microsoft.Atlas.CommandLine/
COPY test/Microsoft.Atlas.CommandLine.Tests/*.csproj ./test/Microsoft.Atlas.CommandLine.Tests/
RUN dotnet restore
COPY src/. ./src/
COPY test/. ./test/
COPY docs/. ./docs/
COPY LICENSE ./
COPY ThirdPartyNotice.txt ./

FROM restore AS test
WORKDIR /app/test/Microsoft.Atlas.CommandLine.Tests
ENTRYPOINT ["dotnet", "test", "--logger:trx", "-c", "Release"]

FROM restore as publish
WORKDIR /app
ARG BUILD_BUILDID
ARG BUILD_REPOSITORY_URI
ARG BUILD_SOURCEBRANCHNAME
ARG BUILD_SOURCEVERSION
RUN \
    BUILD_BUILDID=${BUILD_BUILDID} \
    BUILD_REPOSITORY_URI=${BUILD_REPOSITORY_URI} \
    BUILD_SOURCEBRANCHNAME=${BUILD_SOURCEBRANCHNAME} \
    BUILD_SOURCEVERSION=${BUILD_SOURCEVERSION} \
    dotnet publish src/Microsoft.Atlas.CommandLine/Microsoft.Atlas.CommandLine.csproj \
        -c Release -o /out/atlas && \
    dotnet pack    src/Microsoft.Atlas.CommandLine/Microsoft.Atlas.CommandLine.csproj \
        -c Release -o /out/tools && \
    dotnet msbuild src/Microsoft.Atlas.CommandLine/Microsoft.Atlas.CommandLine.csproj \
        /t:Restore,CreateTarball /p:RuntimeIdentifier=linux-x64 /p:TargetFramework=netcoreapp2.1 /p:Configuration=Release /p:ArchiveDir=/out/downloads && \
    dotnet msbuild src/Microsoft.Atlas.CommandLine/Microsoft.Atlas.CommandLine.csproj \
        /t:Restore,CreateZip /p:RuntimeIdentifier=win10-x64 /p:TargetFramework=netcoreapp2.1 /p:Configuration=Release /p:ArchiveDir=/out/downloads

FROM microsoft/dotnet:2.1-runtime AS runtime
WORKDIR /app
COPY --from=publish /out/atlas ./
ENTRYPOINT ["dotnet", "atlas.dll"]
