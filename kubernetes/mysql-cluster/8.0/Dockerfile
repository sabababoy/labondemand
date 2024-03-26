FROM mysql/mysql-cluster:8.0

RUN microdnf install -y openssh-server openssh-clients passwd sudo lsof which procps net-tools
RUN chmod +x /usr/sbin/sshd
RUN useradd testUser
RUN echo "testUser:test" | chpasswd
RUN usermod -aG wheel testUser