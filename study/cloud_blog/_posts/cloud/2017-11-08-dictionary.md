Service Function Chaining (SFC) - OPNFV Artifact Repository

**NS**:（Network Service：即业务网络提供的网络服务）

**FCAPS**:(fault-management, configuration, accounting, performance, and security)

FCAPS is a network management framework created by the International Organization for Standardization (ISO). 

FCAPS categorizes the working objectives of network management into five levels. The five levels are:  fault-management (F), the configuration level (C), the accounting level (A), the performance level (P) and the security level (S).

FM（Fault Management，故障管理）
具有对故障的检测、快速定位、隔离故障点并进行修复等功能，其功能涉及本端及远端的所有网络元素。能将维护消息及时通知有关用户。
在故障管理标准中，网络问题被发现并修正。潜在的未来问题被识别，并防止它们发生或复发。这种方式下，网络能保持运作并把停止工作时间减到最小。 [2] 
故障管理最重要的实现方式是告警管理。告警管理对整个系统运行状况进行集中监控，实时采集链路、数据、服务等异常信息。当故障出现或某指标超过预先设置的门限时，告警管理系统即产生告警信息。告警信息是系统运行过程中出现的各种故障或异常的提示信息。维护人员可借助告警信息定位并排除故障，以保障系统的稳定运行。告警对应的问题或故障解决后，系统自动返回告警恢复消息。[3] 
CM（Configuration Management，配置管理）
组织网络运转所需要的资源和数据，保证网络的基本配置：监控具体的配置、按照具体情况改变配置、设置系统参数、收集并存储各参数、报告与基本配置值的偏差、起动和关闭资源等。
AM（Accounting Management，计费管理）
依据预定的收费标准对用户使用的各种资源进行计费，并开出收费通知。计费分为在线计费[4]  和离线计费[5]  。
PM（Performance Management，性能管理）
评定通信网及各种网络元素的性能，如QoS（Quality of Service，服务质量）、时延特性。
通过对采集到的全网性能数据进行统计分析，用户可以及时掌握设备的运行状况，发现性能瓶颈，为日常维护、网络优化和扩容提供数据支持。
用户可以进行对比分析，及时发现设备运行和运营上的问题，在性能越限时发出告警，并为上层决策分析提供有力的依据。[6] 
SM（Security Management，安全管理）
保证网络正常运行，信息不被外界窃取和破坏，包括对收、发方的合法身份的验证以及访问控制、网内加密等。
安全管理可确保用户对系统的合法使用，通过登录认证防止非法用户进入系统，并通过操作鉴权对操作员的操作提供安全控制。[3] 

**NETCONF**: Network Configuration Protocol

**VDU**: Virtual Deployment Unit


**CPE**: 用户驻地设备（英语：CPE, Customer-premises equipment），指位于用户端的网络终端设备，用于与电信运营商对接服务。CPE包括：用户自己的電話機、服务器、主机，以及路由器、交换机、防火墙、Wi-Fi等LAN设备，和ISP负责安装的WAN设备，例如CSU/DSU、调制解调器等。[1]。2015年第二季度，全球CPE市场收入约29亿美元。

**vCPE**: vCPE (virtual customer premises equipment) 
Virtual customer premises equipment (vCPE) is a way to deliver network services such as routing, firewall security and virtual private network connectivity to enterprises by using software rather than dedicated hardware devices. By virtualizing CPE, providers can dramatically simplify and accelerate service delivery, remotely configuring and managing devices and allowing customers to order new services or adjust existing ones on demand.

http://searchsdn.techtarget.com/definition/vCPE-virtual-customer-premise-equipment

**MEC**：Multi-access Edge Computing


**EPC**：Evolved Packet Core 核心分组网演进


**CRI**: Container Runtime Interface

At the lowest layers of a Kubernetes node is the software that, among other things, starts and stops containers. We call this the “Container Runtime”. The most widely known container runtime is Docker, but it is not alone in this space. In fact, the container runtime space has been rapidly evolving. As part of the effort to make Kubernetes more extensible, we've been working on a new plugin API for container runtimes in Kubernetes, called "CRI".

**OCI**: Open Container Initiative(开放容器计划)

2015年6月，Docker公司与Linux基金会推出的开放容器计划 (Open Container Initiative, OCI), 包括Oracle、Microsoft、EMC、IBM、Cisco和VMware等在内的一大批国际著名软件厂商的加入, 使Docker生态圈开始迅速膨胀。

**EPA**:Enhanced Platform Awareness

**OOM**: ONAP Operations Manager

**CRUD**: Create Retrieve Update Delete
	
**CCF**： common classification framework
	
**MANO**: Management And Orchestration
	
**ETSI**: European Telecommunication Standards Institue
	

	
**ODL**: OpenDayLight

	
**ODP**： OpenDataPanel
		
The ODP project has been established to produce an open-source, cross-platform set of application programming interfaces (APIs) for the networking software defined data plane.

	
**DCAE**: Data Collection, Analytics and Events
	
**DMaaP**: Data Movement as a Platform
	
**Multi-VIM**:Multi Virtualized Infrastructure Manager).

https://www.sdxcentral.com/nfv/definitions/virtualized-infrastructure-manager-vim-definition/
	
**SDN**: Software Define Network
	
**MSO**: Master Service Orchestrator
	
**SFC**: 

**ESR**:
	
**AAF**: Application Authorization Framework.
	
**VF-C**: Virtual Function Controller.
	
**OMF**: Operations Management Framework.
	
**CM**: Change Management.
	
**MSB**: Micro Services Bus.
	
**AAI**: Active and Available Inventory.
	
**CLAMP**: Closed Loop Automation Management Platform.
	
**APP-C**: Application Controller 
A virtual application is composed of the following layers of network technology:

- Service
- Virtual Network Function(VNF)
- Virtual Network Function Component(VNFC)
- Virutal Machine(VM)

**NFV**: Network Function Virtualization
	
**VNF**: Virtual Network Function.

First, what is a network function? The term typically refers to some component of a network infrastructure that provides a well-defined functional behavior, such as intrusion detection, intrusion prevention or routing.

Historically, we have deployed such network functions as physical appliances, where software is tightly coupled with specific, proprietary hardware. These physical network functions need to be manually installed into the network, creating operational challenges and preventing rapid deployment of new network functions.

A VNF, on the other hand, refers to the implementation of a network function using software that is decoupled from the underlying hardware. This can lead to more agile networks, with significant Opex and Capex savings.

In contrast, NFV typically refers to the overarching principle or concept of running software-defined network functions, independent of any specific hardware platform, as well as to a formal network virtualization initiative led by some of the world’s biggest telecommunications network operators. In conjunction with ETSI, these companies aim to create and standardize an overarching, comprehensive NFV framework, a high-level illustration of which appears below. Notice the diagram highlights VNFs that are deployed on top of NFV infrastructure, which may span more than one physical location.


To summarize, NFV is an overarching concept, while a VNF is building block within ETSI’s current NFV framework.

NFV and VNF

https://zhuanlan.zhihu.com/p/26259440



