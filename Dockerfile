# Base image
FROM ubuntu:20.04

# MAINTAINER
MAINTAINER wuhaoran wuhaoran@kaikeba.com

ENV DEBIAN_FRONTEND noninteractive

# CMD docker run执行
# RUN docker build执行

ADD node-v14.16.1-linux-x64.tar.xz /usr/local/src/

RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get install vim -y
RUN apt-get install wget -y
RUN apt-get install curl -y
RUN apt-get install gzip -y
RUN apt-get install inetutils-ping -y
RUN apt-get install net-tools -y

# WORKDIR 指定工作目录
WORKDIR /home/

RUN ln -s /usr/local/src/node-v14.16.1-linux-x64/bin/node /usr/local/bin/node
RUN ln -s /usr/local/src/node-v14.16.1-linux-x64/bin/npm /usr/local/bin/npm

# EXPOSE 暴露 80 端口
EXPOSE 80
EXPOSE 8080

# 默认启动命令
COPY build /var/www/feup/
ADD feup /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/feup /etc/nginx/sites-enabled/
RUN chmod +x /etc/nginx/sites-available/feup
RUN chmod -R 755 /var/www/feup/
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD ["start.sh", "run"]

