FROM hypoport/ansible:2.4.1.0
WORKDIR /ci/test/integration
COPY requirements.txt /
RUN pip install --upgrade -r /requirements.txt
CMD [ "ansible-playbook", "-i", "inventory", "playbook.yml" ]
COPY . /ci
