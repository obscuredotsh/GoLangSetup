Jenkinsfile
=========

This is the main configuration file for Jenkins to execute. This file as appropriate executions divided in steps to call 4 different ansible roles with amalgamation of shell scripts to perform the full task of creating 2 EC2 instances for GO Application Servers and 1 for Nginx Server.
The four steps are as follows :


  - Step-1 : Running ansible role (named step1) for creation of 2 (or more as defined in tasks/main.conf ) Amazon EC2 instances from scratch Ubuntu AMI.
  - Step-2 : Running bash script (createInventory.sh) to create inventory file and running 2nd ansible role (named step2) for configuring of Go Language from source code and setting up project home paths as ENV and running the default hello.go program to print hostname.
  - Step-3 : Running ansible role (named step3) for creation of 1 ( or more as defined in tasks/main.conf) Amazon EC2 instances from scratch Ubuntu AMI and install Nginx on it and adding newly launched Application Servers to vars/main.conf
  - Step-4 : Running ansible role (named step4) for creating configuring load balancing between the newly launched Application Servers


Requirements
------------
1) Ansible 2.7.15 or greater
2) Jenkins version that supports Jenkinsfile, Pipeline plugin
3) figlet program (for decorative stdout)
4) keypair from AWS (/home/ubuntu/pemfile/test.pem is the default here)
5) Python Version: 2.7, 3 or greater 

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------
- ip (roles/step4/vars/main.yml)
- AWS_KEY_PAIR (passed as extra-vars)
- ACCESS_KEY (passed as extra-vars)
- SECRET_KEY (passed as extra-vars)
- SUBNET (passed as extra-vars)

Dependencies
------------

Needed nginx on Web servers and GoLang on the Application Servers. Dependencies will installed and taken care of the ansible roles itself

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) :

    - hosts: Nginx
      roles:
         - role name
      environment:
      XYZ: ABC

Additional Info
-------

Playbooks and roles will be run automatically. Jenkins will define variables automatically on the mere execution of this Jenkins File

Author Information
------------------
 `Prateek Kaien` //
 `Devops Engineer`
 
 `prateerickaien@gmail.com`
