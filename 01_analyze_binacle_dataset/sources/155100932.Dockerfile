#用编译环境编译项目
FROM microsoft/dotnet:2.2-sdk AS build-env
COPY . /app
WORKDIR /app/net-core
#dotnet 2.x不再需要手动restore，但是也可以手动restore来自定义源
RUN dotnet restore
RUN dotnet test Hiwjcn.Test/Hiwjcn.Test.csproj
RUN dotnet publish Hiwjcn.Api/Hiwjcn.Api.csproj -c Release -o out

#编译结果copy到runtime容器运行
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/net-core/Hiwjcn.Api/out .
ENTRYPOINT ["dotnet","Hiwjcn.Api.dll"]
#dotnet publish Hiwjcn.Api/Hiwjcn.Api.csproj -c Release
#hiwjcn/net-core/Hiwjcn.Api/bin/Release/netcoreapp2.1/publish/

#https://docs.microsoft.com/zh-cn/dotnet/core/tools/dotnet-publish?tabs=netcore21