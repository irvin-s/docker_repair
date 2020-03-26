FROM avarade/aper:v2  
  
RUN mkdir /opt/aper-app  
WORKDIR /opt/aper-app  
ADD . /opt/aper-app  
  
ENV EMAIL_HOST=localhost:5000  
ENV EMAIL_PASSWORD=n0reply@per  
ENV EMAIL_USERNAME=noreply.aper@gmail.com  
ENV RACK_ENV=development  
ENV RAILS_ENV=development  
  
RUN gem update --system  
RUN gem --version  
RUN gem install rails -v 4.2.5 --no-ri  
  
RUN mysql -u root -proot -e "CREATE DATABASE dev_aper"  
  
RUN bundle install  
  
RUN bundle exec rake db:create  
RUN bundle exec rake db:migrate  
RUN bundle exec rake db:seed  

