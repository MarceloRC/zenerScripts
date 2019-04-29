#!/bin/bash
#Esse script só foi testado em CentOS6 até o momento.
#Nao esquecer de, no Host, clicar na VM, Botao Direito -> Guest -> Install VMWare Tools antes de executar

mkdir /mnt/CD
mount -tiso9660 /dev/cdrom /mnt/CD
yum -y install gcc perl
tar -zxvf /mnt/CD/VMwareTools-*.tar.gz
cd vmware-tools-distrib/
./vmware-install.pl -d
umount /dev/cdrom
