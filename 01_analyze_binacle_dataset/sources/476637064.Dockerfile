FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

# copy only files required for dotnet restore in order to create a distinct layers
# if is supposed to take advantage of Docker cache per layer
COPY *.sln .
COPY nuget.config ./nuget.config
COPY ./Directory.Build.props ./Directory.Build.props
COPY ./Common/Dependencies.props ./Common/Dependencies.props
COPY MarbleTest.Net/MarbleTest.Net.csproj ./MarbleTest.Net/MarbleTest.Net.csproj
COPY MarbleTest.Net.Test/MarbleTest.Net.Test.csproj ./MarbleTest.Net.Test/MarbleTest.Net.Test.csproj
RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /app
RUN dotnet build


FROM build AS testrunner
WORKDIR /app/MarbleTest.Net.Test
ENTRYPOINT ["dotnet", "test", "--logger:trx"]


FROM build AS test
WORKDIR /app/MarbleTest.Net.Test
RUN dotnet test


# FROM build AS publish
# WORKDIR /app/dotnetapp
# # add IL Linker package
# RUN dotnet add package ILLink.Tasks -v 0.1.4-preview-981901 -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json
# RUN dotnet publish -c Release -r linux-musl-x64 -o out /p:ShowLinkerSizeComparison=true


# FROM microsoft/dotnet:2.1-runtime-deps-alpine AS runtime
# WORKDIR /app
# COPY --from=publish /app/dotnetapp/out ./
# ENTRYPOINT ["./dotnetapp"]
