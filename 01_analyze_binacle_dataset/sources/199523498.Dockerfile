# Sequana docker builder
FROM sequana/sequana:latest
MAINTAINER Thomas Cokelaer <thomas.cokelaer@pasteur.fr>
ENTRYPOINT ["sequana_taxonomy"]
CMD '--help'
