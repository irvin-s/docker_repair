FROM microsoft/dotnet:2.1-sdk-alpine AS build
WORKDIR /Sln
RUN apk add --update --no-cache bash

#######################################################
# WARINING!
# Remeber to set PROJECT in runtime image section, too.
ARG PROJECT=Decoder
#######################################################

COPY . .
RUN dotnet restore

WORKDIR /Sln/${PROJECT}

RUN dotnet add package ILLink.Tasks -v 0.1.5-preview-1461378 -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json
RUN dotnet publish -c Release -r linux-musl-x64 -o out /p:LinkDuringPublish=true /p:ShowLinkerSizeComparison=true

# build runtime image
FROM microsoft/dotnet:2.1-runtime-deps-alpine AS runtime

#######################################################
# WARINING!
# Set PROJECT here, too.
ARG PROJECT=Decoder
#######################################################

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false
RUN apk add --update --no-cache icu-libs

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

WORKDIR /App
COPY --from=build /Sln/${PROJECT}/out ./
ENTRYPOINT ["./Decoder"]
# CMD ["dotnet", "/App/Decoder.dll"]
