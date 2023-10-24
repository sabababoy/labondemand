FROM mysql/mysql-cluster:latest

RUN microdnf install -y openssh-server openssh-clients passwd sudo lsof which
RUN useradd testUser
RUN echo "testUser:test" | chpasswd
RUN usermod -aG wheel testUser