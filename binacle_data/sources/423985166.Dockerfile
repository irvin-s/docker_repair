FROM microsoft/dotnet:2.1-sdk as builder
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1

WORKDIR /home/app/src/

COPY . .

RUN dotnet restore ./root.csproj; \
    dotnet publish -c release -o published


FROM microsoft/dotnet:2.1-runtime
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1

WORKDIR /home/app/

COPY --from=builder /home/app/src/published .
RUN chown 1000:1000 -R /home/app

USER 1000:1000

