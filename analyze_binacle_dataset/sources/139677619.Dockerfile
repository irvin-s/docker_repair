# Copyright 2018 Digimarc, Inc
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
#  SPDX-License-Identifier: Apache-2.0

FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY lib .
WORKDIR /src/Whalerator.WebAPI
RUN dotnet build -c Release -o /app

FROM build AS publish
RUN dotnet publish -c Release -o /app

FROM node:carbon as ngbuild
COPY web/src /web/src
COPY web/package.json /web/
COPY web/package-lock.json /web/
COPY web/angular.json /web/
COPY web/tsconfig.json /web/
WORKDIR /web
RUN npm install
RUN npm install @angular/cli
RUN /web/node_modules/@angular/cli/bin/ng build --prod --output-path /dist

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
COPY --from=ngbuild /dist ./wwwroot
COPY lib/Whalerator.WebAPI/config-docker.yaml config.yaml

ARG SRC_HASH="Unknown"
ARG RELEASE="0.0"
RUN echo "{ \""hash\"": \""$SRC_HASH\"", \""release\"": \""$RELEASE\"" }" > ./wwwroot/assets/v.json
COPY README.md /README.md
ENTRYPOINT ["dotnet", "Whalerator.WebAPI.dll"]
