FROM centos:7
ENV  ACCEPT_EULA 'y'
ENV PATH /opt/mssql-tools/bin/:$PATH
ADD . /
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo && \
    yum -y update && \
    yum -y install mssql-tools unixODBC-devel postgresql && \
    yum clean all && \
    rm -rf /var/cache/yum
RUN /dbdeployer_install.sh
ENTRYPOINT ["dbdeployer"]
