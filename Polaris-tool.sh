#!/bin/bash

# --- 脚本说明 ---
# 这是一个方便用户安装常用开源项目的一键安装脚本管理工具。
# 所有操作和安装输出都将持续显示在屏幕上，不会清屏。
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

# --- 函数：显示主菜单 ---
show_main_menu() {
    # 不再有 clear 命令！
    echo -e "${GREEN}===========================================${NC}"
    echo -e "${GREEN}一键安装脚本管理工具 - 请选择您要安装的项目 ${NC}"
    echo -e "${GREEN}===========================================${NC}"
    echo -e "${YELLOW}1. ${NC} 安装 ${CYAN}3x-ui${NC} (MHSanaei)"
    echo -e "${YELLOW}2. ${NC} 安装 ${CYAN}x-ui${NC} (alireza0)"
    echo -e "${YELLOW}3. ${NC} 安装 ${CYAN}s-ui${NC} (alireza0)"
    echo -e "${YELLOW}4. ${NC} 安装 ${CYAN}sublinkX${NC} (Ggooaclok819)"
    echo -e "${YELLOW}5. ${NC} 安装 ${CYAN}Docker Engine${NC}"
    echo -e "${YELLOW}6. ${NC} 安装 ${CYAN}哆啦A梦面板${NC} (Docker部署)(bqlpfy)"
    echo -e "${YELLOW}7. ${NC} 安装 ${CYAN}NodePassDash${NC} (NodePassProject)"
    echo -e "${YELLOW}8. ${NC} 执行 ${CYAN}realm${NC} 转发脚本"
    echo -e "${YELLOW}9. ${NC} 安装 ${CYAN}Komari服务器监控${NC}(Komari Moniter)" 
    echo -e "${YELLOW}0. ${NC} 退出脚本"
    echo -e "${GREEN}===========================================${NC}"
    echo -n -e "${BLUE}请输入您的选择 (0-9): ${NC}"
}

# --- 统一的安装完成提示函数 ---
prompt_after_install() {
    local install_name=$1
    local important_info=$2
    local install_status=$3 # 0 for success, non-zero for failure

    echo "" # 空行增加可读性
    if [ "$install_status" -eq 0 ]; then
        echo -e "${GREEN}✅ ${install_name} 安装脚本已执行完成！${NC}"
        if [ -n "$important_info" ]; then # 检查是否有重要信息
            echo -e "${YELLOW}请仔细查看上方输出，特别是${RED}${important_info}${YELLOW}等重要信息！${NC}"
            echo -e "${YELLOW}${RED}请务必复制或记录下来！${NC}"
        fi
        read -p "$(echo -e "${BLUE}确认您已处理关键信息后，按回车键继续...${NC}")"
    else
        echo -e "${RED}❌ ${install_name} 安装脚本执行失败，请检查网络、权限或脚本链接！${NC}"
        read -p "$(echo -e "${BLUE}按回车键继续...${NC}")"
    fi
    echo -e "--- ${install_name} 安装结束 ---\n"
}

# --- 函数：安装 3x-ui ---
install_3x_ui() {
    echo -e "\n--- 开始安装 3x-ui ---"
    echo -e "${YELLOW}正在安装 3x-ui...${NC}"
    echo -e "${BLUE}执行命令: bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)${NC}"
    bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
    prompt_after_install "3x-ui" "默认用户名和密码" $?
}

# --- 函数：安装 x-ui ---
install_x_ui() {
    echo -e "\n--- 开始安装 x-ui ---"
    echo -e "${YELLOW}正在安装 x-ui...${NC}"
    echo -e "${BLUE}执行命令: bash <(curl -Ls https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh)${NC}"
    bash <(curl -Ls https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh)
    prompt_after_install "x-ui" "默认用户名和密码" $?
}

# --- 函数：安装 s-ui ---
install_s_ui() {
    echo -e "\n--- 开始安装 s-ui ---"
    echo -e "${YELLOW}正在安装 s-ui...${NC}"
    echo -e "${BLUE}执行命令: bash <(curl -Ls https://raw.githubusercontent.com/alireza0/s-ui/master/install.sh)${NC}"
    bash <(curl -Ls https://raw.githubusercontent.com/alireza0/s-ui/master/install.sh)
    prompt_after_install "s-ui" "默认用户名和密码" $?
}

# --- 函数：安装 sublinkX ---
install_sublinkX() {
    echo -e "\n--- 开始安装 sublinkX ---"
    echo -e "${YELLOW}正在安装 sublinkX...${NC}"
    echo -e "${BLUE}执行命令: curl -s -H \"Cache-Control: no-cache\" -H \"Pragma: no-cache\" https://raw.githubusercontent.com/gooaclok819/sublinkX/main/install.sh | sudo bash${NC}"
    curl -s -H "Cache-Control: no-cache" -H "Pragma: no-cache" https://raw.githubusercontent.com/gooaclok819/sublinkX/main/install.sh | sudo bash
    prompt_after_install "sublinkX" "安装结果和可能的重要提示" $?
}

# --- 函数：安装 Docker Engine ---
install_docker_engine() {
    echo -e "\n--- 开始安装 Docker Engine ---"
    echo -e "${YELLOW}正在安装 Docker Engine...${NC}"
    echo -e "${BLUE}执行命令: curl -fsSL https://raw.githubusercontent.com/Polaris-DP/Polaris-tool/refs/heads/main/docker-engine-install.sh | bash${NC}"
    curl -fsSL https://raw.githubusercontent.com/Polaris-DP/Polaris-tool/refs/heads/main/docker-engine-install.sh | bash
    prompt_after_install "Docker Engine" "" $?
}

# --- 函数：安装 哆啦A梦中转面板 ---
install_forward_panel() {
    echo -e "\n--- 开始安装 哆啦A梦中转面板 ---"
    echo -e "${YELLOW}正在安装 哆啦A梦中转面板 (Docker部署)...${NC}"
    echo -e "${BLUE}执行命令: curl -L https://raw.githubusercontent.com/bqlpfy/forward-panel/refs/heads/main/panel_install.sh -o panel_install.sh && chmod +x panel_install.sh && ./panel_install.sh${NC}"

    # 执行命令
    curl -L https://raw.githubusercontent.com/bqlpfy/forward-panel/refs/heads/main/panel_install.sh -o panel_install.sh && \
    chmod +x panel_install.sh && \
    ./panel_install.sh
    local install_status=$?

    # 哆啦A梦中转面板有特定的初始账号密码提示
    local important_info="管理员账号密码"
    prompt_after_install "哆啦A梦中转面板" "$important_info" $install_status
}

# --- 函数：NodePassDash 子菜单及安装逻辑 ---
install_nodepass_dash() {
    while true; do
        echo -e "\n${GREEN}===========================================${NC}"
        echo -e "${GREEN}  NodePassDash 安装 - 请选择部署方式 ${NC}"
        echo -e "${GREEN}===========================================${NC}"
        echo -e "${YELLOW}1. ${NC} Docker 部署"
        echo -e "${YELLOW}2. ${NC} 二进制部署"
        echo -e "${YELLOW}0. ${NC} 返回主菜单"
        echo -e "${GREEN}===========================================${NC}"
        echo -n -e "${BLUE}请输入您的选择 (0-2): ${NC}"
        read -r sub_choice

        case "$sub_choice" in
            1)
                echo -e "\n--- 开始安装 NodePassDash (Docker 部署) ---"
                echo -e "${YELLOW}正在执行 Docker 部署命令...${NC}"
                
                # Check for Docker and Docker Compose (modified logic)
                # 检查 docker 命令是否存在，并且 docker compose 命令是否可用
                if ! command -v docker &> /dev/null; then
                    echo -e "${RED}!! 错误：Docker 命令未找到。请确保 Docker Engine 已安装 (选项 5) 并且当前用户已在 docker 用户组中（可能需要重新登录）。${NC}"
                    local docker_status=1
                elif ! docker compose version &> /dev/null; then
                    echo -e "${RED}!! 错误：Docker Compose 功能未找到或不可用。请确保 Docker 版本支持 'docker compose' 命令。${NC}"
                    local docker_status=1
                else
                    echo -e "${GREEN}✅ Docker 和 Docker Compose 功能检查通过。${NC}"
                    local docker_status=0 # 预设成功，如果中间步骤失败会更新
                    
                    # 1. 下载 Docker Compose 文件并重命名
                    echo -e "${BLUE}1. 下载 Docker Compose 文件...${NC}"
                    wget https://raw.githubusercontent.com/NodePassProject/NodePassDash/main/docker-compose.release.yml -O docker-compose.yml
                    if [ "$?" -ne 0 ]; then # 使用 $? 检查上一条命令的退出状态
                        echo -e "${RED}下载 Docker Compose 文件失败！${NC}"
                        docker_status=1
                    fi
                    
                    if [ "$docker_status" -eq 0 ]; then # 只有上一步成功才继续
                        # 2. 创建必要目录
                        echo -e "${BLUE}2. 创建必要目录 logs public...${NC}"
                        mkdir -p logs public && chmod 777 logs public
                        if [ "$?" -ne 0 ]; then
                            echo -e "${RED}创建目录失败！${NC}"
                            docker_status=1
                        fi
                    fi

                    if [ "$docker_status" -eq 0 ]; then # 只有上一步成功才继续
                        # 3. 启动服务
                        echo -e "${BLUE}3. 启动 Docker 服务...${NC}"
                        # 使用 `docker compose`
                        docker compose up -d
                        if [ "$?" -ne 0 ]; then
                            echo -e "${RED}启动 Docker Compose 服务失败！${NC}"
                            docker_status=1
                        fi
                    fi

                    if [ "$docker_status" -eq 0 ]; then # 只有上一步成功才继续
                        # 4. 获取初始化信息
                        echo -e "${BLUE}4. 获取系统初始化信息 (默认管理员信息)...${NC}"
                        echo -e "${CYAN}请等待几秒钟，或按下 Ctrl+C 停止等待后手动查看日志。${NC}"
                        # 延时等待确保服务启动
                        sleep 10 
                        # 尝试捕获输出，并增加等待时间以确保服务启动和信息生成
                        docker logs nodepassdash --follow --since 1m | grep -m 1 -A 6 "系统初始化完成"
                        if [ "$?" -ne 0 ]; then
                            echo -e "${YELLOW}⚠️ 注意：未能立刻捕获到 '系统初始化完成' 信息。您可能需要稍后手动执行 'docker logs nodepassdash' 查看初始密码。${NC}"
                        else
                            echo -e "${GREEN}✅ 成功捕获到初始化信息。${NC}"
                        fi
                    fi
                fi
                prompt_after_install "NodePassDash (Docker)" "系统初始化完成后的管理员账号密码" $docker_status
                break # 完成子选项后返回主菜单
                ;;
            2)
                echo -e "\n--- 开始安装 NodePassDash (二进制部署) ---"
                echo -e "${YELLOW}正在执行官方二进制安装脚本...${NC}"
                echo -e "${BLUE}执行命令: curl -fsSL https://raw.githubusercontent.com/NodePassProject/NodePassDash/main/scripts/install.sh | bash${NC}"
                local script_temp_path="/tmp/nodepass_install.sh"
                curl -fsSL https://raw.githubusercontent.com/NodePassProject/NodePassDash/main/scripts/install.sh -o "$script_temp_path"
                if [ "$?" -ne 0 ]; then
                    echo -e "${RED}下载 NodePassDash 安装脚本失败！${NC}"
                    # 强制设置安装状态为失败，通知 prompt_after_install
                    install_status=1
                else
                    chmod +x "$script_temp_path"
                    bash "$script_temp_path"
                    # NodePassDash 官方脚本的退出状态将直接传递给 $?
                    install_status=$?
                fi
                # 注意：这里的 $? 要么是curl的退出状态（如果下载失败），要么是bash执行脚本的退出状态
                # 因此需要一个变量来捕获实际的安装状态
                # --- 二进制安装成功，尝试获取初始化信息 ---
                if [ "$install_status" -eq 0 ]; then
                    echo -e "\n${GREEN}✅ NodePassDash 二进制安装可能已成功。${NC}"
                    echo -e "${BLUE}正在尝试获取 NodePassDash 初始化信息和管理员密码...${NC}"
                    echo -e "${CYAN}请等待几秒钟确保服务启动和信息生成。${NC}"
                    # 等待服务启动和信息生成
                    # 尝试等待更长时间，并分多次尝试，以增加捕获成功率
                    local capture_attempts=5
                    local capture_interval=5 # 秒
                    local captured=0
                    for (( i=1; i<=$capture_attempts; i++ )); do
                        echo -e "${BLUE}  尝试捕获信息 (第 $i/$capture_attempts 次, 等待 ${capture_interval}s)...${NC}"
                        sleep "$capture_interval"
                        
                        # 使用 -n 1 来限制输出行数，并通过 grep -q 只检查是否存在，不输出
                        if journalctl -u nodepassdash --no-pager --since "5 minutes ago" | grep -q '系统初始化完成'; then
                            echo -e "${GREEN}✅ 已在日志中检测到 '系统初始化完成' 信息！${NC}"
                            journalctl -u nodepassdash | grep '系统初始化完成' -B 2 -A 6 | tail -n 9
                            captured=1
                            break # 成功捕获，退出循环
                        fi
                    done
                    if [ "$captured" -eq 0 ]; then
                        echo -e "${YELLOW}⚠️ 注意：未能自动捕获到 '系统初始化完成' 信息。您可能需要稍后手动执行：${NC}"
                        echo -e "${YELLOW}  ${CYAN}journalctl -u nodepassdash | grep -A 6 '系统初始化完成'${NC}"
                        echo -e "${YELLOW}或检查服务状态：${NC}"
                        echo -e "${YELLOW}  ${CYAN}sudo systemctl status nodepassdash${NC}"
                    fi
                else
                    echo -e "${RED}❌ NodePassDash 二进制安装失败。无法获取初始化信息。${NC}"
                fi
                
                # IMPORTANT: 使用 $install_status 变量来传递状态
                prompt_after_install "NodePassDash (二进制)" "官方脚本输出的管理员账号密码（已尝试自动捕获）" "$install_status"
                break # 完成子选项后返回主菜单
                ;;
            0)
                echo -e "${YELLOW}返回主菜单...${NC}"
                break # 返回主菜单
                ;;
            *)
                echo -e "${RED}无效的选择，请重新输入！${NC}"
                read -p "按回车键继续..."
                ;;
        esac
        echo "" # 子菜单选择后空行
    done
}

# --- 函数：realm 转发 ---
install_realm_forwarder() {
    echo -e "\n--- 开始执行 realm 转发脚本 ---"
    echo -e "${YELLOW}正在执行 realm 转发脚本...${NC}"
    echo -e "${BLUE}执行命令: curl -L https://github.com/Polaris-DP/realm/releases/download/v1.0.0/realm.sh -o realm.sh && chmod +x realm.sh && ./realm.sh${NC}"
    # 执行命令
    curl -L https://github.com/Polaris-DP/realm/releases/download/v1.0.0/realm.sh -o realm.sh && \
    chmod +x realm.sh && \
    ./realm.sh
    local install_status=$?
}

# --- 函数：获取本机IP地址 (用于显示给用户) ---
get_local_ip() {
    # 尝试多种方式获取IP，优先使用 ifconfig 或 ip addr
    # 如果系统没有这些，可能会回退到 curl ifconfig.me
    local ip=""
    if command -v ip &> /dev/null; then
        ip=$(ip addr show | grep -E 'inet\b' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
    elif command -v ifconfig &> /dev/null; then
        ip=$(ifconfig | grep -E 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)
    fi
    # 如果上述方法没找到，尝试通过外部服务获取外网IP
    if [[ -z "$ip" ]]; then
        echo -e "${YELLOW}⚠️ 无法直接获取本地IP，尝试获取外网IP...${NC}"
        ip=$(curl -s ifconfig.me)
    fi
    echo "$ip"
}
# --- 函数：安装 Komari 快速安装 ---
install_komari_quick() {
    echo -e "\n--- 开始 Komari 快速安装 ---"
    echo -e "${YELLOW}正在执行 Komari 快捷脚本...${NC}"
    echo -e "${BLUE}执行命令: curl -fsSL https://raw.githubusercontent.com/komari-monitor/komari/main/install-komari.sh -o install-komari.sh && chmod +x install-komari.sh && sudo ./install-komari.sh${NC}"
    local script_temp_path="/tmp/install-komari.sh"
    # 确保命令是按顺序执行并检查每一步的状态
    local install_status=0
    echo -e "${BLUE}1/3: 下载 install-komari.sh...${NC}"
    curl -fsSL https://raw.githubusercontent.com/komari-monitor/komari/main/install-komari.sh -o "$script_temp_path"
    if [ "$?" -ne 0 ]; then
        echo -e "${RED}下载 Komari 快捷脚本失败！${NC}"
        install_status=1
    fi
    if [ "$install_status" -eq 0 ]; then
        echo -e "${BLUE}2/3: 添加执行权限...${NC}"
        chmod +x "$script_temp_path"
        if [ "$?" -ne 0 ]; then
            echo -e "${RED}添加执行权限失败！${NC}"
            install_status=1
        fi
    fi
    if [ "$install_status" -eq 0 ]; then
        echo -e "${BLUE}3/3: 执行快捷脚本...${NC}"
        # 注意：这里使用 sudo，脚本可能会要求输入密码
        sudo "$script_temp_path"
        if [ "$?" -ne 0 ]; then
            echo -e "${RED}Komari 快捷安装脚本执行失败！${NC}"
            install_status=1
        fi
    fi
    # 在这里添加获取和显示账号密码的代码
    if [ "$install_status" -eq 0 ]; then
        echo -e "${YELLOW}🔑 正在尝试获取管理面板的初始账号和密码...${NC}"
        # 直接尝试读取日志，不等待，不循环，简单粗暴
        password_info=$(sudo journalctl -u komari --no-pager -n 500 2>/dev/null | grep -Ei 'Username:|Password:' | head -n 2)
        if [[ -n "$password_info" ]]; then
            echo -e "${GREEN}✅ 初始账号和密码信息如下:${NC}"
            echo -e "${CYAN}$password_info${NC}"
        else
            echo -e "${RED}❌ 未能自动获取到初始账号和密码。${NC}"
            echo -e "${YELLOW}请尝试手动执行以下命令获取：${NC}"
            echo -e "${CYAN}  sudo journalctl -u komari --no-pager -n 200 | grep -Ei 'Username|Password'${NC}"
        fi
    fi
}
# --- 函数：安装 Komari Docker 部署 ---
install_komari_docker() {
    echo -e "\n--- 开始 Komari Docker 部署 ---"
    echo -e "${YELLOW}正在执行 Komari Docker 部署...${NC}"
    # Check for Docker (modified logic)
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}!! 错误：Docker 命令未找到。请确保 Docker Engine 已安装 (选项 5) 并且当前用户已在 docker 用户组中（可能需要重新登录）。${NC}"
        prompt_after_install "Komari (Docker部署)" "" 1 # 直接标记失败并退出
        return
    else
        echo -e "${GREEN}✅ Docker 命令检查通过。${NC}"
    fi
    local install_status=0
    echo -e "${BLUE}1/3: 创建数据目录 './data'...${NC}"
    mkdir -p ./data
    if [ "$?" -ne 0 ]; then
        echo -e "${RED}创建数据目录失败！${NC}"
        install_status=1
    fi
    if [ "$install_status" -eq 0 ]; then
        echo -e "${BLUE}2/3: 运行 Docker 容器 'komari'...${NC}"
        docker run -d \
            -p 25774:25774 \
            -v "$(pwd)/data:/app/data" \
            --name komari \
            ghcr.io/komari-monitor/komari:latest
        if [ "$?" -ne 0 ]; then
            echo -e "${RED}运行 Komari Docker 容器失败！请检查端口是否被占用或镜像是否可访问。${NC}"
            install_status=1
        fi
    fi
    if [ "$install_status" -eq 0 ]; then
        echo -e "\n${GREEN}✅ Komari Docker 容器已启动。${NC}"
        echo -e "${BLUE}3/3: 获取默认账号和密码...${NC}"
        echo -e "${CYAN}请等待几秒钟确保服务启动，然后将显示默认密码...${NC}"
        sleep 10 # 等待容器完全启动
        docker logs --tail 20 komari
        if [ "$?" -ne 0 ]; then
            echo -e "${YELLOW}⚠️ 注意：未能直接读取 Komari 容器日志。您可能需要稍后手动执行 'docker logs komari' 查看默认账号和密码。${NC}"
        fi
        local local_ip=$(get_local_ip)
        if [[ -n "$local_ip" ]]; then
            echo -e "${GREEN}在浏览器中访问管理面板: ${CYAN}http://${local_ip}:25774${NC}"
        else
            echo -e "${GREEN}在浏览器中访问管理面板: ${CYAN}http://本机IP:25774${NC} (请将本机IP替换为您的服务器实际IP)${NC}"
        fi
        echo -e "${RED}请务必复制或记录上方输出的默认账号密码！${NC}"
    fi
    prompt_after_install "Komari (Docker部署)" "默认账号和密码，请查看 docker logs komari 输出" $install_status
}
# --- 函数：Komari 服务器监控子菜单及安装逻辑 ---
install_komari_monitor() {
    while true; do
        echo -e "\n${GREEN}===========================================${NC}"
        echo -e "${GREEN}   Komari 服务器监控 - 请选择部署方式 ${NC}"
        echo -e "${GREEN}===========================================${NC}"
        echo -e "${YELLOW}1. ${NC} 快速安装 (推荐初学者)"
        echo -e "${YELLOW}2. ${NC} Docker 部署 (推荐 Docker 用户)"
        echo -e "${YELLOW}0. ${NC} 返回主菜单"
        echo -e "${GREEN}===========================================${NC}"
        echo -n -e "${BLUE}请输入您的选择 (0-2): ${NC}"
        read -r sub_choice
        case "$sub_choice" in
            1)
                install_komari_quick
                break # 完成子选项后返回主菜单
                ;;
            2)
                install_komari_docker
                break # 完成子选项后返回主菜单
                ;;
            0)
                echo -e "${YELLOW}返回主菜单...${NC}"
                break # 返回主菜单
                ;;
            *)
                echo -e "${RED}无效的选择，请重新输入！${NC}"
                read -p "按回车键继续..."
                ;;
        esac
        echo "" # 子菜单选择后空行
    done
}

# --- 主逻辑 ---
main() {
    # 第一次运行脚本时显示菜单
    show_main_menu
    
    while true; do
        read -r choice

        case "$choice" in
            1) install_3x_ui ;;
            2) install_x_ui ;;
            3) install_s_ui ;;
            4) install_sublinkX ;;
            5) install_docker_engine ;;
            6) install_forward_panel ;;
            7) install_nodepass_dash ;;
            8) install_realm_forwarder ;;
            9) install_komari_monitor ;;
            0)
                echo -e "${YELLOW}感谢使用，再见！${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}无效的选择，请重新输入！${NC}"
                read -p "按回车键继续..."
                ;;
        esac
        
        # 为了更清晰地看到下一个菜单，在每次操作完成后重新显示菜单在最下方
        echo ""
        show_main_menu # 重新显示菜单
    done
}

# --- 脚本启动 ---
main
