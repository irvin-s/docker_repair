# docker build -f Dockerfile-Client .
# docker run --net=host 013ebfd7071b

#===========================================================
# BUILD: Using Docker images containing .net core SDK
#===========================================================
FROM microsoft/dotnet:2.2-sdk AS core-build-step

# Copy the code to the image
COPY ./netfusion /build/netfusion
COPY ./tutorial/Service /build/tutorial/Service

# Build and Publish the WebApi service host
RUN dotnet --diagnostics publish \
    --configuration Debug \
    --framework netcoreapp2.2 \
    --source https://api.nuget.org/v3/index.json \
    /build/tutorial/Service/src/Service.Client/Service.Client.csproj \
    --output /out/ 


#===========================================================
# CREATE: Image using non-sdk verison of .net base image
#===========================================================
FROM microsoft/dotnet:2.2-aspnetcore-runtime
	
COPY --from=core-build-step /out/ /opt/netfusion/tutorial/Service.Client

WORKDIR /opt/netfusion/tutorial/Service.Client

ENTRYPOINT ["dotnet", "Service.Client.dll"]