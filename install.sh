#!/bin/bash

echo "开始安装 Dockge..."

# 检查 git 是否安装
if ! command -v git &> /dev/null; then
    echo "错误：git 未安装，请先安装 git"
    exit 1
fi

# 检查 docker 是否安装
if ! command -v docker &> /dev/null; then
    echo "错误：docker 未安装，请先安装 docker"
    exit 1
fi

# 克隆或更新仓库
echo "正在检查 Dockge 仓库..."
if [ -d "tx-dockge" ]; then
    echo "仓库已存在，正在更新..."
    cd dockge || exit 1
    if ! git pull; then
        echo "错误：更新仓库失败"
        exit 1
    fi
    cd ..
else
    echo "正在克隆 Dockge 仓库..."
    if ! git clone https://github.com/Mrzqd/tx-dockge.git; then
        echo "错误：克隆仓库失败"
        exit 1
    fi
fi

# 进入目录
cd tx-dockge || exit 1

# 启动 docker 容器
docker compose up -d
# 等待几秒确保服务启动
sleep 3

# 检查容器状态
if ! docker ps | grep -q "tx-dockge"; then
    echo "错误：Dockge 服务启动失败"
    exit 1
fi

# 成功提示
echo "======================================================"
echo ""
echo "恭喜！Dockge 已成功安装并启动！"
echo "请点击右下角【打开浏览器】来访问 Dockge一键程序"
echo "详情请参考 README.md 文件"
