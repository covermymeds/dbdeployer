FROM centos:7

RUN rpm --import https://download.postgresql.org/pub/repos/yum/RPM-GPG-KEY-PGDG

# Enable PostgreSQL 15 repository
RUN yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

# Add EPEL repository for additional packages
RUN yum -y install epel-release

ENV ACCEPT_EULA 'y'
ENV PATH /opt/mssql-tools/bin/:$PATH

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo && \
    yum -y update && \
    yum -y install mssql-tools unixODBC-devel postgresql15 git && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN mkdir /app
ADD . /app
RUN /app/dbdeployer_install.sh

ENTRYPOINT ["/usr/bin/dbdeployer"]
