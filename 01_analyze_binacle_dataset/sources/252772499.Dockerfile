FROM microsoft/dotnet-preview  
RUN mkdir /src  
WORKDIR /src  
ADD . /src  
RUN dotnet restore  
RUN dotnet build  
CMD dotnet run

