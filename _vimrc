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

function! HeaderToggle()
let file_path = expand("%")
let file_name = expand("%<")
let extension = split(file_path, '\.')[-1]
let err_msg = "Can't find file: "

if (extension == "c") || (extension == "cpp")
    let header_file = join([file_name, ".h"], "")
    if filereadable(header_file)
    :vs %<.h
    else
        echo join([err_msg, header_file], "")
    endif
elseif extension == "h"
    let c_file = join([file_name, ".c"], "")
    let cpp_file = join([file_name, ".cpp"], "")
    let next_file = join([file_name, ".c/.cpp"], "")
    if filereadable(c_file)
        :vs %<.c
    elseif filereadable(cpp_file)
		:vs %<.cpp
	else
        echo join([err_msg, next_file], "")
    endif
endif
endfunction

set signcolumn=yes

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

syntax on
set nobackup
set noundofile
set noswapfile
set nowritebackup

set encoding=utf-8
set termencoding=utf-8  
set fileencoding=chinese 
set fileencodings=ucs-bom,utf-8,chinese 

set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

set nu

" In Visual Block Mode, cursor can be positioned where there is no actual character
set ve=block

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

function! MySavePos()
  let g:g_save_cursor = getpos(".")
endfunction

function! MySetPos()
    call setpos('.', g:g_save_cursor)
endfunction

function! MyMarkWord()
  let cword=expand('<cword>')
  call MySavePos()
  let cmd='vertical botright ptag! '.cword.'| vertical res 80|let g:g_gonext_flag="ptn"'
  "echo cmd
  silent exe cmd
endfunction

function! MyMarkWordCur()
    let cword=expand('<cword>')
    let cmd='ta! '.cword.'| let g:g_gonext_flag="tn"'
    "echo cmd
    silent exe cmd
endfunction


" --------------- <plugged> ------------------------------------------------

call plug#begin('~/.vim/plugged')
Plug 'blinkjum/MyMolokai'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'
Plug 'abudden/taghighlight-automirror'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'justinmk/vim-syntax-extra'
" Plug 'vim-scripts/taghighlight'
Plug 'vim-scripts/a.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/LeaderF'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vim-which-key'
Plug 'vim-airline/vim-airline'
Plug 'mg979/vim-visual-multi'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
" Plug 'plasticboy/vim-markdown'
" Plug 'mzlogin/vim-markdown-toc'
" Plug 'iamcco/markdown-preview.nvim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'neoclide/coc.nvim'
Plug 'jceb/vim-orgmode'
call plug#end()
" ------------------------------------------------------------------ 
" Desc: gitgutter 
" ------------------------------------------------------------------ 
let g:gitgutter_map_keys = 0
set updatetime=800
" let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'


" ------------------------------------------------------------------ 
" Desc: vim-cpp-enhanced-highlight
" ------------------------------------------------------------------ 
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
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
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
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
" Desc: bookmark
" ------------------------------------------------------------------
let g:bookmark_sign = '🐎'
" let g:bookmark_no_default_key_mappings = 1
" ------------------------------------------------------------------ 
" Desc: color scheme 
" ------------------------------------------------------------------ 
syntax enable
colorscheme molokai
set guifont=Ubuntu\ Mono:h14


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
  function! AirlineInit()
    " let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_c = airline#section#create_left(['%f%m%r%h%w|[ASCII=%02.4B]'])
    " let g:airline_section_c = airline#section#create(['%{getcwd()}'])
  endfunction
  autocmd User AirlineAfterInit call AirlineInit()



" ------------------------------------------------------------------ 
" Desc: echodoc 
" ------------------------------------------------------------------ 
set noshowmode
"let g:echodoc_enable_at_startup = 1


" ------------------------------------------------------------------ 
" Desc: LeaderF 
" ------------------------------------------------------------------ 
let g:Lf_PreviewInPopup = 1
"指定 popup window / floating window 的位置
let g:Lf_PreviewHorizontalPosition = 'center'
"指定 popup window / floating window 的宽度。
let g:Lf_PreviewPopupWidth = 0

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')

let g:Lf_ShortcutF = '<leader>f'
" noremap <c-n> :LeaderfFunction!<cr>
" noremap <c-m> :LeaderfRgRecall<cr>
"全局搜索
noremap <c-f> :<C-U><C-R>=printf("Leaderf! rg --stayOpen -e %s ", expand("<cword>"))<CR>


" ------------------------------------------------------------------ 
" Desc: easymotion 
" ------------------------------------------------------------------ 
"easymotion 特殊映射，其他不变
map E <Plug>(easymotion-e)
map B <Plug>(easymotion-b)


" ------------------------------------------------------------------ 
" Desc: nerdtree 
" ------------------------------------------------------------------ 
map <F3> :NERDTreeToggle<CR>


" ------------------------------------------------------------------ 
" Desc: ctags设置 
" ------------------------------------------------------------------ 
"更新tags
map tt :!ctags -R *<cr><cr>
"更新tag着色文件
map tup :UpdateTypesFile<cr>


" ------------------------------------------------------------------ 
" Desc: tagbar设置 
" ------------------------------------------------------------------ 
map tl :TagbarToggle<CR>


" ------------------------------------------------------------------ 
" Desc: vim-markdown设置 
" ------------------------------------------------------------------ 
let g:vim_markdown_math = 1


" ------------------------------------------------------------------ 
" Desc: vim-markdown-toc设置 
" ------------------------------------------------------------------ 


" ------------------------------------------------------------------ 
" Desc: markdown-preview.nvim设置 
" ------------------------------------------------------------------ 
 let g:mkdp_path_to_chrome = "chrome"
"普通模式
nmap <silent> <F8> <Plug>MarkdownPreview        


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


" ------------------------------------------------------------------ 
" Desc: vim-vim-which-key设置 
" ------------------------------------------------------------------ 
" By default timeoutlen is 1000 ms
set timeoutlen=500
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
            \ }
nnoremap <silent> <Space>oq  :copen<CR>
nnoremap <silent> <Space>ol  :lopen<CR>
let g:which_key_map.o = {
            \ 'name' : '+open',
            \ 'q' : 'open-quickfix'    ,
            \ 'l' : 'open-locationlist',
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
            \ }
let g:which_key_map.f = {
            \ 'name' : '+file' ,
            \ 'o' : ['NERDTreeFind'  , 'open-file-tree']   ,
            \ 'a' : [':A'            , 'switch to .H']   ,
            \ 's' : [':AS'           , 'splits and switch']   ,
            \ 'v' : [':AV'           , 'vertiacl splits and switch']   ,
            \ }
let g:which_key_map.l = {
            \ 'name' : '+LeaderF' ,
            \ 'f' : ['LeaderfFunction'  , 'search functions in current buffer']   ,
            \ 'b' : ['LeaderfBuffer'  , 'search buffers']   ,
            \ 't' : ['LeaderfTag'  , 'navigate tags']   ,
            \ }

nnoremap <silent> <Space>yy  "0p
nnoremap <silent> <Space>y%  "%p
nnoremap <silent> <Space>y/  "/p
nnoremap <silent> <Space>ya  :reg<cr>
let g:which_key_map.y = {
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
" Desc: <keymap> 
" ------------------------------------------------------------------ 

 " 搜索模式里忽略大小写
 set ignorecase 
 " 禁止自动换行
 set nowrap
 "设置相对行号
 set relativenumber
 "设置行号颜色
 highlight LineNr guifg=#A4D3EE
 "设置行号背景色
 highlight LineNr guibg=#1f1f1f
 "突出显示当前行
 set cursorline 
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

 "<C-d>向后删除一个字符
 inoremap <C-d> <c-o>s 
 "<C-h>向前删除一个字符
 inoremap <C-h> <BS>
 "<A-d>向后删除一个单词
 inoremap <A-d> <c-o>de
 "<C-w>向前删除一个单词
 inoremap <C-w> <c-o>db
 "<C-u>向前删除到句首
 inoremap <C-u> <c-o>d^
 "<C-k>向后删除到句尾
 inoremap <C-k> <c-o>d$

 " my widnows
 nmap wj <C-W>j
 nmap wl <C-W>l
 nmap wk <C-W>k
 nmap wh <C-W>h
 nmap wv <C-W>v
 nmap wc <C-W>c
 nmap wp :sp<cr>
 nmap ws :vertical res 50<cr>
 nmap w2 :vertical res 20<cr>
 nmap w3 :vertical res 30<cr>
 nmap wm :vertical res 100<cr>

 "快速翻页
 nnoremap J <C-F>
 nnoremap K <C-B>

 "移动到本行最尾
 nmap - $

 "映射*到gd
 map gd *
"在foo.c 和foo.h之间切换
 nnoremap gh :A<cr>

 "分割窗口并在新窗口中传向定义
 nnoremap gl :call MyMarkWord()<cr>gd:call MySetPos()<cr> 
 "分割窗口并在当前窗口中传向定义
 nnoremap gk :call MyMarkWordCur()<cr>

 "插入空行
 nnoremap <silent> [<Space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>
 nnoremap <silent> ]<Space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

 "选中最后复制的内容
 nnoremap <silent><expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

 "修改S为把当前词替换成之前复制的内容
 map S viw"0p
 "系统复制粘贴
 map <unique> <leader>y "*y
 map <unique> <leader>p "*p
 map <unique> <leader>P "*P

nnoremap gh :call HeaderToggle()<CR>

"gitgutter signcolumn color 
highlight GitGutterAdd    guifg=#009900 guibg=#1f1f1f ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 guibg=#1f1f1f ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 guibg=#1f1f1f ctermfg=1 ctermbg=0
