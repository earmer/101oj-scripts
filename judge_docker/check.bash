#!/bin/bash

# Function to print message based on language
print_message() {
  local message_en="$1"
  local message_zh="$2"

  case "$LANG" in
    en)
      echo "$message_en"
      ;;
    zh)
      echo "$message_zh"
      ;;
    *)
      echo "$message_en"
      ;;
  esac
}

# Function to prompt user for language selection
select_language() {
  local options=("English" "中文")
  local PS3="Please select a language: "

  select opt in "${options[@]}"; do
    case $opt in
      "English")
        LANG="en"
        break
        ;;
      "中文")
        LANG="zh"
        break
        ;;
      *)
        print_message "Invalid option. Please try again." "无效选项,请重试."
        ;;
    esac
  done
}

# Prompt user for language selection
select_language

# Check for GCC version
if gcc --version >/dev/null 2>&1; then
  print_message "GCC version: $(gcc --version | head -n1)" "GCC 版本: $(gcc --version | head -n1)"
else
  print_message "GCC not installed" "GCC 未安装"
fi

# Check for Python3.8 version
if python3 --version >/dev/null 2>&1; then
  print_message "Python3 version: $(python3 --version | head -n1)" "Python3 版本: $(python3 --version | head -n1)"
  # Check for Numpy version
  if python3 -c "import numpy" >/dev/null 2>&1; then
    print_message "Numpy version: $(python3 -c 'import numpy; print(numpy.__version__)')" "Numpy 版本: $(python3 -c 'import numpy; print(numpy.__version__)')"
  else
    print_message "Numpy not installed" "Numpy 未安装"
  fi
else
  print_message "Python3 not installed" "Python3 未安装"
fi

# Check for Java version
if java -version >/dev/null 2>&1; then
  print_message "Java version: $(java -version 2>&1 | head -n1)" "Java 版本: $(java -version 2>&1 | head -n1)"
else
  print_message "Java not installed" "Java 未安装"
fi

# Check for Rust version
if rustc --version >/dev/null 2>&1; then
  print_message "Rust version: $(rustc --version | head -n1)" "Rust 版本: $(rustc --version | head -n1)"
else
  print_message "Rust not installed" "Rust 未安装"
fi

# Check for Go version
if go version >/dev/null 2>&1; then
  print_message "Go version: $(go version | head -n1)" "Go 版本: $(go version | head -n1)"
else
  print_message "Go not installed" "Go 未安装"
fi

# Check for Free Pascal Compiler version
if fpc -h >/dev/null 2>&1; then
  print_message "Free Pascal Compiler version: $(fpc -h | head -n1)" "Free Pascal 编译器版本: $(fpc -h | head -n1)"
else
  print_message "Free Pascal Compiler not installed" "Free Pascal 编译器未安装"
fi

# Check for Sandbox version
if sandbox -version >/dev/null 2>&1; then
  print_message "Sandbox version: $(sandbox -version | head -n1)" "沙箱版本: $(sandbox -version | head -n1)"
else
  print_message "Sandbox not installed" "沙箱未安装"
fi

# Check for Sandbox version
if curl "http://127.0.0.1:5050/version" >/dev/null 2>&1; then
  print_message "Sandbox version: $(curl "http://127.0.0.1:5050/version" | head -n1)" "沙箱版本: $(curl "http://127.0.0.1:5050/version" | head -n1)"
else
  print_message "Sandbox service not launched succesfully" "沙箱服务未成功启动"
fi