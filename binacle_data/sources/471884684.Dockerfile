FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /source

COPY . .
RUN dotnet restore dotnetKonf.Web/dotnetKonf.Web.csproj
RUN dotnet publish dotnetKonf.Web/dotnetKonf.Web.csproj --output /dotnetkonf/ --configuration release

FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /dotnetkonf
COPY --from=builder /dotnetkonf .

ENTRYPOINT ["dotnet", "dotnetKonf.Web.dll"]