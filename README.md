# my_vimrc
> 分享一下我在windos上的vim配置，用了很久的[exvim](https://github.com/exvim/main)，但是vim7.4缺乏异步特性，[spacevim](https://github.com/SpaceVim/SpaceVim)体验很不错，不过略显臃肿，最后还是自己折腾了一个
<!-- vim-markdown-toc GFM -->
- [插件](#插件)

<!-- vim-markdown-toc -->

# 插件

##  插件管理器
* [vim-plug](https://github.com/junegunn/vim-plug)

## 界面增强
* [papercolor-theme](https://github.com/blinkjum/papercolor-theme) fork自[papercolor-theme](https://github.com/NLKNguyen/papercolor-theme)，修改了部分配色
* [vim-airline](https://github.com/vim-airline/vim-airline)状态栏
* [indentLine](https://github.com/Yggdroot/indentLine)缩进提示

## 代码可读性增强
* [kien/rainbow_parentheses](https://github.com/kien/rainbow_parentheses) 彩虹括号
* [tagbar](https://github.com/majutsushi/tagbar) 我们都爱的tagbar
* [vim-preview](https://github.com/skywind3000/vim-preview) tag预览
* [vim-quickhl](https://github.com/t9md/vim-quickhl) 跨buff高亮工具
* [vim-cursorword](https://github.com/itchyny/vim-cursorword) 为当前光标下单词添加下划线，方便上下文阅读

## 文本编辑增强
* [vim-peekaboo](https://github.com/junegunn/vim-peekaboo) 预览vim寄存器内容
* [vim-surround](https://github.com/tpope/vim-surround) surround编辑
* [auto-pairs](https://github.com/jiangmiao/auto-pairs) 括号，引号自动补全
* [vim-xkbswitch](https://github.com/lyokha/vim-xkbswitch) 自动切换输入法
* [vim-visual-multi](https://github.com/mg979/vim-visual-multi)多行编辑
* [vim-textobj-argument](https://github.com/gaving/vim-textobj-argument)增强textobj操作支持
* [vim-mundo](https://github.com/simnalamburt/vim-mundo)undo增强
* [better-escape](https://github.com/jdhao/better-escape.vim)提升退出插入模式时的体验

## 移动和跳转增强
* [vim-easymotion](https://github.com/easymotion/vim-easymotion)easymotion
* [vim-choosewin](https://github.com/t9md/vim-choosewin)快速选择开打的窗格
* [vim-smartword](https://github.com/kana/vim-smartword)提升b和e的颗粒度，可以更快的在单词间移动

## 版本控制
* [vim-fugitive](https://github.com/tpope/vim-fugitive) 神器
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter)提供修改提示，可以快速在改动间跳转
* [agit](https://github.com/cohama/agit.vim)gitlog展示

## 补全
* [coc.nvim](https://github.com/neoclide/coc.nvim) 开箱即用
* [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe) c语言支持好

## 代码片段（snippets）
* [vim-snippets](https://github.com/honza/vim-snippets)
* [coc-snippets](https://github.com/neoclide/coc-snippets)

## 模糊查找插件(配合[ripgrep](https://github.com/BurntSushi/ripgrep)使用)
* [LeaderF](https://github.com/Yggdroot/LeaderF)太好用了

## 书签
* [vim-boomarks](https://github.com/MattesGroeger/vim-bookmarks)
* [vim-signature](https://github.com/kshenoy/vim-signature)

## 文件树
* [nerdtree](https://github.com/scrooloose/nerdtree)好用的文件树
* [a.vim](https://github.com/vim-scripts/a.vim) 快速切换到相关的头文件

## 注释
* [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
* [DoxygenToolkit](https://github.com/vim-scripts/DoxygenToolkit.vim)提供doxygen风格注释

## 语法高亮
* [taghighlight](https://github.com/abudden/taghighlight-automirror)
* [vim-polyglot](https://github.com/sheerun/vim-polyglot)

## 高亮
* [vim-quickhl](https://github.com/t9md/vim-quickhl)
* [vim-cursorword](https://github.com/itchyny/vim-cursorword)

## 帮助文档&速查表
* [vimwiki](https://github.com/vimwiki/vimwiki)
* [vimcdoc](https://github.com/yianwillis/vimcdoc)vimdoc翻译，不懂就看这个
* [mycheatsheet](https://github.com/blinkjum/mycheatsheet)自己的cheatsheet

## 任务管理
* [asyncrun](https://github.com/skywind3000/asyncrun.vim)
* [asynctasks](https://github.com/skywind3000/asynctasks.vim)

## 菜单 & 键绑定
* [vim-which-key](https://github.com/liuchengxu/vim-which-key)用过spacevim后发现space这个键确实不错
