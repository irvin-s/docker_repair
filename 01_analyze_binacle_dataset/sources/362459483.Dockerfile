From ubuntu:16.04

# To build this, do docker build -t vcmp_tests -v <path_to_local_agent_repo>:/root/devenv/f5-openstack-agent -f Dockerfile .
# Then do docker run vcmp_tests

RUN apt-get -y update
RUN apt-get install -y git
RUN apt-get install -y python-pip
RUN apt-get install -y python-dev
RUN apt-get install -y build-essential
RUN apt-get install -y libssl-dev
RUN apt-get install -y libffi-dev
RUN pip install --upgrade pip
RUN pip install git+https://github.com/F5Networks/pytest-symbols.git

# Enter your fork and branch below
RUN mkdir -p /root/devenv/f5-openstack-agent
WORKDIR /root/devenv/f5-openstack-agent
CMD pip install -r /root/devenv/f5-openstack-agent/requirements.functest.txt && py.test --symbols=/root/devenv/f5-openstack-agent/test/functional/neutronless/vcmp/common_service_handler_env.json -vvv /root/devenv/f5-openstack-agent/test/functional/neutronless/vcmp/test_vcmp.py
