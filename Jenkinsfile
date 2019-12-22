pipeline {
	agent any
	parameters {
    string defaultValue: '', description: '', name: 'AWS_KEY_PAIR', trim: false
    string defaultValue: '', description: '', name: 'ACCESS_KEY', trim: false
    string defaultValue: '', description: '', name: 'SECRET_KEY', trim: false
    string defaultValue: '', description: '', name: 'SUBNET', trim: false
    }

	stages {
	stage ('Launching Application Servers') {
	steps {
	sh ''' 
    figlet Launching 2 Application servers
    rm -rf workdir ; mkdir workdir ; cd workdir 
    cp -r ../step1/* .
    
    ansible-playbook playbook.yml --extra-vars "AWS_KEY_PAIR=$AWS_KEY_PAIR ACCESS_KEY=$ACCESS_KEY SECRET_KEY=$SECRET_KEY SUBNET=$SUBNET" > output ; 
    cat output | grep msg | cut -d':' -f2 | cut -d'"' -f2 > /tmp/ApplicationIPs
    
    cat /tmp/ApplicationIPs
    '''
	}
	}
	stage ('Deploying GO LANG APP on Application Servers') {
	steps {
	sh   ''' 
	cd workdir
	figlet Creating inventory for golang app
     
     bash -x createInventory.sh  # Create inventory for golang app
     
     cp hosts /tmp/hosts ; rm -rf * ; cp /tmp/hosts . 
     figlet hosts file for Application Servers ready
     cp -r ../step2/* .
     
     cat hosts
     
     sleep 60
     
     figlet Deploying App on Application Servers
     
     ansible-playbook playbook.yml -i hosts # Deployed go lang Application on 2 AppServers
     
     rm -rf *
	'''

	}
	}
	stage ('Launching 1 Nginx Server') {
	steps {
	sh   ''' 
	cd workdir
	cp -r ../step3/* .

    figlet Launching 1 Nginx server
    
    ansible-playbook playbook.yml  --extra-vars "AWS_KEY_PAIR=$AWS_KEY_PAIR ACCESS_KEY=$ACCESS_KEY SECRET_KEY=$SECRET_KEY SUBNET=$SUBNET" > output ; cat output | grep msg | cut -d':' -f2 | cut -d'"' -f2 > /tmp/NginxApp
    
    
    bash -x createInventory.sh #Create inventory for Nginx App
    cp hosts /tmp/hosts ; rm -rf * ; cp /tmp/hosts . 
    
    figlet Creating inventory for Nginx Server
    cp -r ../step4/* .
    for ips in `cat /tmp/ApplicationIPs` ; do echo "  - $ips" >> roles/step4/vars/main.yml ; done
    cat hosts
    
    sleep 60
	'''

	}
	}
	stage ('Configuring Load Balancing between 2 App Servers on Nginx') {
	steps {
	sh   ''' 
	cd workdir
	figlet applying Load balancing on Nginx
	
	ansible-playbook playbook.yml -i hosts # Load Balance Application on Nginx
	'''

	}
	}
	}
	}
	
