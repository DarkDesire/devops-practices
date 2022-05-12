#!/bin/bash
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum update -y
yum install -y java-11-openjdk.x86_64

java_version=$(java -version 2>&1 >/dev/null | grep "java version\|openjdk version" | awk '{print substr($3,2,2)}')

if [ "$java_version" -ge 11 ]
then
    echo Java version 11 or greater installed successfully
else
    echo Java installation failed
fi
