FROM microsoft/dotnet:2.1-sdk AS build-env  
WORKDIR /app  
  
# Copy csproj and restore as distinct layers  
COPY IrcWidget.Web/*.csproj ./  
RUN dotnet restore  
  
# Copy everything else and build  
COPY IrcWidget.Web/ ./  
RUN dotnet publish -c Release -o out && \  
mkdir /logs  
  
# Build runtime image  
FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine  
LABEL maintainer=anthony@relle.co.uk  
  
WORKDIR /app  
COPY \--from=build-env /app/out .  
ENTRYPOINT ["dotnet", "IrcWidget.Web.dll"]  
  
ENV LogFile=/logs/logfile  

