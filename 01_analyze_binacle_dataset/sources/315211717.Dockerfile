ARG base_tag=2.1-runtime-stretch-slim
FROM microsoft/dotnet:${base_tag} AS base

RUN apt-get update -y && apt-get install python3 -y && apt-get install python3-pip -y
RUN ldconfig
WORKDIR /app

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY Modules/TypeEdgeModule3/TypeEdgeModule3.csproj Modules/TypeEdgeModule3/
COPY TypeEdgeML.Shared/TypeEdgeML.Shared.csproj TypeEdgeML.Shared/
RUN dotnet restore Modules/TypeEdgeModule3/TypeEdgeModule3.csproj 
COPY . .
WORKDIR /src/Modules/TypeEdgeModule3
RUN dotnet build TypeEdgeModule3.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish TypeEdgeModule3.csproj -c Release -o /app

FROM base AS final


WORKDIR /app
COPY --from=publish /app .

RUN pip3 install --no-cache-dir -r requirements.txt

ENV LD_LIBRARY_PATH /usr/lib/python3.5/config-3.5m-x86_64-linux-gnu

ENTRYPOINT ["dotnet", "TypeEdgeModule3.dll"]