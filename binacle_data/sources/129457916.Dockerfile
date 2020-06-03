## Start with the rstudio image providing 'base R' as well as RStudio based on Debian testing
FROM eddelbuettel/ubuntu-hadleyverse
MAINTAINER Carl Boettiger cboettig@ropensci.org

## Update and install library dependencies 
RUN apt-get update && apt-get install -y --no-install-recommends libxslt1-dev 

## Install Omegahat dependencies 
RUN install2.r -r http://www.omegahat.org/R \
    RHTMLForms \
    RWordXML \
    SSOAP \
    Sxslt \
    XMLSchema

## Install Github dependencies
RUN Rscript -e 'devtools::install_github(c("DataONEorg/rdataone/dataonelibs", "ropensci/rdataone/dataone", "egonw/rrdf/rrdflibs","egonw/rrdf/rrdf"),  dependencies=NA, build_vignettes=FALSE)'

## Install build dependencies
#RUN apt-get install -qy libgeos-dev libgeos-c1 gdal-bin libgdal1 libgdal1-dev netcdf-bin libproj-dev
RUN apt-get build-dep -y r-cran-rgeos r-cran-rgdal

## Install additional package dependencies / commonly used packages
RUN install2.r \
    pander \
    knitcitations

## Install the rOpenSci R packages that are currently on CRAN
RUN install2.r \ 
    alm \
    AntWeb \
    aRxiv \
    bold \
    dvn \
    ecoengine \
    paleobioDB \
    rAltmetric \
    rAvis \
    rbhl \
    rbison \
    rdryad \
    rebird \
    rentrez \
    Reol \
    rfigshare \
    rfishbase \
    rfisheries \
    rgbif \
    rinat \
    RNeXML \
    rnoaa \
    rplos \
    RSelenium \
    rsnps \
    rWBclimate \
    solr \
    spocc \
    taxize \
    treebase 

