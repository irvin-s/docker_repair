FROM jpamaya/ruby-2.1.1

# Add project files
ADD . /

# Bundle
RUN bundle install

