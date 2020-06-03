FROM microsoft/aspnetcore:2.0.4-stretch

# add docker user, group, and setup directories
RUN addgroup --gid 1000 docker && \
    adduser --uid 1000 --ingroup docker --home /home/docker --shell /bin/sh --disabled-password --gecos "" docker && \
    mkdir -p /dotnet/App

# set pwd, ports, command
WORKDIR /dotnet/App
EXPOSE 5000
CMD ["dotnet", "App.dll"]

# copy application files
COPY stage/ /

# change ownership application files
RUN chown -R docker:docker /dotnet

# set user
USER docker:docker
