FROM microsoft/dotnet:1.0.0-rc2-core

# Copy the app
COPY /app /app
WORKDIR /app

# Configure the listening port to 80
ENV ASPNETCORE_SERVER.URLS http://*:80
EXPOSE 80

# Start the app
ENTRYPOINT dotnet MaterialDesignLite.WebSample.dll
