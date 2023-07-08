#!/bin/sh
#
# This script provides support for dynamic DNS update in Microsoft Azure
# cloud. To enable this feature, change the configuration variables below
# and make the script executable.

START_HAPROXY="/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg" #haproxy启动命令
LOG_FILE="/usr/local/keepalived/log/haproxy-check.log" # 日志文件
HAPS=`ps -C haproxy --no-header |wc -l` # 检测haproxy的状态，0代表未启动,1已经启动
date "+%Y-%m-%d %H:%M:%S" >> $LOG_FILE #在日志文件当中记录检测时间
echo "check haproxy status" >> $LOG_FILE # 记录haproxy的状态
if [ $HAPS -eq 0 ];then #执行haproxy判断
  echo $START_HAPROXY >> $LOG_FILE #记录启动命令
  /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg #启动haproxy
  sleep 3
  if [ `ps -C haproxy --no-header |wc -l` -eq 0 ];then
    echo "start haproxy failed, killall keepalived" >> $LOG_FILE
    killall keepalived
    service keepalived stop
  fi
fi
