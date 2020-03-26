FROM cami/interface  
  
# add interface definition  
COPY dockermount.conf /dckr/etc/  
COPY list-spec.sh /dckr/etc/tasks.d/--list-spec  
COPY print_version.sh /dckr/etc/tasks.d/--version  
  
# Folder optionally containing all data uploaded by the user  
ENV DCKR_USERREF $DCKR_MNT/userref  
  
ENV CONT_BINNING_FILE $DCKR_MNT/input/sample.camib  
  
ENV CONT_TRUE_BINNING_FILE $DCKR_MNT/input/sample_true.camib  
  
ENV CONT_CONTIGS_FILE_LISTING $DCKR_MNT/input/contigs.fna.list  
  
ENV CONT_SCAFFOLD_CONTIG_MAPPING $DCKR_MNT/input/scaffold.tsv  
  
ENV CONT_NCBI_TAXONOMY $DCKR_MNT/input/taxonomy  
  
ENV CONT_OUTPUT_DIR $DCKR_MNT/output  

