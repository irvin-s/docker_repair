FROM infragravity/sonar:master  
LABEL Name=sample/sonar Version=0.0.1
LABEL Maintainer=sample@infragravity.com
WORKDIR /out
# copy bits
COPY ./bin/Release/netcoreapp2.0 .
ADD ./out/MySql.Data.dll .
ADD ./out/Samples.Sonar.Adapters.MySql.dll .
ADD ./out/Google.Protobuf.dll .
ADD ./out/Newtonsoft.Json.dll .
# copy config
ADD ./Sonart.config .
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV SONAR_CONFIG_PATH /out/Sonart.config
ENV SONAR_RUNTIME_TYPE Docker
ENV SONAR_LOG_LEVEL Information
ENTRYPOINT ["dotnet", "Sonarc.dll"]