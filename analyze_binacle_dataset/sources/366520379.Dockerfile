FROM microsoft/dotnet:2.0-sdk

MAINTAINER "Seth Rosetter" <seth.rosetter@gmail.com>

# Install LiteCore deps (Remove eventually)
RUN apt-get update && \
    apt-get -y install libc++-dev libsqlite3-dev libatomic1

WORKDIR /opt

# Git clone mobile-testkit
RUN git clone https://github.com/couchbaselabs/mobile-testkit.git
WORKDIR /opt/mobile-testkit/apps/testkit.net/
RUN git pull

# Build the test app
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
RUN dotnet restore -s http://mobile.nuget.couchbase.com/nuget/Internal/ -s https://api.nuget.org/v3/index.json
RUN dotnet build

# Start the longevity test
WORKDIR /opt/mobile-testkit/apps/testkit.net/Testkit.Net.Desktop
CMD ["dotnet", "run"]