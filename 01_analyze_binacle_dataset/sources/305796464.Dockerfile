FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY . .
EXPOSE 80
ENTRYPOINT ["dotnet", "Spark.Config.Api.dll"]
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone