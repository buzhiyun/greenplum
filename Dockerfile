FROM centos:centos7.7.1908
# http://docs.greenplum.org/6-9/install_guide/install_gpdb.html

#ADD greenplum-db-6.9.0-rhel7-x86_64.rpm /tmp/greenplum-db-6.9.0-rhel7-x86_64.rpm
ADD . /tmp/
#RUN curl -Lo /tmp/greenplum-db-6.16.0-rhel7-x86_64.rpm 'https://github.91chifun.workers.dev/https://github.com//greenplum-db/gpdb/releases/download/6.16.0/open-source-greenplum-db-6.16.0-rhel7-x86_64.rpm' && \
RUN curl -Lo /tmp/greenplum-db-6.16.0-rhel7-x86_64.rpm 'https://github.com/greenplum-db/gpdb/releases/download/6.16.0/open-source-greenplum-db-6.16.0-rhel7-x86_64.rpm' && \
  yum install -y sshd apr apr-util bash bzip2 curl krb5 libcurl libevent libxml2 libyaml zlib openldap openssh openssl openssl-libs perl readline rsync R sed tar zip /tmp/greenplum-db-6.16.0-rhel7-x86_64.rpm && \
  ssh-keygen -A && systemctl enable sshd && \
  useradd -u 1000 -d /home/gpadmin -m gpadmin && echo "source /usr/local/greenplum-db-6.16.0/greenplum_path.sh" >> /home/gpadmin/.bashrc && \
  su - gpadmin -c 'mkdir ~/.ssh ; cp /tmp/id_rsa* ~/.ssh/ ; cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys ; chmod -R go-rwx ~/.ssh && mkdir /home/gpadmin/gpconfigs/ -p && cp /tmp/gpinitsystem_config  /home/gpadmin/gpconfigs/gpinitsystem_config && cp /tmp/hostfile_gpinitsystem ~/gpconfigs/ && cp /tmp/init_gpdb.sh ~/' && \
  mkdir -p /data2/primary && mkdir -p /data1/primary && mkdir -p /data/master && \
  chown -R gpadmin:gpadmin /data2/primary && chown -R gpadmin:gpadmin /data1/primary && chown -R gpadmin:gpadmin /data/master && \
  echo "export GPHOME=/usr/local/greenplum-db-6.16.0" >> /home/gpadmin/.bashrc && echo "export MASTER_DATA_DIRECTORY=/data/master/gpseg-1" >> /home/gpadmin/.bashrc && \
  rm -rf /tmp/* 

