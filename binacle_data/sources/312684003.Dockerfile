FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app

EXPOSE 55419
EXPOSE 44398

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ./BlueYonder.Hotels.Service.csproj ./
RUN dotnet restore ./BlueYonder.Hotels.Service.csproj
COPY . .
WORKDIR /src/.
RUN dotnet build BlueYonder.Hotels.Service.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish BlueYonder.Hotels.Service.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "BlueYonder.Hotels.Service.dll"]