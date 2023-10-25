FROM mysql/mysql-cluster:latest

RUN microdnf install -y openssh-server openssh-clients passwd sudo lsof which procps net-tools
RUN chmod +x /usr/sbin/sshd
RUN useradd testUser
RUN echo "testUser:test" | chpasswd
RUN usermod -aG wheel testUser