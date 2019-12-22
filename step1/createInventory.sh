for ipaddresses in `cat /tmp/ApplicationIPs`
do
echo "$ipaddresses ansible_python_interpreter=/usr/bin/python3 ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/pemfile/test.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> hosts

done

figlet ok

cat hosts



