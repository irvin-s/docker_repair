FROM microsoft/aspnetcore-build:latest  
WORKDIR /App  
COPY ./Test_1_Service .  
EXPOSE 80  
RUN dotnet restore  
RUN dotnet publish -c Release -o out  
ENTRYPOINT ["dotnet", "out/RCSendEmail.dll"]"]

