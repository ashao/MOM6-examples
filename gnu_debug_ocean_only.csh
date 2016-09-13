mkdir -p build/gnu/shared/debug/
(cd build/gnu/shared/debug/; rm -f path_names; \
../../../../src/mkmf/bin/list_paths ../../../../src/FMS; \
../../../../src/mkmf/bin/mkmf -t ../../../../src/mkmf/templates/linux-gnu.mk -p libfms.a -c "-Duse_libMPI -Duse_netCDF -DSPMD" path_names)
(cd build/gnu/shared/debug/; source ../../env; make NETCDF=4 DEBUG=1 FC=mpif90 CC=mpicc libfms.a -j)

mkdir -p build/gnu/ocean_only/debug/
(cd build/gnu/ocean_only/debug/; rm -f path_names; \
../../../../src/mkmf/bin/list_paths ./ ../../../../src/MOM6/{config_src/dynamic,config_src/solo_driver,src/{*,*/*}}/ ; \
../../../../src/mkmf/bin/mkmf -t ../../../../src/mkmf/templates/linux-gnu.mk -o '-I../../shared/debug' -p 'MOM6 -L../../shared/debug -lfms' -c "-Duse_libMPI -Duse_netCDF -DSPMD" path_names)
(cd build/gnu/ocean_only/debug/; source ../../env; make NETCDF=4 DEBUG=1 FC=mpif90 LD=mpif90 MOM6 -j)
