FROM microsoft/dotnet:2.0-sdk AS build-env  
WORKDIR /app  
  
# copy csproj and restore as distinct layers  
COPY ./*.csproj ./  
RUN dotnet restore  
RUN ls -lha  
  
# copy everything else and build  
COPY ./. ./  
RUN ls -lha  
RUN dotnet publish -c Release -o out  
  
# build runtime image  
FROM microsoft/dotnet:2.0-runtime  
WORKDIR /app  
COPY \--from=build-env /app/out ./  
ENTRYPOINT ["dotnet", "FilterModule.dll"]  

