FROM library/ubuntu  
RUN apt-get update && \  
apt-get -y install software-properties-common && \  
add-apt-repository "deb http://toolbelt.herokuapp.com/ubuntu ./" && \  
apt-get -y install curl && \  
curl -L https://toolbelt.heroku.com/apt/release.key | apt-key add \- && \  
apt-get update && \  
apt-get -y install heroku-toolbelt && \  
heroku plugins:install salesforce-lightning-cli  

