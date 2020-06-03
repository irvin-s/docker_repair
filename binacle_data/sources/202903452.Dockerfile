FROM microsoft/dotnet:sdk AS core-build-step

ARG nuget_feed=https://api.nuget.org/v3/index.json

COPY ./build/ /build/build/
COPY ./src/Common /build/src/Common
COPY ./src/Core /build/src/Core
COPY ./test/CommonTests /build/test/CommonTests
COPY ./test/CoreTests /build/test/CoreTests

WORKDIR /build/src/Common   

RUN dotnet restore NetFusion.Common/NetFusion.Common.csproj -s $nuget_feed 
RUN dotnet restore NetFusion.Base/NetFusion.Base.csproj -s $nuget_feed 
RUN dotnet restore NetFusion.Mapping/NetFusion.Mapping.csproj -s $nuget_feed
RUN dotnet restore NetFusion.Roslyn/NetFusion.Roslyn.csproj -s $nuget_feed

RUN dotnet build --no-restore NetFusion.Common/NetFusion.Common.csproj -f netstandard2.0
RUN dotnet build --no-restore NetFusion.Base/NetFusion.Base.csproj -f netstandard2.0
RUN dotnet build --no-restore NetFusion.Mapping/NetFusion.Mapping.csproj -f netstandard2.0

WORKDIR /build/src/Core

RUN dotnet restore NetFusion.Bootstrap/NetFusion.Bootstrap.csproj -s $nuget_feed
RUN dotnet restore NetFusion.Settings/NetFusion.Settings.csproj -s $nuget_feed
RUN dotnet restore NetFusion.Test/NetFusion.Test.csproj -s $nuget_feed
RUN dotnet restore NetFusion.Messaging.Types/NetFusion.Messaging.Types.csproj -s $nuget_feed
RUN dotnet restore NetFusion.Messaging/NetFusion.Messaging.csproj -s $nuget_feed

RUN dotnet build --no-restore NetFusion.Bootstrap/NetFusion.Bootstrap.csproj -f netstandard2.0
RUN dotnet build --no-restore NetFusion.Settings/NetFusion.Settings.csproj -f netstandard2.0
RUN dotnet build --no-restore NetFusion.Test/NetFusion.Test.csproj -f netstandard2.0
RUN dotnet build --no-restore NetFusion.Messaging.Types/NetFusion.Messaging.Types.csproj -f netstandard2.0
RUN dotnet build --no-restore NetFusion.Messaging/NetFusion.Messaging.csproj -f netstandard2.0

WORKDIR /build/test
RUN dotnet restore CommonTests/CommonTests.csproj -s $nuget_feed
RUN dotnet restore CoreTests/CoreTests.csproj -s $nuget_feed

RUN dotnet build --no-restore CommonTests/CommonTests.csproj -f netcoreapp2.0
RUN dotnet build --no-restore CoreTests/CoreTests.csproj -f netcoreapp2.0

RUN dotnet test --no-build CoreTests/CoreTests.csproj -f netcoreapp2.0
RUN dotnet test --no-build CoreTests/CoreTests.csproj -f netcoreapp2.0
