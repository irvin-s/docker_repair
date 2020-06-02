#VERSION=1.2  
FROM seldonio/seldon-control:1.3_v5  
  
RUN \  
apt-get update && \  
apt-get -y -q install unzip  
  
ADD attr.json /attr.json  
  
ADD create_ml10m_recommender.sh /create_ml10m_recommender.sh  
  
RUN chmod +x /create_ml10m_recommender.sh  

