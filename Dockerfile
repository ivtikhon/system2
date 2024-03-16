FROM ubuntu:22.04
RUN apt-get update && apt-get install -y g++ build-essential cmake flex bison gengetopt git unzip
# build & install cryptominisat
RUN cd /usr/src && git clone https://github.com/msoos/cryptominisat.git && cd cryptominisat && mkdir build && cd build && cmake -DIPASIR=ON .. && make && make install
ENV LD_LIBRARY_PATH /usr/local/lib
## build & install pandaPI
RUN cd /usr/src && git clone https://github.com/panda-planner-dev/pandaPIparser.git && cd pandaPIparser && make -j && mv pandaPIparser /usr/local/bin/pandaPIparser
RUN cd /usr/src && git clone https://github.com/panda-planner-dev/pandaPIgrounder.git && cd pandaPIgrounder && git submodule init && git submodule update && cd cpddl && git apply ../0002-makefile.patch && make boruvka opts bliss lpsolve && make && cd ../src && make && mv ../pandaPIgrounder /usr/local/bin/pandaPIgrounder
RUN cd /usr/src && git clone https://github.com/panda-planner-dev/pandaPIengine.git && cd pandaPIengine && mkdir build && cd build && cmake -DSAT=ON ../src && make -j && mv pandaPIengine /usr/local/bin/pandaPIengine

