# Build image

FROM microsoft/dotnet:2.1-sdk as publish

WORKDIR /publish

COPY SampleApi.sln .
COPY src/SampleApi/*.csproj ./src/SampleApi/
COPY test/SampleApi.Test/*.csproj ./test/SampleApi.Test/
COPY test/SampleApi.IntegrationTest/*.csproj ./test/SampleApi.IntegrationTest/

RUN dotnet restore --verbosity quiet

COPY ./src ./src
COPY ./test ./test

RUN dotnet build -c Release --no-restore /clp:ErrorsOnly
RUN dotnet test test/SampleApi.Test/SampleApi.Test.csproj -c Release --no-build --no-restore --verbosity minimal 
RUN dotnet test test/SampleApi.IntegrationTest/SampleApi.IntegrationTest.csproj -c Release --no-build --no-restore --verbosity minimal 
RUN dotnet publish src/SampleApi/SampleApi.csproj --output ../../out -c Release --no-restore --verbosity quiet /clp:ErrorsOnly

# Optimised final image

FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine

ENTRYPOINT ["dotnet", "SampleApi.dll"]

WORKDIR /app

EXPOSE 80

COPY --from=publish /publish/out .