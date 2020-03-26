FROM microsoft/dotnet:2.2-runtime
COPY /deploy .

# Install Python.
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

ADD https://yt-dl.org/downloads/latest/youtube-dl /usr/local/bin/youtube-dl
RUN  chmod a+rx /usr/local/bin/youtube-dl
WORKDIR .
EXPOSE 8085
ENTRYPOINT ["dotnet", "Server.dll"]
