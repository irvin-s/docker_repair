# Build image

FROM microsoft/dotnet:2.1-sdk as publish

WORKDIR /publish

COPY src/SampleApi/*.csproj ./src/SampleApi/

RUN dotnet restore src/SampleApi/SampleApi.csproj --verbosity quiet 

COPY ./src ./src

RUN dotnet publish src/SampleApi/SampleApi.csproj --output ../../out -c Release --no-restore --verbosity quiet /clp:ErrorsOnly

# Optimised final image

FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine

ENTRYPOINT ["dotnet", "SampleApi.dll"]

WORKDIR /app

EXPOSE 80

COPY --from=publish /publish/out .