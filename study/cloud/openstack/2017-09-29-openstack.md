

Favorite Command

	$ vagrant ssh control
	$ cd /home/vagrant
	$ source devstack/openrc
	$ openstack image list
	$ source ~/devstack/openrc admin admin

	$ openstack flavor delete m1.medium  || true
	$ openstack flavor create --public m1.medium --id auto --ram 4096 --vcpus 2 --disk 40 

## get token ##
curl -i -H "Content-Type: application/json" -d '{"auth": {"identity":{"methods":["password"],"password":{"user":{"name":"admin","domain":{"id":"default" },"password":"admin"}}},"scope":{"project":{"name":"demo","domain":{"id":"default"}}}}}' "http://192.168.0.10/identity/v3/auth/tokens" 2>&1 | grep X-Subject-Token | sed "s/^.*: //"

## use token

curl -s -H "X-Auth-Token:gAAAAABZ7qm-V4PKGe-ww3kfGbPq9rVZNyGFwgj4Y95Bq5Q8lKEKQZSrEuO2f9H-egIy22GyesVDoRl4n6TPwGA_Zm0Fc3DcYPaNMWGviyWNMu8bUBb43Um1WUk-VWxHu3Tg0mfZNlQ-pP3end5QBzZRztK3kp7cXrUF45gcr9aGIo4PlSDt1-A" "http://192.168.0.10/identity/v3/endpoints"



## 4. 创建和管理虚拟机

### 4.1 创建虚拟机
openstack network list --name private -f value | cut -f1 -d' '
87e49f38-30d0-43b1-a5a6-40ec238647f0
vagrant@control:~/devstack$ openstack server create --flavor 1 --image=cirros-0.3.4-x86_64-uec --nic net-id=87e49f38-30d0-43b1-a5a6-40ec238647f0 vm1

### 4.2 查询虚拟机
vagrant@control:~/devstack$ openstack server list


## 5. 创建和管理栈

  
编排（Orchestration）服务可实现对多个组合云应用的编排。该服务支持通过兼容CloudFormation的Query API使用Amazon Web Services (AWS) CloudFormation模板, 同时也支持通过REST API使用原生OpenStack:term:`Heat Orchestration Template (HOT)`模板。

这些灵活的模板语言使应用程序开发人员能够描述和自动化基础设施、服务和应用程序的部署。该模板能创建大多数OpenStack资源类型，如实例，浮动IP地址，卷，安全组和用户。资源一旦创建，就会被称为stacks。

The template languages are described in the Template Guide in the Heat developer documentation.

### 5.1 创建一个stack


	$ openstack stack create --template server_console.yaml --parameter "image=cirros" MYSTACK
	The --parameter values that you specify depend on the parameters that are defined in the template. If a website hosts the template file, you can also specify the URL with the --template parameter.

该命令返回以下输出：

	+---------------------+----------------------------------------------------------------+
	| Field               | Value                                                          |
	+---------------------+----------------------------------------------------------------+
	| id                  | 70b9feca-8f99-418e-b2f1-cc38d61b3ffb                           |
	| stack_name          | MYSTACK                                                        |
	| description         | The heat template is used to demo the 'console_urls' attribute |
	|                     | of OS::Nova::Server.                                           |
	|                     |                                                                |
	| creation_time       | 2016-06-08T09:54:15                                            |
	| updated_time        | None                                                           |
	| stack_status        | CREATE_IN_PROGRESS                                             |
	| stack_status_reason |                                                                |
	+---------------------+----------------------------------------------------------------+

You can also use the --dry-run option with the openstack stack create command to validate a template file without creating a stack from it.

### 5.2 查看stacks

	$ openstack stack list
	+--------------------------------------+------------+-----------------+---------------------+--------------+
	| ID                                   | Stack Name | Stack Status    | Creation Time       | Updated Time |
	+--------------------------------------+------------+-----------------+---------------------+--------------+
	| 70b9feca-8f99-418e-b2f1-cc38d61b3ffb | MYSTACK    | CREATE_COMPLETE | 2016-06-08T09:54:15 | None         |
	+--------------------------------------+------------+-----------------+---------------------+--------------+

	通过以下命令来看哪些stack为当前用户可见

	$ openstack stack show MYSTACK

	一个stack由一个资源集合组成。要列出资源和它们的状态，请运行以下命令：

	$ openstack stack resource list MYSTACK
	+---------------+--------------------------------------+------------------+-----------------+---------------------+
	| resource_name | physical_resource_id                 | resource_type    | resource_status | updated_time        |
	+---------------+--------------------------------------+------------------+-----------------+---------------------+
	| server        | 1b3a7c13-42be-4999-a2a1-8fbefd00062b | OS::Nova::Server | CREATE_COMPLETE | 2016-06-08T09:54:15 |
	+---------------+--------------------------------------+------------------+-----------------+---------------------+
	要显示stack中特定资源的详细信息，请运行以下命令：
	
	$ openstack stack resource show MYSTACK server
	
	一些与资源相关的元数据可以在资源的生命周期中被修改。通过运行以下命令显示元数据：
	
	$ openstack stack resource metadata MYSTACK server
	
	在stack生命周期中生成一系列事件。要显示生命周期事件，请运行以下命令：
	
	$ openstack stack event list MYSTACK
	2016-06-08 09:54:15 [MYSTACK]: CREATE_IN_PROGRESS  Stack CREATE started
	2016-06-08 09:54:15 [server]: CREATE_IN_PROGRESS  state changed
	2016-06-08 09:54:41 [server]: CREATE_COMPLETE  state changed
	2016-06-08 09:54:41 [MYSTACK]: CREATE_COMPLETE  Stack CREATE completed successfully
	要显示某个特定事件的详细信息，请运行以下命令：
	
	$ openstack stack event show MYSTACK server EVENT

### 5.3 更新堆栈

要用修改的模板文件来更新现有的stack，运行如下的命令：

	$ openstack stack update --template server_console.yaml \
	  --parameter "image=ubuntu" MYSTACK
	+---------------------+----------------------------------------------------------------+
	| Field               | Value                                                          |
	+---------------------+----------------------------------------------------------------+
	| id                  | 267a459a-a8cd-4d3e-b5a1-8c08e945764f                           |
	| stack_name          | mystack                                                        |
	| description         | The heat template is used to demo the 'console_urls' attribute |
	|                     | of OS::Nova::Server.                                           |
	|                     |                                                                |
	| creation_time       | 2016-06-08T09:54:15                                            |
	| updated_time        | 2016-06-08T10:41:18                                            |
	| stack_status        | UPDATE_IN_PROGRESS                                             |
	| stack_status_reason | Stack UPDATE started                                           |
	+---------------------+----------------------------------------------------------------+
有些资源在原地更新，而其他的是被新资源替代。


## 6.Openstack 命令
### 6.1 pci-through
https://docs.openstack.org/nova/pike/admin/pci-passthrough.html

### 6.2 


$ openstack flavor set m1.large --property hw:numa_nodes=2
$ openstack flavor set m1.large \  # configure guest node 0
  --property hw:numa_cpus.0=0,1 \
  --property hw:numa_mem.0=2048
$ openstack flavor set m1.large \  # configure guest node 1
  --property hw:numa_cpus.1=2,3,4,5 \
  --property hw:numa_mem.1=4096

"capabilities:cpu_info:features": "<in> sse4.1"


### cpu pinning
$ openstack flavor set m1.large \
  --property hw:cpu_policy=dedicated \
  --property hw:cpu_thread_policy=prefer

Some workloads benefit from a custom topology. For example, in some operating systems, a different license may be needed depending on the number of CPU sockets. To configure a flavor to use a maximum of two sockets, run:

### cpu topology
$ openstack flavor set m1.large --property hw:cpu_sockets=2
Similarly, to configure a flavor to use one core and one thread, run:

$ openstack flavor set m1.large \
  --property hw:cpu_cores=1 \
  --property hw:cpu_threads=1

### cpu instruction set extension

openstack flavor set <FLAVOR> --property hw:capabilities:cpu_info:features=aes <GUEST>
