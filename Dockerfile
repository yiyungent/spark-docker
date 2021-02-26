FROM ubuntu:20.04 AS base

LABEL maintainer="yiyun <yiyungent@gmail.com>"

# 设置国内阿里云镜像源
COPY etc/apt/aliyun-ubuntu-20.04-focal-sources.list   /etc/apt/sources.list

# 时区设置
ENV TZ=Asia/Shanghai

RUN apt-get update

# 1. 安装常用软件
RUN apt-get install -y wget
RUN apt-get install -y ssh
RUN apt-get install -y vim

# 2. 安装 Java
ADD jdk-8u131-linux-x64.tar.gz /opt/
RUN mv /opt/jdk1.8.0_131 /opt/jdk1.8
ENV JAVA_HOME=/opt/jdk1.8
ENV JRE_HOME=${JAVA_HOME}/jre
ENV CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV PATH=${JAVA_HOME}/bin:$PATH

# 3. 安装 Scala
RUN wget http://downloads.lightbend.com/scala/2.12.1/scala-2.12.1.tgz
RUN mkdir /opt/scala
RUN tar -zxvf scala-2.12.1.tgz -C /opt/scala/
ENV SCALA_HOME=/opt/scala/scala-2.12.1 
ENV PATH=${SCALA_HOME}/bin:$PATH 

# 4. 安装 Spark
RUN mkdir /opt/spark 
#RUN wget https://downloads.apache.org/spark/spark-3.0.2/spark-3.0.2-bin-hadoop2.7.tgz
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-3.0.2/spark-3.0.2-bin-hadoop2.7.tgz
RUN tar -zxvf spark-3.0.2-bin-hadoop2.7.tgz -C /opt/spark/
ENV SPARK_HOME=/opt/spark/spark-3.0.2-bin-hadoop2.7
ENV PATH=${SPARK_HOME}/bin:$PATH






