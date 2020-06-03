# --------
#  STEP 1
# --------

# Install .NET Core SDK docker container
FROM microsoft/dotnet:2.1-sdk-alpine AS build-env

# Create app directory
WORKDIR /app

# Install app dependencies
COPY . .

# Switch to service directory
WORKDIR /app/TestWebApi

# Copy build output
RUN dotnet publish -c Debug -r alpine-x64 --self-contained -o out

# --------
#  STEP 2
# --------

# Install .NET Core Runtime docker container
FROM microsoft/dotnet:2.1-runtime-alpine

# Environment variables
ENV ASPNETCORE_ENVIRONMENT development

# # Install debugger
# WORKDIR /vsdbg

# # Installing vsdbg debbuger into our container
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#        unzip \
#     && rm -rf /var/lib/apt/lists/* \
#     && curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg

# Create app directory
WORKDIR /app

# Copy build output
COPY --from=build-env /app/TestWebApi/out /app

# Export the port 80
EXPOSE 80

ENTRYPOINT ["dotnet", "Tassle.TestWebApi.dll"]
