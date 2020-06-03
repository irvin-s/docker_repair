FROM microsoft/dotnet:1.1.0-sdk-projectjson
COPY . .
WORKDIR /BudgetBackend
RUN ["dotnet", "restore"]
RUN ["dotnet", "publish"]
EXPOSE 5000
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT dotnet /BudgetBackend/bin/Debug/netcoreapp1.0/publish/BudgetBackend.dll
