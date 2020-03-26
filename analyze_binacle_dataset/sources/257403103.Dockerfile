# Copyright (C) 2016 @vsouza.
# Author: Vinicius Souza <hi@vsouza.com>

FROM perfectlysoft/ubuntu1510
RUN /usr/src/Perfect-Ubuntu/install_swift.sh --sure
ADD . /usr/src/perfect-todo-example
WORKDIR /usr/src/perfect-todo-example
RUN swift build --configuration release
CMD .build/release/perfect-todo-example
EXPOSE 8181
