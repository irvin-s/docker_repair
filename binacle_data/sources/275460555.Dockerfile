FROM microsoft/dotnet:2.0-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.0-sdk AS build
WORKDIR /src
COPY Nanny.Main/Nanny.Main.csproj Nanny.Main/
COPY Nanny.Queue/Nanny.Queue.csproj Nanny.Queue/
COPY Nanny.Common/Nanny.Common.csproj Nanny.Common/
COPY Nanny.Kubernetes/Nanny.Kubernetes.csproj Nanny.Kubernetes/
RUN dotnet restore Nanny.Main/Nanny.Main.csproj
COPY . .
WORKDIR /src/Nanny.Main
RUN dotnet build Nanny.Main.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish Nanny.Main.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Nanny.Main.dll"]