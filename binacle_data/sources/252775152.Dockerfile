FROM beangoben/pimp_jupyter3  
  
USER root  
  
# chemio-informatics  
#RUN pip install cairosvg  
RUN conda install -c rdkit rdkit -q -y -f && \  
conda clean -tipsy  
RUN conda install -c openbabel openbabel --quiet --yes && \  
conda clean -tipsy  
RUN conda install -c richlewis scikit-chem --quiet --yes && \  
conda clean -tipsy  
RUN pip install --no-cache imolecule cclib py3dmol cirpy pubchempy chemspipy  
  
  

