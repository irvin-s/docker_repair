FROM promptworks/ruby-2.0.0
ADD . ~/
WORKDIR ~/
RUN bundle install
EXPOSE 5555
CMD ["simple.rb"]
ENTRYPOINT ["ruby"]
