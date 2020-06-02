# After pushing code changes to github, use this image to deploy
# to heroku using Heroku Toolbelt:
#     docker build -t publish .
#     docker run -it publish
#     Then:
#     - run "heroku login"
#     - run "git push heroku master"

FROM ruby
ENTRYPOINT ["bash"]

RUN mkdir /var/www
WORKDIR /var/www

RUN apt-get -qq update && apt-get -qqy install git
RUN gem install heroku
RUN gem install foreman

RUN	git clone https://github.com/ahmetalpbalkan/dailybbble.git
WORKDIR	dailybbble
RUN	git remote add heroku https://git.heroku.com/dailybbble.git
