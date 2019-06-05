case $(uname -a | cut -f6 -d '.') in
"el6")
  echo "rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/6/x86_64/zabbix-release-4.2-1.el6.noarch.rpm"
  ;;
"el7")
  echo "rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm"
  ;;
*)
  echo "Versao nao compativel"
  ;;
esac  
yum -y clean all
yum upgrade zabbix-proxy-sqlite3 zabbix-agent
