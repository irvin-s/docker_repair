FROM always3133/dotnetcorebenchmarkbase  
  
RUN cd /data && git clone https://github.com/always3133/dotnetbenchmark.git .  
#RUN cd /data && dotnet restore  
WORKDIR /data  
#CMD ["sh", "benchmark.sh"]  
CMD git pull origin master && dotnet restore && sh benchmark.sh  

