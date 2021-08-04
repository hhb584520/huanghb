# A send command to A and B, A and B excute it.
# A huc
# B cloud-client5
sudo apt-get install sshpass
sudo apt-get install ansible
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub haibin@hnuc
ssh-copy-id -i ~/.ssh/id_rsa.pub haibin@cloud-client5
ansible -i host.ini  -m ping all
# when execute playbook, will use host.ini to replace /etc/ansible/hosts
# ansible will parse hosts and use the label to find in host.ini
# then send the command to the host which in the label
ansible-playbook -i host.ini -u haibin test.yml
