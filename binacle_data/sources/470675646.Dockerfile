####################################################
# To build your own image: 
#    > docker build -t honosoft/vuejs-picnictable:latest -t honosoft/vuejs-picnictable:1.5.0 .
# To run your image once it's ready:
#    > docker run -d -p 8080:80 --name vuejs-picnictable honosoft/vuejs-picnictable
# To push the image into your docker repository:
#    > docker push honosoft/vuejs-picnictable:latest
# If you wish to remove your dangling images, please do the following (not mandatory)
#    > docker rmi $(docker images -f “dangling=true” -q)
####################################################

# Build the container with Source code compiled
FROM mcr.microsoft.com/dotnet/core/sdk:2.2-alpine3.8 as buildenv
WORKDIR /source
RUN apk add --update nodejs nodejs-npm
COPY *.csproj .
RUN dotnet restore
COPY . .
# Publishing will also restore (install) the npm packages.
RUN dotnet publish -c Release -o /app/ -r linux-musl-x64

# Stage 2 - Creating Image for compiled app
FROM mcr.microsoft.com/dotnet/core/runtime:2.2-alpine3.8 as baseimage
RUN addgroup -S coreApp && adduser -S -G coreApp coreApp

# Define other environment variable if needed.
ENV ASPNETCORE_URLS=http://+:$port

WORKDIR /app
COPY --from=buildenv /app .
RUN chown -R coreApp:coreApp /app

# Replace the application name if required.
ENTRYPOINT ["dotnet", "VueJs.PicnicTable.CSharp.dll"]
EXPOSE $port
