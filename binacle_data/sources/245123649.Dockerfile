FROM microsoft/aspnetcore-build:2.0.0-preview2

EXPOSE 5000/tcp
ENV ASPNETCORE_URLS http://*:5000
ENV DOTNET_USE_POLLING_FILE_WATCHER=true

# copy files for building from current directory to target on image 
COPY . /app/
WORKDIR /app



#------------------------
# USAGE - build image, and expose ports, the current app folder: 
# 		docker build -t mydemos:aspnetcorehelloworld .
#		docker run -d -p 8080:5000 -v $(pwd):/app -t mydemos:aspnetcorehelloworld 

# FOR MULTIPLE CONTAINERS
# docker build -f aspnetcore.development.dockerfile -t [yourDockerHubID]/dotnet:1.0.0 

# Option 1
# Start PostgreSQL and ASP.NET Core (link ASP.NET core to ProgreSQL container with legacy linking)
 
# docker run -d --name my-postgres -e POSTGRES_PASSWORD=password postgres
# docker run -d -p 5000:5000 --link my-postgres:postgres [yourDockerHubID]/dotnet:1.0.0

# Option 2: Create a custom bridge network and add containers into it

# docker network create --driver bridge isolated_network
# docker run -d --net=isolated_network --name postgres -e POSTGRES_PASSWORD=password postgres
# docker run -d --net=isolated_network --name aspnetcoreapp -p 5000:5000 [yourDockerHubID]/dotnet:1.0.0