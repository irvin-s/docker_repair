# from https://docs.microsoft.com/en-us/dotnet/core/docker/building-net-docker-images
FROM microsoft/aspnetcore-build:latest AS build-env
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# build runtime image
FROM microsoft/aspnetcore:latest
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 8080/tcp
ENV ASPNETCORE_URLS http://*:8080
ENTRYPOINT [ "dotnet", "GradeService.dll" ]