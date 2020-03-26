FROM microsoft/dotnet:2.1-sdk as build-env
WORKDIR /app

# Setup node
ENV NODE_VERSION 8.11.1
ENV NODE_DOWNLOAD_SHA 0e20787e2eda4cc31336d8327556ebc7417e8ee0a6ba0de96a09b0ec2b841f60

RUN curl -SL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" --output nodejs.tar.gz \
    && echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - \
    && tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
    && rm nodejs.tar.gz \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs\
    && npm i -g @angular/cli

# Copy csproj and restore as distinct layers
COPY src/AspNetCore2AngMvcTemplate/ ./AspNetCore2AngMvcTemplate/
RUN cd AspNetCore2AngMvcTemplate \
    && dotnet restore \
    && npm install

RUN cd AspNetCore2AngMvcTemplate \
    && dotnet publish -c Release -o out

# build runtime image
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /app

# Setup node
ENV NODE_VERSION 8.11.1
ENV NODE_DOWNLOAD_SHA 0e20787e2eda4cc31336d8327556ebc7417e8ee0a6ba0de96a09b0ec2b841f60

RUN curl -SL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" --output nodejs.tar.gz \
    && echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - \
    && tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
    && rm nodejs.tar.gz \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs\
    && npm i -g @angular/cli

COPY --from=build-env /app/AspNetCore2AngMvcTemplate/out .
ENTRYPOINT ["dotnet", "AspNetCore2AngMvcTemplate.dll"]
