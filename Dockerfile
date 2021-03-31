FROM centos:7

ENV ACCEPT_EULA 'y'
ENV PATH /opt/mssql-tools/bin/:$PATH

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo && \
    yum -y update && \
    yum -y install mssql-tools unixODBC-devel postgresql git && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN mkdir /app
ADD . /app
RUN /app/dbdeployer_install.sh

ENTRYPOINT ["/usr/bin/dbdeployer"]
