FROM elixir:1.4
MAINTAINER Peter Hastie <phastie@bleacherreport.com>
ADD . /app
ENV MIX_ENV prod
RUN mix local.rebar
RUN mix local.hex --force
WORKDIR /app
EXPOSE 4000
CMD [“/bin/bash”]
