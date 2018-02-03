FROM  giovtorres/slurm-docker-cluster:latest

LABEL org.label-schema.vcs-url="https://github.com/giovtorres/slurm-docker-cluster" \
      org.label-schema.docker.cmd="docker-compose up -d" \
      org.label-schema.name="mpi-docker-cluster" \
      org.label-schema.description="Slurm Docker cluster on CentOS 7 with MPI" \
      maintainer="Ken Richards"

RUN yum makecache fast \
    && yum -y install epel-release \
    && yum -y install \
           gcc-gfortran \
    && yum clean all \
    && rm -rf /var/cache/yum


# Add mpich
RUN \
    cd /usr/local/src/ && \
    wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz && \
    tar xf mpich-3.2.tar.gz && \
    rm mpich-3.2.tar.gz && \
    cd mpich-3.2 && \
    ./configure --with-slurm=/usr && \
    make && make install && \
    cd /usr/local/src && \
    rm -rf mpich-3.2


COPY Examples /data/Examples/
COPY slurm.conf /etc/slurm/slurm.conf
COPY slurmdbd.conf /etc/slurm/slurmdbd.conf

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["slurmdbd"]
