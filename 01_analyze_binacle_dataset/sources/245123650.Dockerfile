FROM microsoft/aspnetcore-build:2.0.0-preview2 as publish
#FROM microsoft/aspnetcore-build:2.0.0-preview2
# set up package cache
# RUN curl -o /tmp/packagescache.tar.gz https://dist.asp.net/packagecache/aspnetcore.packagecache-1.0.1-debian.8-x64.tar.gz && \
#     mkdir /packagescache && cd /packagescache && \
#     tar xvf /tmp/packagescache.tar.gz && \
#     rm /tmp/packagescache.tar.gz && \
#     cd /

# set env var for packages cache
# ENV DOTNET_HOSTING_OPTIMIZATION_CACHE /packagescache

COPY . /publish/
WORKDIR /publish

RUN ["dotnet", "restore"]
RUN ["dotnet", "build"]
RUN dotnet publish --output ./out
#RUN dotnet vstest out/API.dll 

#######################################################
# For running the app 
FROM microsoft/aspnetcore:2.0.0-preview2
WORKDIR /published
COPY --from=publish /publish/out .

EXPOSE 5000/tcp
ENV ASPNETCORE_URLS http://*:5000

ENTRYPOINT ["dotnet", "API.dll"]

