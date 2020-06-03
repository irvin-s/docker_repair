
# FROM neo4j:3.0.6
FROM neo4j:2.3.3

RUN apt-get update && apt-get install -y \
        python3-dev python3-setuptools \
    && easy_install3 pip \
    && pip install --upgrade ipython pip \
    # py2neo==3.1.2
    py2neo==2.0.9

# Note: in an empty dir the above is the content of Dockerfile
# docker build -t testing .
# docker run -it --rm -e NEO4J_AUTH=none -p 80:7474 testing

# py2neo 2 instructions
# from py2neo import Graph, Node
# remote_graph = Graph("http://localhost:7474/db/data/")
# alice = Node("Person", name="Alice")
# remote_graph.create(alice)

