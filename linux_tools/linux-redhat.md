# redhat repo
http://mirrors.aliyun.com/repo/

# disable subscription manager 
vim /etc/yum/pluginconf.d/subscription-manager.conf
enabled=0

# compile kernel

https://www.tecmint.com/compile-linux-kernel-on-centos-7/
yum config-manager --set-enabled PowerToolsyum 

# change command line
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/configuring-kernel-command-line-parameters_managing-monitoring-and-updating-the-kernel

[root@984fee003074 ~]# grubby --update-kernel=ALL --args="ro crashkernel=auto rhgb quiet $tuned_params intel_iommu=on,sm_on"
[root@984fee003074 ~]# grubby --info=ALL
