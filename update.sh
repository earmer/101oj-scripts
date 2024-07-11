#!/bin/bash
# Function to update a file
update_file() {
    local file_path=$1
    local url=$2
    if [ -f "$file_path" ]; then
        tmp_file="${file_path}.tmp"
        wget "$url" -O "$tmp_file" && mv "$tmp_file" "$file_path"
    else
        wget "$url" -O "$file_path"
    fi
}
# Update check.bash
update_file "./judge_docker/check.bash" "https://mirror.ghproxy.com/https://github.com/earmer/101oj-scripts/raw/main/judge_docker/check.bash"
# Update install.bash
update_file "./judge_docker/install.bash" "https://mirror.ghproxy.com/https://github.com/earmer/101oj-scripts/raw/main/judge_docker/install.bash"
# Update checkgcc.bash
update_file "./judge_docker/checkgcc.bash" "https://mirror.ghproxy.com/https://github.com/earmer/101oj-scripts/raw/main/judge_docker/checkgcc.bash"
# Update cleanup.bash
update_file "./judge_docker/cleanup.bash" "https://mirror.ghproxy.com/https://github.com/earmer/101oj-scripts/raw/main/judge_docker/cleanup.bash"
