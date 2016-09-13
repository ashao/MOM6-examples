mkdir -p build/gnu/shared/repro/
(cd build/gnu/shared/repro/; rm -f path_names; \
../../../../src/mkmf/bin/list_paths ../../../../src/FMS; \
../../../../src/mkmf/bin/mkmf -t ../../../../src/mkmf/templates/linux-gnu.mk -p libfms.a -c "-Duse_libMPI -Duse_netCDF -DSPMD" path_names)
(cd build/gnu/shared/repro/; source ../../env; make NETCDF=4 REPRO=1 FC=mpif90 CC=mpicc libfms.a -j)

mkdir -p build/gnu/ocean_only/repro/
(cd build/gnu/ocean_only/repro/; rm -f path_names; \
../../../../src/mkmf/bin/list_paths ./ ../../../../src/MOM6/{config_src/dynamic,config_src/solo_driver,src/{*,*/*}}/ ; \
../../../../src/mkmf/bin/mkmf -t ../../../../src/mkmf/templates/linux-gnu.mk -o '-I../../shared/repro' -p 'MOM6 -L../../shared/repro -lfms' -c "-Duse_libMPI -Duse_netCDF -DSPMD" path_names)
(cd build/gnu/ocean_only/repro/; source ../../env; make NETCDF=4 REPRO=1 FC=mpif90 LD=mpif90 MOM6 -j)

mkdir -p build/gnu/ice_ocean_SIS2/repro/
(cd build/gnu/ice_ocean_SIS2/repro/; rm -f path_names; \
../../../../src/mkmf/bin/list_paths ./ ../../../../src/MOM6/config_src/{dynamic,coupled_driver} ../../../../src/MOM6/src/{*,*/*}/ ../../../../src/{atmos_null,coupler,land_null,ice_ocean_extras,icebergs,SIS2,FMS/coupler,FMS/include}/)
(cd build/gnu/ice_ocean_SIS2/repro/; \
../../../../src/mkmf/bin/mkmf -t ../../../../src/mkmf/templates/linux-gnu.mk -o '-I../../shared/repro' -p MOM6 -l '-L../../shared/repro -lfms' -c '-Duse_libMPI -Duse_netCDF -DSPMD -DUSE_LOG_DIAG_FIELD_INFO -Duse_AM3_physics' path_names )
(cd build/gnu/ice_ocean_SIS2/repro/; source ../../env; make NETCDF=4 REPRO=1 MOM6 -j)
