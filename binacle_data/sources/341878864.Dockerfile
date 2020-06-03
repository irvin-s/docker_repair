FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.sln ./

RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
##Add ENV variables
#ENV vault "niksac-kv"
#ENV clientId "4dee3790-5990-454d-b875-6d82456cba84"
#ENV clientSecret "fYn4vc836sNayvr8fQn4vYzS6qwmXmnFF/ovDvIyfHc="
#ENV kvuri "https://{vault-name}.vault.azure.net/"

WORKDIR /app
# NOTE: Need to find a way to automate the below copy, currently if you create a sln file build
# it creates a per project folders so there is a need to have a way to aggregate all files before the copy happens
# the below presents a challenge of scale where the ops engineer will have add projects every time a dev add one
# not be used in production
COPY --from=build-env /app/samples.microservice.core/out ./
COPY --from=build-env /app/samples.microservice.entities/out ./
COPY --from=build-env /app/samples.microservice.repository/out ./
COPY --from=build-env /app/samples.microservice.api/out ./

ENTRYPOINT ["dotnet", "samples.microservice.api.dll"]