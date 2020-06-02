# 基于microsoft/dotnet:latest构建Docker Image
FROM microsoft/dotnet:latest

#拷贝项目publish文件夹中的所有文件到 docker容器中的publish文件夹中 
COPY . /publish

#设置工作目录为 `/publish` 文件夹，即容器启动默认的文件夹
WORKDIR /publish

#设置Docker容器对外暴露6000端口
EXPOSE 5000

#使用`dotnet HelloWebApp.dll`来运行应用程序
CMD ["dotnet", "Vino.Core.CMS.Web.Backend.dll"]