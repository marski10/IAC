cd /home/ec2-user
dnf install -y ansible
tee -a playbook.yml > /dev/null <<EOT
- hosts: localhost
  tasks: 
  - name: 
    copy:
      dest: /home/ec2-user/index.html
      content: <h1>Deployed via terraform</h1>
  
  - name: Instalando pyton
    dnf: 
      pkg :
        - python3
        - virtualenv
        - git
      update_cache: yes
    become: yes

  - name: clone-git
    ansible.builtin.git:
      repo: https://github.com/alura-cursos/clientes-leo-api.git
      dest: /home/ec2-user/tcc
      version: master
      force: yes
  - name: install-dependencies
    pip:
      requirements: /home/ec2-user/tcc/requirements.txt
      virtualenv: /home/ec2-user/tcc/venv

  #- name: verify installed go
  #  stat:
  #    path: /usr/local/go/bin/go
  #    register: existe
  
  - name: donwload-go 
    unarchive:
      src: https://golang.org/dl/go1.23.0.linux-amd64.tar.gz
      dest: /usr/local
      remote_src: yes
    become: yes
 #   when: not existe.stat.exists

  - name: alterando-host
    lineinfile:
      path: /home/ec2-user/tcc/setup/settings.py
      regexp: 'ALLOWED_HOSTS'
      line: 'ALLOWED_HOSTS = ["*"]'
      backrefs: yes

  - name: configure
    shell: '. /home/ec2-user/tcc/venv/bin/activate; python /home/ec2-user/tcc/manage.py migrate'
  - name: carregando-dados
    shell: '. /home/ec2-user/tcc/venv/bin/activate; python /home/ec2-user/tcc/manage.py loaddata clientes.json'

  - name: install-go
    shell: "export PATH=$PATH:/usr/local/go/bin \
            && go version \ 
            && rm -rf go1.23.0.linux-amd64.tar.gz"
    become: yes
  
  - name: install-vpn
    shell: "curl -s https://install.zerotier.com | sudo bash"


  - name: iniciando-server
    shell: '. /home/ec2-user/tcc/venv/bin/activate; nohup python /home/ec2-user/tcc/manage.py runserver 0.0.0.0:8002 &'
EOT
ansible-playbook playbook.yml