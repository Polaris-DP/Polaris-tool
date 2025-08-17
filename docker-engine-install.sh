#!/bin/bash

# --- 脚本说明 ---
# 这是一个安装 Docker Engine 的脚本
# ----------------

# --- 定义颜色代码 ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
# --------------------

# --- 函数：显示消息并检查上一个命令的返回码 ---
log_step() {
    echo -e "${BLUE}[+] ${1}${NC}"
}

log_info() {
    echo -e "${YELLOW}[!] ${1}${NC}"
}

log_success() {
    echo -e "${GREEN}[✔] ${1}${NC}"
}

log_error() {
    echo -e "${RED}[✖] ${1}${NC}"
}

check_command_status() {
    if [ $? -ne 0 ]; then
        log_error "$1 失败。脚本退出。"
        read -p "按任意键退出..."
        exit 1
    fi
}

# --- 函数：检查并安装 sudo ---
ensure_sudo() {
    if ! command -v sudo &> /dev/null; then
        log_info "未检测到 'sudo' 命令，尝试安装 'sudo'..."
        if [ -f /etc/debian_version ]; then
            log_step "Debian/Ubuntu 系统，安装 sudo..."
            apt update -y && apt install -y sudo
            check_command_status "安装 sudo"
        elif [ -f /etc/redhat-release ]; then
            log_step "CentOS/RHEL 系统，安装 sudo..."
            dnf install -y sudo || yum install -y sudo # Try dnf first, then yum
            check_command_status "安装 sudo"
        else
            log_error "无法自动安装 'sudo'。请手动安装 'sudo' 或以 root 用户运行脚本。"
            read -p "按任意键退出..."
            exit 1
        fi
        log_success "'sudo' 命令已安装。"
    else
        log_info "'sudo' 命令已存在。"
    fi
}

# --- 函数：检测操作系统和版本 ---
detect_os() {
    local os_id=""
    local version_codename=""
    local version_id="" # Added for RedHat family
    local detected_os_type="unsupported" # Default to unsupported

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        os_id=$ID
        version_codename=$VERSION_CODENAME
        version_id=$VERSION_ID # Get version ID for RedHat family check
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        os_id=$DISTRIB_ID
        version_codename=$DISTRIB_CODENAME
    fi

    # 调试信息，重定向到标准错误，这样它不会成为函数的返回值
    echo -e "${YELLOW}[DEBUG] Detected RAW OS: ${os_id}, Codename: ${version_codename}, Version ID: ${version_id}${NC}" >&2

    case "$os_id" in
        "ubuntu")
            case "$version_codename" in
                "jammy"|"noble")
                    detected_os_type="ubuntu"
                    ;;
                *)
                    detected_os_type="unsupported_ubuntu"
                    ;;
            esac
            ;;
        "debian")
            case "$version_codename" in
                "bullseye"|"bookworm"|"trixie")
                    detected_os_type="debian"
                    ;;
                *)
                    detected_os_type="unsupported_debian"
                    ;;
            esac
            ;;
        "centos"|"rhel"|"rocky"|"almalinux")
            if [[ "$version_id" == "9"* ]]; then
                detected_os_type="redhat"
            else
                detected_os_type="unsupported_redhat"
            fi
            ;;
        *)
            detected_os_type="unsupported"
            ;;
    esac
    echo "$detected_os_type" # This is the actual return value of the function
}


# --- 函数：卸载旧版 Docker 包 (通用命令) ---
uninstall_old_docker() {
    log_step "尝试卸载所有冲突的 Docker 旧包..."
    if command -v apt-get &> /dev/null; then
        for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
            sudo apt-get remove -y $pkg > /dev/null 2>&1 # Redirect output to null for cleaner log
        done
    elif command -v dnf &> /dev/null; then
        sudo dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine > /dev/null 2>&1
    fi
    log_success "旧版 Docker 包卸载尝试完成。"
}

# --- 函数：安装 Docker 在 Ubuntu 22+ ---
install_docker_ubuntu() {
    log_step "开始为 Ubuntu 22+ 设置 Docker Apt 存储库..."
    sudo apt-get update
    check_command_status "apt-get update"

    sudo apt-get install -y ca-certificates curl
    check_command_status "安装 ca-certificates curl"

    sudo install -m 0755 -d /etc/apt/keyrings
    check_command_status "创建 /etc/apt/keyrings 目录"

    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    check_command_status "下载 Docker GPG 密钥"

    sudo chmod a+r /etc/apt/keyrings/docker.asc
    check_command_status "设置 GPG 密钥权限"

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    check_command_status "配置 Docker APT 存储库"
    log_success "Docker Apt 存储库设置成功。"

    log_step "更新 Apt 包索引..."
    sudo apt-get update
    check_command_status "第二次 apt-get update"

    log_step "开始安装最新版 Docker 包..."
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    check_command_status "安装 Docker 包"
    log_success "Docker Engine 已成功安装在 Ubuntu!"
}

# --- 函数：安装 Docker 在 Debian 11+ ---
install_docker_debian() {
    log_step "开始为 Debian 11+ 设置 Docker Apt 存储库..."
    sudo apt-get update
    check_command_status "apt-get update"

    sudo apt-get install -y ca-certificates curl
    check_command_status "安装 ca-certificates curl"

    sudo install -m 0755 -d /etc/apt/keyrings
    check_command_status "创建 /etc/apt/keyrings 目录"

    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    check_command_status "下载 Docker GPG 密钥"

    sudo chmod a+r /etc/apt/keyrings/docker.asc
    check_command_status "设置 GPG 密钥权限"

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    check_command_status "配置 Docker APT 存储库"
    log_success "Docker Apt 存储库设置成功。"

    log_step "更新 Apt 包索引..."
    sudo apt-get update
    check_command_status "第二次 apt-get update"

    log_step "开始安装最新版 Docker 包..."
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    check_command_status "安装 Docker 包"
    log_success "Docker Engine 已成功安装在 Debian!"
}

# --- 函数：安装 Docker 在 CentOS 9+ ---
install_docker_redhat() {
    log_step "开始为 CentOS 9+ 设置 Docker DNF 存储库..."
    sudo dnf -y install dnf-plugins-core
    check_command_status "安装 dnf-plugins-core"

    sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    check_command_status "配置 Docker DNF 存储库"
    log_success "Docker DNF 存储库设置成功。"

    log_step "开始安装最新版 Docker 包..."
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    check_command_status "安装 Docker 包"

    log_step "启动 Docker 引擎并设置开机自启..."
    sudo systemctl enable --now docker
    check_command_status "启动并启用 Docker 服务"
    log_success "Docker Engine 已成功安装和启动在 CentOS!"
}

# --- 主逻辑 ---
main() {
    echo -e "${GREEN}===========================================${NC}"
    echo -e "${GREEN}  Docker Engine 智能安装脚本 ${NC}"
    echo -e "${GREEN}===========================================${NC}"

    # 确保 sudo 命令存在
    ensure_sudo

    local os_type=$(detect_os)
    log_info "检测到系统类型为: ${os_type}"

    # 卸载旧版本
    uninstall_old_docker

    local install_status=0 # 默认为成功

    case "$os_type" in
        "ubuntu")
            install_docker_ubuntu
            install_status=$?
            ;;
        "debian")
            install_docker_debian
            install_status=$?
            ;;
        "redhat")
            install_docker_redhat
            install_status=$?
            ;;
        *)
            log_error "本脚本暂不支持您的操作系统 (${os_type})。请手动安装 Docker。"
            install_status=1 # 标记为失败
            log_info "支持的系统包括：Ubuntu 22/24, Debian 11/12/13, CentOS 9。"
            ;;
    esac

    echo "" # 空行增加可读性
    if [ "$install_status" -eq 0 ]; then
        log_success "Docker Engine 安装流程完成！"
        log_step "将当前用户 (${USER}) 添加到 'docker' 组..."
        # 检查是否已在 docker 组，避免重复添加
        if ! getent group docker | grep -q "\b${USER}\b"; then
            sudo usermod -aG docker "$USER"
            check_command_status "将用户添加到 docker 组"
            log_success "用户 '${USER}' 已添加到 'docker' 组。"
            log_info "${YELLOW}!!!! IMPORTANT !!!!${NC}"
            log_info "${YELLOW}为了用户组更改生效，您需要：${NC}"
            log_info "${YELLOW}1. ${BLUE}完全退出并重新登录您的 SSH 会话，或${NC}"
            log_info "${YELLOW}2. ${BLUE}在新终端中执行 'newgrp docker' 命令。${NC}"
            log_info "${YELLOW}之后，您就可以无需 'sudo' 使用 'docker' 命令了。${NC}"
        else
            log_info "用户 '${USER}' 已在 'docker' 组中，无需重复添加。"
        fi
        log_success "您可以通过运行 'docker run hello-world' 来测试 Docker 是否正常工作。"
    else
        log_error "Docker Engine 安装过程中出现错误。请检查上方输出以获取详细信息。"
    fi

    echo -e "${GREEN}------------------------------------------${NC}"
    read -p "按任意键退出安装脚本..."
    exit $install_status
}

# --- 脚本启动 ---
main
