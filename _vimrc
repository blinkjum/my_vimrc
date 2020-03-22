" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

set nocompatible " Use Vim settings, rather then Vi settings (much better!). This must be first, because it changes other options as a side effect.
set tags+=./tags,./../tags,./**/tags,tags " which tags files CTRL-] will find
set hid " allow to change buffer without saving
set showfulltag " show tag with function protype.

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

set encoding=utf-8
set termencoding=utf-8
set fileencoding=chinese
set fileencodings=ucs-bom,utf-8,chinese


" --------------- <plugged> ------------------------------------------------
"使用 --startuptime 选项来查看vim启动时间 例如:vim --startuptime vim.log

call plug#begin('~/.vim/plugged')
"界面增强
Plug 't9md/vim-choosewin'
Plug 'blinkjum/papercolor-theme'
Plug 'vim-airline/vim-airline'
"代码可读性增强
Plug 'majutsushi/tagbar',{ 'on': ['TagbarToggle','TagbarOpenAutoClose'] }
Plug 'Yggdroot/indentLine'
Plug 'skywind3000/vim-preview',{ 'on': ['PreviewTag','PreviewSignature'] }
Plug 'abudden/taghighlight-automirror'
Plug 'sheerun/vim-polyglot'
Plug 't9md/vim-quickhl'
Plug 'itchyny/vim-cursorword' 
"文本编辑增强
"Plug 'Krasjet/auto.pairs'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi'
Plug 'lyokha/vim-xkbswitch'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'gaving/vim-textobj-argument'
"移动，跳转增强
Plug 'easymotion/vim-easymotion'
Plug 'kana/vim-smartword'
"版本控制
Plug 'cohama/agit.vim',{ 'on': ['Agit','AgitFile'] }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"补全
Plug 'neoclide/coc.nvim'
Plug 'honza/vim-snippets'
"搜索
Plug 'Yggdroot/LeaderF'
"书签增强
Plug 'MattesGroeger/vim-bookmarks'
Plug 'kshenoy/vim-signature'
"文件树
Plug 'vim-scripts/a.vim'
Plug 'scrooloose/nerdtree',{'on':['NERDTreeToggle','NERDTreeFind']}
"帮助文档速查表
Plug 'vimwiki/vimwiki'
Plug 'yianwillis/vimcdoc'
Plug 'blinkjum/mycheatsheet'
"任务管理
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'

"快捷键映射管理
Plug 'liuchengxu/vim-which-key'
"待定功能
"Plug 'plasticboy/vim-markdown'
"Plug 'mzlogin/vim-markdown-toc'
"Plug 'iamcco/markdown-preview.nvim'
"Plug 'skywind3000/vim-terminal-help'

call plug#end()



"##############################################################################
"# 界面增强
"##############################################################################

" ------------------------------------------------------------------
" Desc: choosewin设置
" ------------------------------------------------------------------
    " nmap wi <Plug>(choosewin)
    " use overlay feature
    let g:choosewin_overlay_enable = 1

    " workaround for the overlay font being broken on mutibyte buffer.
    let g:choosewin_overlay_clear_multibyte = 1

    " tmux-like overlay color
    let g:choosewin_color_overlay = {
                \ 'gui': ['DodgerBlue3', 'DodgerBlue3'],
                \ 'cterm': [25, 25]
                \ }
    let g:choosewin_color_overlay_current = {
                \ 'gui': ['firebrick1', 'firebrick1'],
                \ 'cterm': [124, 124]
                \ }

    let g:choosewin_blink_on_land      = 0 " don't blink at land
    let g:choosewin_statusline_replace = 0 " don't replace statusline
    let g:choosewin_tabline_replace    = 0 " don't replace tabline


" ------------------------------------------------------------------
" Desc: color scheme
" ------------------------------------------------------------------
    " syntax on
    syntax enable
    set background=dark
    colorscheme PaperColor
    set guifont=Ubuntu_Mono_Bold:h14
    " set guifont=Cascadia\ Mono\ PL:h12:w7
    " set guifont=Fira_Code:h12:w7
    " set guifont=InputMonoCompressed_Medium:h13:w7
    " set guifont=DejaVu_Sans_Mono:h12:w7:b


" ------------------------------------------------------------------
" Desc: airline
" ------------------------------------------------------------------
    let g:airline#extensions#tabline#enabled = 1
    "显示tabline序号
    " let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#branch#enabled = 0
    let g:airline#extensions#bookmark#enabled = 1
    " 关闭空白符检测
    let g:airline#extensions#whitespace#enabled=0
    "关闭coc语法错误检测提示
    let g:airline#extensions#coc#enabled = 0
    "关闭xkblayout提示
    let g:airline#extensions#xkblayout#enabled = 0
    "关闭单词计数
    let g:airline#extensions#wordcount#enabled = 0
    "关闭gitgutter hunks改动显示
    let g:airline#extensions#hunks#enabled = 0

    function! AirlineInit()
        " let g:airline_section_a = airline#section#create(['mode'])
        let g:airline_section_c = airline#section#create_left(['%f%m%r%h%w|0x%02.4B'])
        " let g:airline_section_c = airline#section#create(['%{getcwd()}'])
        let g:airline_section_z =  airline#section#create(['%l/%L %c'])
    endfunction
    autocmd User AirlineAfterInit call AirlineInit()

    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    "not use separators,
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.dirty=''

    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''
    " let g:airline_symbols.branch = ''
    " let g:airline_symbols.readonly = ''
    " let g:airline_symbols.linenr = '☰'
    " let g:airline_symbols.maxlinenr = ''
    " let g:airline_symbols.dirty='⚡'


"##############################################################################
"# 代码可读性增强
"##############################################################################

" ------------------------------------------------------------------
" Desc: ctags设置
" ------------------------------------------------------------------
    "更新tags
    "map tt :!ctags -R --c++-kinds=+p --fields=+ianS --extras=+q .<cr><cr>
    "更新tag着色文件
    "map tup :UpdateTypesFile<cr>


" ------------------------------------------------------------------
" Desc: tagbar设置
" ------------------------------------------------------------------
    "map tl :TagbarToggle<CR>
    "map tk :TagbarOpenAutoClose<CR>
    " let g:tagbar_autofocus = 1
    let g:tagbar_sort = 0


" ------------------------------------------------------------------
" Desc: vim-preview
" ------------------------------------------------------------------
    noremap gs :PreviewSignature!<cr>


" ------------------------------------------------------------------
" Desc: vim-quickhl设置
" ------------------------------------------------------------------
    nmap <Space>n <Plug>(quickhl-manual-this)
    xmap <Space>n <Plug>(quickhl-manual-this)
    nmap <Space>N <Plug>(quickhl-manual-reset)
    xmap <Space>N <Plug>(quickhl-manual-reset)


"##############################################################################
"# 文本编辑增强
"##############################################################################

" ------------------------------------------------------------------
" Desc: vim-xkbswitch 输入法自动切换插件
" ------------------------------------------------------------------
    "插件需要的支持文件后续要放在统一路径下管理
    let g:XkbSwitchLib = 'c:\Vim\support\libxkbswitch64.dll'


" ------------------------------------------------------------------
" Desc: nerdcommenter
" ------------------------------------------------------------------
    "1、 \cc 注释当前行和选中行
    "2、 \cn 没有发现和\cc有区别
    "3、 \c<空格> 如果被选区域有部分被注释，则对被选区域执行取消注释操作，其它情况执行反转注释操作
    "4、 \cm 对被选区域用一对注释符进行注释，前面的注释对每一行都会添加注释
    "5、 \ci 执行反转注释操作，选中区域注释部分取消注释，非注释部分添加注释
    "6、 \cs 添加性感的注释，代码开头介绍部分通常使用该注释
    "7、 \cy 添加注释，并复制被添加注释的部分
    "8、 \c$ 注释当前光标到改行结尾的内容
    "9、 \cA 跳转到该行结尾添加注释，并进入编辑模式
    "10、\ca 转换注释的方式，比如： /**/和//
    "11、\cl \cb 左对齐和左右对其，左右对其主要针对/**/
    "12、\cu 取消注释
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 0
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 0
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not
    let g:NERDToggleCheckAllLines = 1


" ------------------------------------------------------------------
" Desc: vim-textobj-argument
" ------------------------------------------------------------------
    "基本操作
    " c/d/v/y + ia                 改写/删除/选取/复制 函数参数
    " c/d/v/y + aa                 改写/删除/选取/复制 函数参数（包括逗号分隔）


"##############################################################################
"# 移动，跳转增强
"##############################################################################

" ------------------------------------------------------------------
" Desc: easymotion
" ------------------------------------------------------------------
    "easymotion 特殊映射，其他不变
    map E <Plug>(easymotion-e)
    map B <Plug>(easymotion-b)
    map F <Plug>(easymotion-s)
    map <silent> <Space>j  <Plug>(easymotion-j)
    map <silent> <Space>k  <Plug>(easymotion-k)
    " keep cursor column when JK motion
    let g:EasyMotion_startofline = 0


" ------------------------------------------------------------------
" Desc: smartword
" ------------------------------------------------------------------
    "移动增强
	map w  <Plug>(smartword-w)
	map b  <Plug>(smartword-b)
	map e  <Plug>(smartword-e)
	map ge  <Plug>(smartword-ge)


"##############################################################################
"# 版本控制
"##############################################################################

" ------------------------------------------------------------------
" Desc: gitgutter
" ------------------------------------------------------------------
    let g:gitgutter_map_keys = 0
    set updatetime=300
    " let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'
    let g:gitgutter_sign_added = '++'
    let g:gitgutter_sign_modified = '~~'
    let g:gitgutter_sign_removed = '--'
    let g:gitgutter_sign_removed_first_line = '^^'
    let g:gitgutter_sign_modified_removed = 'ww'
    "use floating window preview 
    let g:gitgutter_preview_win_floating = 1
    "gitgutter signcolumn color
    " highlight GitGutterAdd    guifg=#009900 guibg=#1f1f1f ctermfg=2 ctermbg=0
    " highlight GitGutterChange guifg=#bbbb00 guibg=#1f1f1f ctermfg=3 ctermbg=0
    " highlight GitGutterDelete guifg=#ff2222 guibg=#1f1f1f ctermfg=1 ctermbg=0


" ------------------------------------------------------------------
" Desc: fugitive
" ------------------------------------------------------------------
    hi diffRemoved     guifg=#ff2222 guibg=#1c1c1c ctermfg=1 ctermbg=0
    hi diffAdded       guifg=#009900 guibg=#1c1c1c ctermfg=1 ctermbg=0
    hi diffSubname     guifg=#ffff00 guibg=#1c1c1c ctermfg=1 ctermbg=0


"##############################################################################
"# 补全
"##############################################################################

" ------------------------------------------------------------------
" Desc: coc.nvim设置
" ------------------------------------------------------------------
    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    " nmap <silent> [g <Plug>(coc-diagnostic-prev)
    " nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    " nmap <silent> gd <Plug>(coc-definition)
    " nmap <silent> gy <Plug>(coc-type-definition)
    " nmap <silent> gi <Plug>(coc-implementation)
    " nmap <silent> gr <Plug>(coc-references)

    " " Highlight symbol under cursor on CursorHold
    " autocmd CursorHold * silent call CocActionAsync('highlight')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " -----------------------snippet-----------------------------------------
    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)
    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)
    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'
    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'
    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)

    " inoremap <silent><expr> <TAB>
    "             \ pumvisible() ? coc#_select_confirm() :
    "             \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    "             \ <SID>check_back_space() ? "\<TAB>" :
    "             \ coc#refresh()
    "
    " function! s:check_back_space() abort
    "     let col = col('.') - 1
    "     return !col || getline('.')[col - 1]  =~# '\s'
    " endfunction
    "
    " let g:coc_snippet_next = '<tab>'


"##############################################################################
"# 搜索
"##############################################################################

" ------------------------------------------------------------------
" Desc: LeaderF
" ------------------------------------------------------------------
    let g:Lf_PreviewInPopup = 1
    "指定 popup window / floating window 的位置
    let g:Lf_PreviewHorizontalPosition = 'center'
    "指定 popup window / floating window 的宽度。
    let g:Lf_PreviewPopupWidth = 0
    "not use separators,
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }

    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_CacheDirectory = expand('~/.vim/cache')

    let g:Lf_ShortcutF = '<leader>f'
    " noremap <c-n> :LeaderfFunction!<cr>
    " noremap <c-m> :LeaderfRgRecall<cr>
    "全局搜索 -E GBK 指定编码保证汉字搜索
    noremap <c-f> :<C-U><C-R>=printf("Leaderf rg --stayOpen -S -w -E GBK -e %s ", expand("<cword>"))<CR>


"##############################################################################
"# 书签增强
"##############################################################################

" ------------------------------------------------------------------
" Desc: bookmark
" ------------------------------------------------------------------
    let g:bookmark_sign = '🐎'
    let g:bookmark_no_default_key_mappings = 1


"##############################################################################
"# 文件树
"##############################################################################

" ------------------------------------------------------------------
" Desc: nerdtree
" ------------------------------------------------------------------
    map <F3> :NERDTreeToggle<CR>


"##############################################################################
"# 帮助文档速查表
"##############################################################################

" ------------------------------------------------------------------
" Desc: vimwiki
" ------------------------------------------------------------------
    hi VimwikiHeader1 guifg=#FF0000
    hi VimwikiHeader2 guifg=#00FF00
    hi VimwikiHeader3 guifg=#0000FF
    hi VimwikiHeader4 guifg=#FF00FF
    hi VimwikiHeader5 guifg=#00FFFF
    hi VimwikiHeader6 guifg=#FFFF00


"##############################################################################
"# 编译，自动任务
"##############################################################################

" ------------------------------------------------------------------
" Desc: asynrun 
" ------------------------------------------------------------------
  " 默认打开高度为8的quickfix窗口显示信息
  let g:asyncrun_open = 8
  "编码GBK
  let g:asyncrun_encs = 'gbk'


" ------------------------------------------------------------------
" Desc: asynctask 
" ------------------------------------------------------------------
  "F6 运行项目编译结果
  noremap <silent><f6> :AsyncTask project-run<cr>
  "F7 编译项目
  noremap <silent><f7> :AsyncTask project-build<cr>
  "F5 单文件运行
  noremap <silent><f5> :AsyncTask file-run<cr>
  "F9 单文件编译
  noremap <silent><f9> :AsyncTask file-build<cr>


"##############################################################################
"# 快捷键映射管理
"##############################################################################

" ------------------------------------------------------------------
" Desc: vim-which-key设置
" ------------------------------------------------------------------
    " By default timeoutlen is 1000 ms
    set timeoutlen=400
    let g:which_key_map =  {}

    " `name` 是一个特殊字段，如果 dict 里面的元素也是一个 dict，那么表明一个 group，比如 `+file`, 就会高亮和显示 `+file` 。默认是 `+prefix`.

    " =======================================================
    " 基于已经存在的快捷键映射，直接使用一个字符串说明介绍信息即可
    " =======================================================
    " You can pass a descriptive text to an existing mapping.
    let g:which_key_map.c = {
                \ 'name' : '+commenter',
                \ 'c' : ['<plug>NERDCommenterComment', '注释当前行和选中行'],
                \ 'i' : ['<plug>NERDCommenterInvert', '反转注释'],
                \ 'n' : ['<plug>NERDCommenterToggle', '智能注释'],
                \ 'A' : ['<plug>NERDCommenterAppend', '跳转到该行结尾添加注释，并进入编辑模式'],
                \ 'd' : [':Dox', 'Doxygen注释'],
                \ }

    let g:which_key_map.w = {
                \ 'name' : '+windows' ,
                \ 'd' : ['<C-W>c'      , '删除窗口']              ,
                \ 'h' : ['<C-W>30<'    , '窗口宽度微调']          ,
                \ 'j' : [':resize +8'  , '窗口高度微调']          ,
                \ 'k' : [':resize -8'  , '窗口高度微调']          ,
                \ 'l' : ['<C-W>30>'    , '窗口宽度微调']          ,
                \ 'H' : ['<C-W>H'      , '把当前窗口移动到最左']  ,
                \ 'J' : ['<C-W>J'      , '把当前窗口移动到最下']  ,
                \ 'L' : ['<C-W>L'      , '把当前窗口移动到最右']  ,
                \ 'K' : ['<C-W>k'      , '把当前窗口移动到最上']  ,
                \ '=' : ['<C-W>='      , '自动调整分屏']          ,
                \ 's' : ['<C-W>s'      , '水平分屏']              ,
                \ 'v' : ['<C-W>v'      , '竖直分屏']              ,
                \ 'c' : ['<Plug>(choosewin)', '选择窗口']         ,
                \ }

    " =======================================================
    " 不存在相关的快捷键映射，需要用一个 list：
    " 第一个元素表明执行的操作，第二个是该操作的介绍
    " =======================================================
    " Provide commands(ex-command, <Plug>/<C-W>/<C-d> mapping, etc.) and descriptions for existing mappings
    let g:which_key_map.b = {
                \ 'name' : '+buffer' ,
                \ 'd' : ['bd'        , 'delete-buffer']   ,
                \ 'f' : ['bfirst'    , 'first-buffer']    ,
                \ 'l' : ['blast'     , 'last-buffer']     ,
                \ 'n' : ['bnext'     , 'next-buffer']     ,
                \ 'p' : ['bprevious' , 'previous-buffer'] ,
                \ }

    let g:which_key_map.e = {
                \ 'name' : '+edit' ,
                \ 'l' : ['`.'        , 'last edited position']   ,
                \ }
    let g:which_key_map.g = {
                \ 'name' : '+git' ,
                \ 'g' : [':G'                              , 'GitStatus']  ,
                \ 'd' : [':Gdiffsplit'                     , 'Diffsplit']  ,
                \ 'b' : [':Gblame'                         , 'GitBlame']  ,
                \ 'j' : ['<Plug>(GitGutterNextHunk)'       , 'NextHunk']  ,
                \ 'k' : ['<Plug>(GitGutterPrevHunk)'       , 'PrevHunk']  ,
                \ 'h' : [':GitGutterLineHighlightsToggle'  , 'ToggleHighlightHug']  ,
                \ 'p' : ['<Plug>(GitGutterPreviewHunk)'    , 'PreviewHunk']         ,
                \ 's' : ['<Plug>(GitGutterStageHunk)'      , 'StageHunk']           ,
                \ 'u' : ['<Plug>(GitGutterUndoHunk)'       , 'UndoHunk']            ,
                \ 'w' : [':GitGutterSignsToggle'           , 'SignsToggle']         ,
                \ 'f' : [':GitGutterFold'                  , 'FoldUnchangedLines']         ,
                \ 'l' : [':Agit' , 'git log graph']   ,
                \ 'z' : [':!lazygit' , 'lazygit']   ,
                \ }
    let g:which_key_map.m = {
                \ 'name' : '+mark',
                \ 'm' : ['<Plug>BookmarkToggle', 'BookmarkToggle'],
                \ 'i' : ['<plug>BookmarkAnnotate', 'NERDCommenterInvert'],
                \ 'a' : ['<plug>BookmarkShowAll', 'BookmarkShowAll'],
                \ 'j' : ['<plug>BookmarkNext', 'BookmarkNext'],
                \ 'k' : ['<plug>BookmarkPrev', 'BookmarkPrev'],
                \ 'c' : ['<plug>BookmarkClear', 'BookmarkClear'],
                \ 'x' : ['<plug>BookmarkClearAll', 'BookmarkClearAll'],
                \ 'g' : ['<plug>BookmarkMoveToLine', 'BookmarkMoveToLine'],
                \ 's' : [':marks', 'show all marks'],
                \ 'r' : [':QuickhlManualReset', 'Reset highlight'],
                \ 't' : [':QuickhlManualLockWindowToggle', 'Toggle highlight window lock '],
                \ }
    let g:which_key_map.f = {
                \ 'name' : '+file' ,
                \ 'o' : ['NERDTreeFind'  , 'open-file-tree']   ,
                \ 'a' : [':A'            , 'switch to .H']   ,
                \ 's' : [':AS'           , 'splits and switch']   ,
                \ 'v' : [':AV'           , 'vertiacl splits and switch']   ,
                \ 'w' : [':set wrap'     , 'auto wrap']   ,
                \ 'r' : [':set relativenumber'     , 'use relativenumber']   ,
                \ }
    let g:which_key_map.l = {
                \ 'name' : '+LeaderF' ,
                \ 'f' : ['LeaderfFunction'  , 'search functions in current buffer']   ,
                \ 'b' : ['LeaderfBuffer'  , 'search buffers']   ,
                \ 't' : ['LeaderfTag'  , 'navigate tags']   ,
                \ 'l' : ['LeaderfLineAll'  , 'search a line in all listed buffers']   ,
                \ 'm' : ['LeaderfMruCwd'  , 'search Mru in current working directory']   ,
                \ }
    let g:which_key_map.h = {
                \ 'name' : '+help' ,
                \ 'l' : [':h local-additions'  , 'local plugin doc']   ,
                \ 'h' : [':h'  , 'vim help indix']   ,
                \ 'o' : [':h options'  , 'vim options ']   ,
                \ 'i' : [':h my_index'  , 'cheatsheet index ']   ,
                \ }
    let g:which_key_map.t = {
                \ 'name' : '+tag' ,
                \ 't' : [':!ctags -R --c++-kinds=+p --fields=+ianS --extras=+q .'  , 'Generate tag file'],
                \ 'u' : [':UpdateTypesFile'  , 'UpdateTypesFile'],
                \ 'l' : [':TagbarToggle'  , 'TagbarToggle'],
                \ 'k' : [':TagbarOpenAutoClose'  , 'TagbarOpenAutoClose'],
                \ }
    let g:which_key_map.q = {
                \ 'name' : '+quickfix' ,
                \ 'o' : [':copen'  , 'open quickfix window'],
                \ 'j' : [':cnext'  , 'next error'],
                \ 'k' : [':cprev'  , 'prev error '],
                \ 'l' : [':AsyncTaskList'  , 'show asynctask list '],
                \ 'e' : [':AsyncTaskEdit'  , 'show asynctask edit '],
                \ 'p' : [':AsyncTask project-build'  , 'use asynctask build project '],
                \ 'f' : [':AsyncTask file-build'  , 'use asynctask build file '],
                \ 'm' : [':AsyncTaskMacro'  , 'show asynctask macro '],
                \ }

    nnoremap <silent> <Space>ry  "0p
    nnoremap <silent> <Space>r%  "%p
    nnoremap <silent> <Space>r/  "/p
    nnoremap <silent> <Space>ra  :reg<cr>

    "映射1-9复制寄存器
    noremap <silent> <Space>1  "1
    noremap <silent> <Space>2  "2
    noremap <silent> <Space>3  "3

    let g:which_key_map.r = {
                \ 'name' : '+reg',
                \ 'y' : '复制专用寄存器',
                \ '%' : '当前文件名',
                \ '/' : '上次/查找的关键字',
                \ 'a' : '查看所有寄存器',
                \ }

    call which_key#register('<Space>', "g:which_key_map")
    nnoremap <silent> <Space> :<c-u>WhichKey '<Space>'<CR>
    vnoremap <silent> <Space> :<c-u>WhichKeyVisual '<Space>'<CR>



" ------------------------------------------------------------------
" Desc: my function
" ------------------------------------------------------------------
function! MySavePos()
  let g:g_save_cursor = getpos(".")
endfunction

function! MySetPos()
    call setpos('.', g:g_save_cursor)
endfunction

function! MyMarkWord()
  let cword=expand('<cword>')
  call MySavePos()
endfunction

function! MyMarkWordCur()
    let cword=expand('<cword>')
    let cmd='ta! '.cword.'| let g:g_gonext_flag="tn"'
    silent exe cmd
endfunction


" ------------------------------------------------------------------
" Desc: <keymap>
" ------------------------------------------------------------------

 set signcolumn=yes

 set guioptions+=!  "在终端窗口中执行外部命令
 set guioptions-=m  "remove menu bar
 set guioptions-=T  "remove toolbar
 set guioptions-=r  "remove right-hand scroll bar
 set guioptions-=L  "remove left-hand scroll bar

 set nobackup
 set noundofile
 set noswapfile
 set nowritebackup

 set smarttab
 set tabstop=4
 set shiftwidth=4
 set expandtab

 set nu

 set noshowmode

 " In Visual Block Mode, cursor can be positioned where there is no actual character
 set ve=block

 " For all text files set 'textwidth' to 78 characters.
 autocmd FileType text setlocal textwidth=78

 " smartcase模式进行搜索,如果输入中有大写则区分大小写,忽略ignorecase设置
 set ignorecase
 set smartcase
 " 禁止自动换行
 set nowrap
 "设置相对行号
 " set relativenumber
 "设置行号颜色
 " highlight LineNr guifg=#A4D3EE
 "设置行号背景色
 " highlight LineNr guibg=#1c1d1f
 "突出显示当前行
 " set cursorline
 "禁用自动调整窗口
 set noequalalways

 "用tab和shift+tab来切换标签页
 nmap <tab>   :bn<cr>
 nmap <s-tab> :bp<cr>

 "插入模式下快捷移动 emacs映射
 inoremap <C-b> <Left>
 inoremap <C-f> <Right>
 inoremap <C-n> <Down>
 inoremap <C-p> <Up>
 inoremap <A-b> <S-Left>
 inoremap <A-f> <S-Right>
 inoremap <C-a> <Home>
 inoremap <C-e> <End>

 "命令模式下快捷移动 emacs映射
 cnoremap <C-a> <Home>
 cnoremap <C-b> <Left>
 cnoremap <C-f> <Right>
 cnoremap <C-p> <Up>
 cnoremap <C-n> <Down>

 " "<C-d>向后删除一个字符
 " inoremap <C-d> <c-o>s
 " "<C-h>向前删除一个字符
 " inoremap <C-h> <BS>
 " "<A-d>向后删除一个单词
 " inoremap <A-d> <c-o>de
 " "<C-w>向前删除一个单词
 " inoremap <C-w> <c-o>db
 " "<C-u>向前删除到句首
 " inoremap <C-u> <c-o>d^
 " "<C-k>向后删除到句尾
 " inoremap <C-k> <c-o>d$

 " my widnows
 nmap wi <Plug>(choosewin)
 nmap wj <C-W>j
 nmap wl <C-W>l
 nmap wk <C-W>k
 nmap wh <C-W>h
 nmap wv <C-W>v
 nmap wb <C-W>vwl
 nmap wc <C-W>c
 nmap wp :sp<cr>
 nmap ws :vertical res 50<cr>
 nmap w2 :vertical res 20<cr>
 nmap w3 :vertical res 30<cr>
 nmap wn :vertical res 100<cr>
 nmap wm :vertical res 150<cr>

 "快速翻页
 noremap J <C-F>
 noremap K <C-B>


 " 智能 Home
 function! SmartHome()
     let str_before_cursor = strpart(getline('.'), 0, col('.') - 1)
     let wrap_prefix = &wrap ? 'g' : ''
     if str_before_cursor !~ '^\s*$'
         return wrap_prefix . '^ze'
     else
         return wrap_prefix . '0'
     endif
 endfunction
 noremap <expr> ^ SmartHome()
 sunmap ^
 noremap <expr> H SmartHome()
 sunmap H

 "智能 End
 nnoremap <expr> L &wrap ? 'g$' : '$'
 onoremap <expr> L &wrap ? 'g$' : '$'
 xnoremap <expr> L &wrap ? 'g$h' : '$h'

 "移动到本行最尾
 map - $

 "将t映射到%
 map t %

 "分割窗口并在新窗口中传向定义
 nnoremap <silent> gl :PreviewTag<cr>:call MyMarkWord()<cr>gd :call MySetPos()<cr>
 "分割窗口并在当前窗口中传向定义
 nnoremap <silent> gk :call MyMarkWordCur()<cr>

 "插入空行
 nnoremap <silent> [<Space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>
 nnoremap <silent> ]<Space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

 "选中最后复制的内容
 nnoremap <silent><expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

 "修改S为把当前词替换成之前复制的内容
 map S viw"0p

 "使用黑洞寄存器处理可视模式下的复制问题
 vnoremap p "_dP

 "系统复制粘贴
 map <unique> <leader>y "*y
 nnoremap <unique> <leader>p "*p
 nnoremap <unique> <leader>P "*P
 vnoremap <unique> <leader>p "_d"*P
 vnoremap <unique> <leader>P "_d"*P

"windows下显示增强
" set rop=type:directx,renmode:4

"高亮高亮多余的空白字符及 Tab
" highlight RedundantSpaces ctermbg=red guibg=red
" match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

 "快速退出插入模式
 imap jk <c-[>
