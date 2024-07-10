#!/bin/bash

# 默认语言为英文
language="英文"

# 提示用户选择语言
echo "请选择语言:"
echo "1. 中文"
echo "2. 英文"
read -r choice

# 根据用户选择设置语言
if [ "$choice" = "1" ]; then
    language="中文"
elif [ "$choice" = "2" ]; then
    language="英文"
else
    echo "无效的语言选择,请重试。"
    exit 1
fi

# 根据语言设置提示信息
if [ "$language" = "中文" ]; then
    test_failed_msg="测试失败"
    test_passed_msg="测试通过"
else
    test_failed_msg="Test failed"
    test_passed_msg="Test passed"
fi

# 1. 向test_tmp.cpp中写入内容
echo "#pragma GCC optimize(2)" > test_tmp.cpp
echo "int main() { return 0; }" >> test_tmp.cpp

# 2. 执行g++ test_tmp.cpp -o test，如果有输出（报错或者警报），则停止脚本，输出测试失败文本
if g++ test_tmp.cpp -o test 2>&1 | grep -q "warning\|error"; then
    echo "$test_failed_msg"
    exit 1
fi

# 3. export ONLINE_JUDGE=1
export ONLINE_JUDGE=1

# 4. 执行g++ test_tmp.cpp -o test，相反地，如果没有输出（报错或者警报），则停止脚本，输出测试失败文本
if ! g++ test_tmp.cpp -o test 2>&1 | grep -q "warning\|error"; then
    echo "$test_failed_msg"
    exit 1
fi

# 5. 输出测试成功
echo "$test_passed_msg"