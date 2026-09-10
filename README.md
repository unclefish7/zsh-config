# Shell / CLI 配置安装说明

本仓库包含 `.zshrc`、`.vimrc` 和用于远程 Vim 复制的 `bin/osc52copy`。Oh My Zsh 插件不包含在仓库中，请手动安装以获得最新版。

## 1. 安装 zsh 和 Oh My Zsh

```bash
# Ubuntu
sudo apt install zsh vim
chsh -s "$(which zsh)"

# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 2. 安装 fzf

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## 3. 安装 Oh My Zsh 插件

```bash
# 自动建议
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# 语法高亮
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# 历史命令模糊搜索
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/history-substring-search
```

## 4. 安装 zsh 配置

在仓库根目录执行：

```bash
cp .zshrc ~/.zshrc
source ~/.zshrc
```

不 clone 仓库时，可直接下载：

```bash
curl -fL -o ~/.zshrc https://raw.githubusercontent.com/unclefish7/zsh-config/main/.zshrc
source ~/.zshrc
```

命令行保持 zsh 默认的 Emacs keymap，不启用 `zsh-vi-mode` 或 `bindkey -v`。简单编辑可使用 `Ctrl+A`、`Ctrl+E`、`Alt+B` 和 `Alt+F`；复杂命令可用 `Ctrl+X Ctrl+E` 交给 `$EDITOR` 编辑。若希望它始终使用 Vim，请在自己的 shell 环境中设置：

```zsh
export EDITOR=vim
export VISUAL=vim
```

## 5. 安装 Vim 与 OSC 52 复制

在仓库根目录执行：

```bash
cp .vimrc ~/.vimrc
mkdir -p ~/.local/bin
cp bin/osc52copy ~/.local/bin/osc52copy
chmod +x ~/.local/bin/osc52copy
```

不 clone 仓库时，可直接下载这两个文件：

```bash
curl -fL -o ~/.vimrc https://raw.githubusercontent.com/unclefish7/zsh-config/main/.vimrc
mkdir -p ~/.local/bin
curl -fL -o ~/.local/bin/osc52copy https://raw.githubusercontent.com/unclefish7/zsh-config/main/bin/osc52copy
chmod +x ~/.local/bin/osc52copy
```

`.vimrc` 不依赖插件管理器，提供行号、相对行号、基础缩进、语法高亮和搜索高亮。它通过 Vim 的 `TextYankPost` 事件监听普通 yank：Vim 先照常写入 register，再把 `v:event.regcontents` 经 stdin 传给 helper。helper 将内容 base64 编码后输出 OSC 52 到 `/dev/tty`；SSH 会将该终端序列传回 iTerm2，由 iTerm2 写入 macOS 剪贴板。因此不需要 X11、xclip、xsel 或远程 GUI 剪贴板。

按行 yank 会依据 `v:event.regtype` 补回末尾换行，例如 `V`、`j`、`j`、`y`。helper 缺失、无执行权限或终端拒绝 OSC 52 时，Vim 的本地 yank/register 不受影响。

### iTerm2 设置

在 iTerm2 Settings 中搜索 `clipboard` 或 `OSC 52`，允许 **Applications in terminal may access clipboard**（不同版本的菜单文字或位置可能略有不同）。

### 测试 OSC 52

先在远程 SSH shell 中运行：

```bash
printf '\033]52;c;%s\a' "$(printf 'hello-from-ubuntu' | base64 | tr -d '\n')"
```

切换到 macOS 的其他应用并按 `Command+V`，应得到 `hello-from-ubuntu`。

然后测试 Vim：

```bash
vim test.txt
```

在 Vim 中执行 `yy`，或进入行选择后按 `V`、`j`、`j`、`y`。再到 macOS 的其他应用按 `Command+V`，应能粘贴刚刚 yank 的内容。

OSC 52 的可复制大小取决于 iTerm2、SSH 链路及中间终端复用器；它适合文本片段，不适合非常大的内容。若使用 tmux/screen，可能还需要启用其 OSC 52 passthrough。

## 6. Vim 常用快捷键

| 类别 | 快捷键 | 作用 |
| --- | --- | --- |
| 浏览 | `Ctrl+f` / `Ctrl+b` | 下一页 / 上一页 |
| 浏览 | `Ctrl+d` / `Ctrl+u` | 下半页 / 上半页 |
| 浏览 | `gg` / `G` | 文件头 / 文件尾 |
| 定位 | `0` / `^` / `$` | 行首 / 第一个非空字符 / 行尾 |
| 定位 | `w` / `b` | 单词移动 |
| 定位 | `/text`、`n` / `N` | 搜索、下一个 / 上一个结果 |
| 定位 | `f<char>` | 当前行查找字符 |
| 编辑 | `dd` / `yy` / `p` / `P` | 剪切行 / yank 行 / 后粘贴 / 前粘贴 |
| 编辑 | `ciw` / `D` | 修改当前单词 / 删除到行尾 |
| 编辑 | `u` / `Ctrl+r` | undo / redo |
| 选择 | `v` / `V` / `Ctrl+v` | 字符 / 行 / block 选择 |
| 保存 | `:w` / `:q` / `:wq` / `:q!` | 保存 / 退出 / 保存退出 / 强制退出 |

## 7. 插件更新（可选）

```bash
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
cd ~/.oh-my-zsh/custom/plugins/history-substring-search && git pull
```
