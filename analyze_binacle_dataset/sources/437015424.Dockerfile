FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
ADD *.csproj /app/
WORKDIR /app
RUN dotnet restore

ADD ./ .
RUN dotnet publish -o out /p:PublishWithAspNetCoreTargetManifest="false"

#---

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
LABEL maintainer="william.pjyeh@gmail.com"

ENV ASPNETCORE_URLS http://+:80
EXPOSE 80
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "TodoApi.dll"]