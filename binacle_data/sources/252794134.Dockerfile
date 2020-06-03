FROM microsoft/dotnet:latest  
  
ENV NUGET_XMLDOC_MODE skip  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys \  
3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \  
echo "deb http://download.mono-project.com/repo/debian jessie main" | \  
tee /etc/apt/sources.list.d/mono-official.list && \  
apt-get update && \  
apt-get install -y --no-install-recommends \  
apt-transport-https \  
mono-complete \  
ca-certificates-mono \  
nuget \  
curl && \  
nuget update -self && \  
mozroots --import --sync && \  
mkdir warmup && \  
cd warmup && \  
dotnet new console && \  
dotnet restore && \  
cd .. && \  
rm -rf warmup && \  
rm -rf /tmp/NuGetScratch && \  
rm -rf /var/lib/apt/lists/*  

