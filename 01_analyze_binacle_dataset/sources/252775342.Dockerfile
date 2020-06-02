FROM mdillon/postgis:9.5  
  
ADD postgres_support/libst_raster_pg.so /usr/lib/postgresql/9.5/lib/  
ADD postgres_support/PGSQLEngine.so /usr/lib/postgresql/9.5/lib/  
ADD postgres_support/st_geometry.so /usr/lib/postgresql/9.5/lib/  
  
ENV LD_LIBRARY_PATH=/usr/lib/postgresql/9.5/lib/  

