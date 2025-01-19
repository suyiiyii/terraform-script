#cloud-config

# 判断是否运行
bootcmd:
  - echo "Hello World. The time is now $(date -R)!" | tee /userdata_bootcmd

# 换源
apt:
  primary:
    - arches: [default]
      uri: http://mirrors.tuna.tsinghua.edu.cn/ubuntu/

# 时区
timezone: Asia/Shanghai

# ntp 服务
ntp:
  enabled: true
  servers:
    - ntp1.aliyun.com

# 安装软件
package_update: true
# package_upgrade: true

# hostname
hostname: ${hostname}

# ssh 公钥
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5E3GWFRw0aQrLNDIZ3E6b5VmvzXgFI5DOhnxCDtLqqYDhJ8WQIVnPvXqDJu0ZIhSLudMX5Fng/WPO5ES7OnmZOLqla5Tq26leV4MrvIWgHlZfJuBJNc2smFLf68yxZYm0QFjqsxOK3tg0Mc2Hb+93maOCDGUY/+IkiXtgCrHNUqvA3NlaMYmNUARDoUX/eAiGCn/M7nrEN7XAM885/GXAkdyMQxIiLJpj6HrTSXalTj8G6sPap/5IHb0+Jbx+NW8W69UDkOYDEy17yyJzb6jv3TU3Qm1mCHO4R4LMA/LxQOxsSxqXQMzyNRZyHPO2UI6zPlWojlcucsLHrpZ0RhsK8UmDeyRW9zN1J9TRngLykvC6TnkBPtKdQ5jx1kgN6KG4UUCPgqjncc1f7kF30V4kX+dXUDWggM1wd8ICH1BRgbTIvZdbl/X9OnVRbqSzMF6soTdNIEbTZMvPSfFrTEmt0G44ZLqWk8NKXeFSCQKey103KNyD4pKBCTLcpQHg7qE= suyiiyii@PC-5950x

# 写入文件
write_files:
  # 欢迎信息
  - path: /etc/issue
    content: |
      \  Welcome to \S, customized by suyiiyii.
      \  Hostname: \n
      \  IP Address: \4
      \  IP Address: \6
      \  \t
    append: true
  - path: /etc/motd
    content: The OS image is customized by suyiiyii.
    append: true
  - path: /etc/ssh/sshd_config
    content: |
      PermitRootLogin yes
    append: true
  - path: /etc/hosts
    content: |
      10.21.22.21 cr.suyiiyii.top
      10.21.22.20 ubuntu-20
      10.21.22.21 ubuntu-21
      10.21.22.22 ubuntu-22
      10.21.22.23 ubuntu-23
      10.21.22.24 ubuntu-24
      10.21.22.25 ubuntu-25
      10.21.22.26 ubuntu-26
      10.21.22.27 ubuntu-27
      10.21.22.28 ubuntu-28
      10.21.22.29 ubuntu-29
      10.21.22.30 ubuntu-30
      10.21.22.31 ubuntu-31
      10.21.22.32 ubuntu-32
      10.21.22.33 ubuntu-33
      10.21.22.34 ubuntu-34
      10.21.22.35 ubuntu-35
      10.21.22.36 ubuntu-36
      10.21.22.37 ubuntu-37
      10.21.22.38 ubuntu-38
      10.21.22.39 ubuntu-39
      10.21.22.40 ubuntu-40
      10.21.22.41 ubuntu-41
      10.21.22.42 ubuntu-42
      10.21.22.43 ubuntu-43
      10.21.22.44 ubuntu-44
      10.21.22.45 ubuntu-45
      10.21.22.46 ubuntu-46
      10.21.22.47 ubuntu-47
      10.21.22.48 ubuntu-48
      10.21.22.49 ubuntu-49
      10.21.22.50 ubuntu-50
      10.21.22.51 ubuntu-51
      10.21.22.52 ubuntu-52
      10.21.22.53 ubuntu-53
      10.21.22.54 ubuntu-54
      10.21.22.55 ubuntu-55
      10.21.22.56 ubuntu-56
      10.21.22.57 ubuntu-57
      10.21.22.58 ubuntu-58
      10.21.22.59 ubuntu-59
      10.21.22.60 ubuntu-60
      10.21.22.61 ubuntu-61
      10.21.22.62 ubuntu-62
      10.21.22.63 ubuntu-63
      10.21.22.64 ubuntu-64
      10.21.22.65 ubuntu-65
      10.21.22.66 ubuntu-66
      10.21.22.67 ubuntu-67
      10.21.22.68 ubuntu-68
      10.21.22.69 ubuntu-69
      10.21.22.70 ubuntu-70
      10.21.22.71 ubuntu-71
      10.21.22.72 ubuntu-72
      10.21.22.73 ubuntu-73
      10.21.22.74 ubuntu-74
      10.21.22.75 ubuntu-75
      10.21.22.76 ubuntu-76
      10.21.22.77 ubuntu-77
      10.21.22.78 ubuntu-78
      10.21.22.79 ubuntu-79
    append: true
    






# 用户
user:
  name: suyiiyii

chpasswd:
  expire: False
  users:
    - name: root
      password: $6$As3IUoJEdk6ep5xx$mlgkdV4lSIUDqn6SqdghuIYT/dOIg4C038DdqCIRrEFRKvmIpKjN4MGZry0wSQ8RoKcwa6qjkUR6gDhc0I2W/.
    - name: suyiiyii
      password: $6$As3IUoJEdk6ep5xx$mlgkdV4lSIUDqn6SqdghuIYT/dOIg4C038DdqCIRrEFRKvmIpKjN4MGZry0wSQ8RoKcwa6qjkUR6gDhc0I2W/.

final_message: |
  cloud-init has finished
  version: $version
  timestamp: $timestamp
  datasource: $datasource
  uptime: $uptime

runcmd:
  # 允许 root 登录
  - sed -i 's/^.*ssh-rsa/ssh-rsa/' /root/.ssh/authorized_keys
  - sed -i 's/^.*ssh-ed/ssh-ed/' /root/.ssh/authorized_keys
  # 关闭 apt 下载缓存
  - echo 'Acquire::http::No-Cache true;' > /etc/apt/apt.conf.d/no-cache
  - echo "Acquire::http::Proxy \"http://10.21.22.21:3142\"; " | sudo tee /etc/apt/apt.conf.d/01proxy
  # # 禁用 swap
  - swapoff -a
  - sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
  # # 关闭 selinux
  - setenforce 0
  - sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config
  # # 关闭防火墙
  - systemctl stop ufw
  - systemctl disable ufw
  
  # 启用 ipv4 转发
  - echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
  - sysctl -p
  # 设置所需的 sysctl 参数，参数在重新启动后保持不变
  - |
    cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
    net.ipv4.ip_forward = 1
    EOF

  # 应用 sysctl 参数而不重新启动
  - sudo sysctl --system
  - apt install -y curl wget htop btop vim git tmux

%{if nerdctl}

  # 安装 nerdctl
  - wget 10.21.22.21:8000/nerdctl-full-1.7.6-linux-amd64.tar.gz -O /root/nerdctl.tar.gz -q
  - tar -xvf /root/nerdctl.tar.gz -C /usr/local/
  - rm /root/nerdctl.tar.gz
  - ln /usr/local/bin/nerdctl /usr/local/bin/docker
  - systemctl enable --now containerd
  # 开启 nerdctl 自动补全
  - nerdctl completion bash | sudo tee /etc/bash_completion.d/nerdctl > /dev/null && sudo chmod a+r /etc/bash_completion.d/nerdctl
  - echo 'complete -o default -F __start_nerdctl docker' >> /etc/bash.bashrc
  # 自动开启 nerdctl 的 debug 模式
  - echo "alias nerdctl=\"nerdctl --debug\"" >> /etc/bash.bashrc

  # 生成 containerd 配置文件
  - mkdir -p /etc/containerd
  - containerd config default > /etc/containerd/config.toml
  # cgroup 驱动程序 systemd
  - sed -i 's#SystemdCgroup = false#SystemdCgroup = true#g' /etc/containerd/config.toml
  # 在 "[plugins."io.containerd.grpc.v1.cri".registry]" 行下面添加以下一行：
  # [plugins."io.containerd.grpc.v1.cri".registry]
  #     config_path = "/etc/containerd/certs.d"
  - sed -i '/\[plugins."io.containerd.grpc.v1.cri".registry\]/,/^\[/ s/config_path = ""/config_path = "\/etc\/containerd\/certs.d"/' /etc/containerd/config.toml
  # sandbox_image 版本
  - sed -i 's#sandbox_image = "registry.k8s.io/pause:3.8"#sandbox_image = "registry.k8s.io/pause:3.9"#g' /etc/containerd/config.toml
  - systemctl restart containerd

  # 加速 nerdctl crictl
  - mkdir -p /etc/containerd/certs.d/docker.io
  - |
    mkdir -p /etc/containerd/certs.d/docker.io && cat > /etc/containerd/certs.d/docker.io/hosts.toml << EOF
    server = "https://docker.io"
    [host."https://cr.suyiiyii.top/docker.io"]
      capabilities = ["pull", "resolve"]
    EOF
    mkdir -p /etc/containerd/certs.d/registry.k8s.io && cat > /etc/containerd/certs.d/registry.k8s.io/hosts.toml << EOF
    server = "https://registry.k8s.io"
    [host."https://cr.suyiiyii.top/registry.k8s.io"]
      capabilities = ["pull", "resolve"]
    EOF
    mkdir -p /etc/containerd/certs.d/gcr.io && cat > /etc/containerd/certs.d/gcr.io/hosts.toml << EOF
    server = "https://gcr.io"
    [host."https://cr.suyiiyii.top/gcr.io"]
      capabilities = ["pull", "resolve"]
    EOF
    mkdir -p /etc/containerd/certs.d/ghcr.io && cat > /etc/containerd/certs.d/ghcr.io/hosts.toml << EOF
    server = "https://ghcr.io"
    [host."https://cr.suyiiyii.top/ghcr.io"]
      capabilities = ["pull", "resolve"]
    EOF
    mkdir -p /etc/containerd/certs.d/k8s.gcr.io && cat > /etc/containerd/certs.d/k8s.gcr.io/hosts.toml << EOF
    server = "https://k8s.gcr.io"
    [host."https://cr.suyiiyii.top/k8s.gcr.io"]
      capabilities = ["pull", "resolve"]
    EOF
    mkdir -p /etc/containerd/certs.d/quay.io && cat > /etc/containerd/certs.d/quay.io/hosts.toml << EOF
    server = "https://quay.io"
    [host."https://cr.suyiiyii.top/quay.io"]
      capabilities = ["pull", "resolve"]
    EOF

  # 加速 buildkit
  - |
    mkdir -p /etc/buildkit && cat > /etc/buildkit/buildkitd.toml << EOF
    debug = true
    # trace = true

    [registry."docker.io"]
      mirrors = ["https://cr.suyiiyii.top/docker.io"]

    [registry."registry.k8s.io"]
      mirrors = ["https://cr.suyiiyii.top/registry.k8s.io"]

    [registry."quay.io"]
      mirrors = ["https://cr.suyiiyii.top/quay.io"]

    [registry."gcr.io"]
      mirrors = ["https://cr.suyiiyii.top/gcr.io"]

    [registry."ghcr.io"]
      mirrors = ["https://cr.suyiiyii.top/ghcr.io"]

    [registry."k8s.gcr.io"]
      mirrors = ["https://cr.suyiiyii.top/k8s.gcr.io"]
      
    EOF
  - systemctl enable --now buildkit.service  


%{endif}

%{if docker_dind || docker_ce || docker_ubuntu} 

  # 配置 docker 镜像加速
  - |
    mkdir -p /etc/docker &&
    echo "{  \"registry-mirrors\": [    \"https://cr.suyiiyii.top/docker.io\"  ]}" > /etc/docker/daemon.json
  - |
    mkdir -p /etc/docker &&
    echo "{  \"registry-mirrors\": [    \"https://docker.m.ixdev.cn\"  ]}" > /etc/docker/daemon.json

  # 配置 docker 版 lazydocker 命令行容器管理工具
  - echo "alias lzd='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v /root/config:/.config/jesseduffield/lazydocker lazyteam/lazydocker'" >> ~/.bashrc

  # 配置 docker 版 dive 命令行容器镜像分析工具
  - echo "alias dive='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive'" >> ~/.bashrc
%{endif}


%{if docker_dind}

  # # 使用 dind 运行 docker daemon 并安装 docker 命令到主机
  - nerdctl run -d --name docker --privileged -v /var/run:/var/run -v /etc/docker/daemon.json:/etc/docker/daemon.json docker:dind
  - nerdctl cp docker:/usr/local/bin/docker /usr/local/bin/docker
  - nerdctl cp docker:/usr/local/bin/docker-compose /usr/local/bin/docker-compose

%{endif}

%{if docker_ce}

  # 使用官方命令和清华源安装 docker
  - for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg -y; done
  - apt-get -o pkgProblemResolver=true -o Acquire::http=true update -y
  - apt-get -o pkgProblemResolver=true -o Acquire::http=true install ca-certificates curl gnupg -y
  - install -m 0755 -d /etc/apt/keyrings
  - curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  - sudo chmod a+r /etc/apt/keyrings/docker.gpg
  - |
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] http://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
  - apt-get -o pkgProblemResolver=true -o Acquire::http=true update -y
  - apt-get -o pkgProblemResolver=true -o Acquire::http=true install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

%{endif}

%{if docker_ubuntu}
  # 使用 ubuntu 源安装 docker
  - apt-get -o pkgProblemResolver=true -o Acquire::http=true install docker.io docker-compose -y


%{endif}

%{if docker_dind || docker_ce || docker_ubuntu} 
  # docker 命令自动补全
  - docker completion bash | sudo tee /etc/bash_completion.d/docker > /dev/null && sudo chmod a+r /etc/bash_completion.d/docker

  # 将用户添加到 docker 用户组
  - usermod -aG docker suyiiyii

%{endif}

%{if k8s_tools}

  # 使用 清华 源 安装 k8s 工具
  - curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/kubernetes/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  - echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] http://mirrors.tuna.tsinghua.edu.cn/kubernetes/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
  - apt-get -o pkgProblemResolver=true -o Acquire::http=true update -y
  - apt-get -o pkgProblemResolver=true -o Acquire::http=true install -y kubelet=1.30.2-1.1 kubeadm=1.30.2-1.1 kubectl=1.30.2-1.1 && apt-mark hold kubelet kubeadm kubectl
  # 配置 k 为 kubectl 的别名
  - echo "alias k=kubectl" >> /etc/bash.bashrc
  # 开启 kubectl 自动补全
  - kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null && sudo chmod a+r /etc/bash_completion.d/kubectl
  - echo 'complete -o default -F __start_kubectl k' >> /etc/bash.bashrc
  # 开启 kubeadm 自动补全
  - kubeadm completion bash | sudo tee /etc/bash_completion.d/kubeadm > /dev/null && sudo chmod a+r /etc/bash_completion.d/kubeadm
  # 开启 crictl 自动补全
  - crictl completion bash | sudo tee /etc/bash_completion.d/crictl > /dev/null && sudo chmod a+r /etc/bash_completion.d/crictl
%{endif}

%{if neofetch}
  # 安装 neofetch
  - apt-get -o pkgProblemResolver=true -o Acquire::http=true install neofetch -y

%{endif}

%{if helm}
  # 安装 helm
  - curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
  - sudo apt-get install apt-transport-https --yes
  - echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  - sudo apt-get update
  - sudo apt-get install helm
  - helm completion bash | sudo tee /etc/bash_completion.d/helm > /dev/null && sudo chmod a+r /etc/bash_completion.d/helm

%{endif}

%{if k9s}
  # 安装 k9s
  - curl -sS https://webinstall.dev/k9s | bash

%{endif}

%{if k3s}

  - |
    mkdir -p /etc/rancher/k3s && cat > /etc/rancher/k3s/registries.yaml <<EOF
    mirrors:
      docker.io:
        endpoint:
          - "https://cr.suyiiyii.top/docker.io/v2/"
      registry.k8s.io:
        endpoint:
          - "https://cr.suyiiyii.top/registry.k8s.io/v2/"
      quay.io:
        endpoint:
          - "https://cr.suyiiyii.top/quay.io/v2/"
      gcr.io:
        endpoint:
          - "https://cr.suyiiyii.top/gcr.io/v2/"
      ghcr.io:
        endpoint:
          - "https://cr.suyiiyii.top/ghcr.io/v2/"
    EOF

  - curl -sfL https://rancher-mirror.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
%{endif}