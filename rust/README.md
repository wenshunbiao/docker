# Change mirror

使用 rustup 安装 rust 时，若要启用 TUNA 源，执行：

$ # for bash
$ RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup rustup install stable # for stable
$ # for fish
$ env RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup rustup install stable # for stable
$ # for bash
$ RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup rustup install nightly # for nightly
$ # for fish
$ env RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup rustup install nightly # for nightly
$ # for bash
$ RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup rustup install nightly-2019-02-15 # for nightly since 2019.02.15
$ # for fish
$ env RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup rustup install nightly-2019-02-15 # for nightly since 2019.02.15
若要长期启用 TUNA 源，执行：

$ # for bash
$ echo 'export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup' >> ~/.bash_profile
$ # for fish
$ echo 'set -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup' >> ~/.config/fish/config.fish

# Rust up failed

    remove rust shell mirror value,do not use tuna.tsinghua.edu.cn

# Add Proxy /home/core/data/rust/cargo/config

[http]
proxy = "192.168.56.101:1080"

[https]
proxy = "192.168.56.101:1080"

[http]
proxy = "socks5://192.168.56.101:1080"

[https]
proxy = "socks5://192.168.56.101:1080"
