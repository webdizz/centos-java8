centos-java8
============

A docker build of the latest CentOS release with updates applied, and java 8 installed and SSHD included.

Description:
-------------

- CentOS 6.5 + Oracle Java 8 + SSHD

Versions:
-------------

- Build on blalor/centos:latest

Usage:
-------------

docker run -d --rm -e ROOT_PASS="123456" -p 222:22 webdizz/centos-java8
ssh -p 222 root@localhost
