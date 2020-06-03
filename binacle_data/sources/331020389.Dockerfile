FROM microsoft/dotnet:2.0.5-sdk-2.1.4 as publish
WORKDIR /publish
COPY PartialFoods.Services.InventoryServer.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish --output ./out

FROM microsoft/dotnet:2.0.5-runtime
WORKDIR /app
COPY --from=publish /publish/out .
ADD appsettings.json /app 
ENTRYPOINT ["dotnet", "PartialFoods.Services.InventoryServer.dll"]