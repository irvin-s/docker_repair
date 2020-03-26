FROM node AS frontend-stage
RUN mkdir /app
WORKDIR /app
COPY ./client ./
ENV PATH /node_modules/.bin:$PATH
RUN npm install
RUN npm run build

FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app
COPY ./server/*.csproj ./
RUN dotnet restore
COPY ./server ./
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
COPY --from=frontend-stage /app/build wwwroot
ENTRYPOINT ["dotnet", "FitnessTracker.dll"]
