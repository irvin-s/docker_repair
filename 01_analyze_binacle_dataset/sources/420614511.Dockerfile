FROM mcr.microsoft.com/dotnet/core/sdk:2.2-alpine AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY XamarinSecurityScanner.App/*.csproj ./XamarinSecurityScanner.App/
COPY XamarinSecurityScanner.App.Tests/*.csproj ./XamarinSecurityScanner.App.Tests/
COPY XamarinSecurityScanner.Core/*.csproj ./XamarinSecurityScanner.Core/
COPY XamarinSecurityScanner.Core.Tests/*.csproj ./XamarinSecurityScanner.Core.Tests/
COPY XamarinSecurityScanner.Analyzers/*.csproj ./XamarinSecurityScanner.Analyzers/
COPY XamarinSecurityScanner.Analyzers.Tests/*.csproj ./XamarinSecurityScanner.Analyzers.Tests/
RUN dotnet restore

# copy everything else and build app
COPY . .
RUN dotnet test
WORKDIR /app/XamarinSecurityScanner.App
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-alpine AS runtime
WORKDIR /app
COPY --from=build /app/XamarinSecurityScanner.App/out ./
ENTRYPOINT ["dotnet", "XamarinSecurityScanner.App.dll", "--path", "/project"]
