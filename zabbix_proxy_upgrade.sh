case $(uname -a | cut -f6 -d '.') in
6)
  rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/6/x86_64/zabbix-release-4.2-1.el6.noarch.rpm
  ;;
7)
  rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
  ;;
*)
  echo "*******************************Versao nao compativel**************************************"
  ;;
esac  
yum -y clean all
service zabbix-proxy stop && service zabbix-agent stop
yum -y upgrade zabbix-proxy-sqlite3 zabbix-agent
service zabbix-proxy start && service zabbix-agent start
