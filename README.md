# zsh 配置安装说明

本仓库仅包含 `.zshrc` 配置文件。插件不包含在仓库中，请手动安装以获得最新版。

---

## 1. 安装 zsh 和 oh-my-zsh

```bash
# Ubuntu
sudo apt install zsh
chsh -s $(which zsh)

# 安装 oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
````

---

## 2. 安装 fzf（模糊查找工具）

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

---

## 3. 安装插件（建议手动 clone 到 oh-my-zsh 插件目录）

```bash
# 自动建议
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# 语法高亮
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Vim 模式
git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/custom/plugins/zsh-vi-mode

# 历史命令模糊搜索
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/history-substring-search
```

---

## 4. 下载并使用本仓库中的 .zshrc

```bash
curl -o ~/.zshrc https://raw.githubusercontent.com/unclefish7/dotfiles/main/.zshrc
source ~/.zshrc
```

---

## 5. 常用快捷键与功能

* Vim 模式（按 `Esc` 进入 normal，`i`/`a`/`A` 等进入 insert）
* 自动建议（zsh-autosuggestions）
* 命令语法高亮（zsh-syntax-highlighting）
* 历史命令模糊搜索（history-substring-search，↑↓ 支持前缀搜索）
* fzf 快捷键支持：

  * `Ctrl+R`：历史命令搜索
  * `Ctrl+T`：路径补全
  * `Alt+C`：目录跳转（终端需支持 Meta 键）

---

## 6. 插件更新（可选）

```bash
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-vi-mode && git pull
cd ~/.oh-my-zsh/custom/plugins/history-substring-search && git pull
```