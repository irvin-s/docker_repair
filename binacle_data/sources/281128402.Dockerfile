# .NET Core SDK
FROM microsoft/dotnet:2.2-sdk-alpine AS dotnetcore-sdk

WORKDIR /source

# Copy Projects
COPY source/Application/DotNetCoreArchitecture.Application.csproj ./Application/
COPY source/CrossCutting/DotNetCoreArchitecture.CrossCutting.csproj ./CrossCutting/
COPY source/Database/DotNetCoreArchitecture.Database.csproj ./Database/
COPY source/Domain/DotNetCoreArchitecture.Domain.csproj ./Domain/
COPY source/Model/DotNetCoreArchitecture.Model.csproj ./Model/
COPY source/Web/DotNetCoreArchitecture.Web.csproj ./Web/

# .NET Core Restore
RUN dotnet restore ./Web/DotNetCoreArchitecture.Web.csproj

# Copy All Files
COPY source .

# .NET Core Build and Publish
FROM dotnetcore-sdk AS dotnetcore-build
RUN dotnet publish ./Web/DotNetCoreArchitecture.Web.csproj -c Release -o /publish

# Angular
FROM node:12.2.0-alpine AS angular-build
ARG ANGULAR_ENVIRONMENT
WORKDIR /frontend
ENV PATH /frontend/node_modules/.bin:$PATH
COPY source/Web/Frontend/package.json .
RUN npm run restore
COPY source/Web/Frontend .
RUN npm run $ANGULAR_ENVIRONMENT

# ASP.NET Core Runtime
FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine AS aspnetcore-runtime
ARG ASPNETCORE_ENVIRONMENT
ENV ASPNETCORE_ENVIRONMENT=$ASPNETCORE_ENVIRONMENT
WORKDIR /app
COPY --from=dotnetcore-build /publish .
COPY --from=angular-build /frontend/dist ./Frontend/dist
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "DotNetCoreArchitecture.Web.dll"]
