FROM centos  
RUN yum install -y ruby ruby-devel rubygems gcc-c++ make git  
RUN git clone https://github.com/bdavid/premailer-api.git /opt/premailer-api  
RUN gem install bundler  
WORKDIR /opt/premailer-api  
RUN bundle install  
EXPOSE 4567  
CMD ["ruby", "premailer-api.rb", "-o", "0.0.0.0"]  

