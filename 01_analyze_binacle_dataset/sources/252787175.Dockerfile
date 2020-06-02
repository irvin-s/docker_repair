FROM ruby:2.4.2  
ENV git_url=https://github.com/breenatheseira/docker-tutorial-with-rails.git  
ENV git_branch=master  
  
# Install apt based dependencies required to run Rails as  
# well as RubyGems. As the Ruby image itself is based on a  
# Debian image, we use apt-get to install those.  
RUN apt-get update && apt-get install -y \  
build-essential \  
nodejs  
  
# Configure the main working directory. This is the base  
# directory used in any further RUN, COPY, and ENTRYPOINT  
# commands.  
RUN mkdir -p /app  
WORKDIR /app  
  
# Copy the main application.  
RUN git clone $git_url . && git checkout $git_branch  
  
# Install the RubyGems.  
RUN gem install bundler && bundle install  
  
# Expose port 3000 to the Docker host, so we can access it  
# from the outside.  
EXPOSE 3000  
#ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]  
VOLUME /app  
  
# Run with: docker run -p 3000:3000 projects  

