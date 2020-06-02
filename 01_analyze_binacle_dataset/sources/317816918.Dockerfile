FROM microsoft/dotnet:2.1.300-sdk-bionic
ADD gitlab-pages/linux-x64 /gitlab-pages
ENV ASPNETCORE_URLS "http://*:5000"
RUN mkdir /work
EXPOSE 5000
ENTRYPOINT ["/gitlab-pages/GitLabPages.Web"]
WORKDIR /work
