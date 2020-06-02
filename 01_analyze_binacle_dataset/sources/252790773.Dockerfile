FROM ubuntu:14.04  
RUN \  
sudo apt-get install -y software-properties-common \  
&& sudo apt-add-repository -y ppa:yandex-qatools/allure-framework \  
&& apt-get update \  
&& sudo apt-get -y install allure-commandline \  
&& mkdir -p /allure  
  
VOLUME ["/allure"]  
  
WORKDIR /allure  
  
CMD allure generate /allure

