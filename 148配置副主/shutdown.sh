#!/bin/bash
#该脚本是在mysql服务出现异常时，将keepalived应用停止，从而使虚拟vip主机自动连接到另一台mysql上
killall keepalived
