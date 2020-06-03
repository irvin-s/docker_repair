FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out -r linux-x64

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
# Enviroment variable
ENV COMPlus_PerfMapEnabled 1
ENV COMPlus_EnableEventLog 1
ENTRYPOINT ["./Blueyonder.Service"]
