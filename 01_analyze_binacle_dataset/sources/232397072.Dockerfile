FROM microsoft/dotnet

WORKDIR /dotnetapp

# copy project.json and restore as distinct layers
COPY project.json .
RUN dotnet restore

# copy and build everything else
COPY . .
RUN dotnet publish -c Release -o out

EXPOSE 8080
CMD [ "dotnet", "out/dotnetapp.dll" ]