FROM microsoft/aspnet:1.0.0-rc1-update1-coreclr  
  
ENV DNX_VERSION 1.0.0-rc1-update1  
ENV DNX_USER_HOME /opt/DNX_BRANCH  
ENV PATH $PATH:$DNX_USER_HOME/runtimes/default/bin  
ENV DNX_UNSTABLE_FEED https://www.myget.org/F/aspnetcidev/api/v2  
RUN /bin/bash -c "source ${DNX_USER_HOME}/dnvm/dnvm.sh \  
&& dnvm install -u -a x64 -r coreclr -f latest"

