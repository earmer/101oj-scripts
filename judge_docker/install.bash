set -e
set -u
set -o pipefail

# Set the language
read -p "Choose language (1. English, 2. 中文): " lang_choice
case $lang_choice in
    1)
        lang="en"
        ;;
    2)
        lang="zh"
        ;;
    *)
        echo "Invalid choice. Defaulting to English."
        lang="en"
        ;;
esac

install_dependencies() {
    echo "$MSG_INSTALLING_DEPENDENCIES"
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        libgmp-dev \
        libmpfr-dev \
        libmpc-dev \
        flex \
        bison \
        git
}

install_gcc() {
    read -p "$MSG_EXECUTE_GCC_INSTALLATION" execute
    if [ "$execute" == "y" ]; then
        echo "$MSG_CLONING_GCC"
        mkdir -p /usr/src/gcc && \
        cd /usr/src/gcc
        rm -rf gcc930-oj
        git clone https://mirror.ghproxy.com/https://github.com/earmer/gcc930-oj.git
        echo "$MSG_CLONE_FINISHED"
        cd gcc930-oj
        ./contrib/download_prerequisites

        echo "$MSG_START_BUILDING"
        mkdir -p build && cd build
        ../configure --enable-languages=c,c++ --disable-multilib
        make -j$(nproc) && \
        make install
        echo "$MSG_BUILD_FINISHED"

        update-alternatives --install /usr/bin/gcc gcc /usr/local/bin/gcc 100 && \
        update-alternatives --install /usr/bin/g++ g++ /usr/local/bin/g++ 100
    fi
}

install_python() {
    read -p "$MSG_EXECUTE_PYTHON_INSTALLATION" execute
    if [ "$execute" == "y" ]; then
        echo "$MSG_INSTALLING_PYTHON"
        apt install -y python3
    fi
}

install_openjdk() {
    read -p "$MSG_EXECUTE_OPENJDK_INSTALLATION" execute
    if [ "$execute" == "y" ]; then
        echo "$MSG_INSTALLING_OPENJDK"
        apt install -y openjdk-17-jdk-headless
    fi
}

install_rust() {
    read -p "$MSG_EXECUTE_RUST_INSTALLATION" execute
    if [ "$execute" == "y" ]; then
        echo "$MSG_INSTALLING_RUST"
        apt install -y rustc
    fi
}

install_go() {
    read -p "$MSG_EXECUTE_GO_INSTALLATION" execute
    if [ "$execute" == "y" ]; then
        echo "$MSG_INSTALLING_GO"
        apt install -y golang
    fi
}

install_fpc() {
    read -p "$MSG_EXECUTE_FPC_INSTALLATION" execute
    if [ "$execute" == "y" ]; then
        echo "$MSG_INSTALLING_FPC"
        apt install -y fp-compiler
    fi
}

main() {
    install_dependencies
    install_gcc
    install_python
    install_openjdk
    install_rust
    install_go
    install_fpc
    echo "$MSG_FINISHED"
}

case $lang in
    en)
        export LANG=en_US.UTF-8
        MSG_INSTALLING_DEPENDENCIES="Installing/Renewing basic dependencies..."
        MSG_EXECUTE_GCC_INSTALLATION="Execute GCC 9.3.0 installation? (y/n) "
        MSG_CLONING_GCC="Cloning GCC 9.3.0 for Online Judge"
        MSG_CLONE_FINISHED="Clone Finished"
        MSG_START_BUILDING="Start Making... Take a cup of tea!"
        MSG_BUILD_FINISHED="Build Finished! If the error occurs, please check your system!"
        MSG_EXECUTE_PYTHON_INSTALLATION="Execute Python3.8 installation? (y/n) "
        MSG_INSTALLING_PYTHON="Installing Python3.8"
        MSG_EXECUTE_OPENJDK_INSTALLATION="Execute OpenJDK 17 installation? (y/n) "
        MSG_INSTALLING_OPENJDK="Installing OpenJDK 17"
        MSG_EXECUTE_RUST_INSTALLATION="Execute Rust installation? (y/n) "
        MSG_INSTALLING_RUST="Installing Rust"
        MSG_EXECUTE_GO_INSTALLATION="Execute Go installation? (y/n) "
        MSG_INSTALLING_GO="Installing Go"
        MSG_EXECUTE_FPC_INSTALLATION="Execute FPC installation? (y/n) "
        MSG_INSTALLING_FPC="Installing FPC"
        MSG_FINISHED="Finished!"
        ;;
    zh)
        export LANG=zh_CN.UTF-8
        MSG_INSTALLING_DEPENDENCIES="正在安装/更新基本依赖..."
        MSG_EXECUTE_GCC_INSTALLATION="执行 GCC 9.3.0 安装? (y/n) "
        MSG_CLONING_GCC="正在克隆 GCC 9.3.0 用于在线评测"
        MSG_CLONE_FINISHED="克隆完成"
        MSG_START_BUILDING="开始编译... 泡一杯茶吧!"
        MSG_BUILD_FINISHED="编译完成! 如果出错,请检查您的系统!"
        MSG_EXECUTE_PYTHON_INSTALLATION="执行 Python3.8 安装? (y/n) "
        MSG_INSTALLING_PYTHON="正在安装 Python3.8"
        MSG_EXECUTE_OPENJDK_INSTALLATION="执行 OpenJDK 17 安装? (y/n) "
        MSG_INSTALLING_OPENJDK="正在安装 OpenJDK 17"
        MSG_EXECUTE_RUST_INSTALLATION="执行 Rust 安装? (y/n) "
        MSG_INSTALLING_RUST="正在安装 Rust"
        MSG_EXECUTE_GO_INSTALLATION="执行 Go 安装? (y/n) "
        MSG_INSTALLING_GO="正在安装 Go"
        MSG_EXECUTE_FPC_INSTALLATION="执行 FPC 安装? (y/n) "
        MSG_INSTALLING_FPC="正在安装 FPC"
        MSG_FINISHED="安装完成!"
        ;;
esac

main