" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

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

set encoding=utf-8
set termencoding=utf-8  
set fileencoding=chinese 
set fileencodings=ucs-bom,utf-8,chinese 

set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

set nu


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










" --------------- <Leader> ------------------------------------------------
nnoremap gh :call HeaderToggle()<CR>

call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'abudden/taghighlight-automirror'
"Plug 'ycm-core/YouCompleteMe'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/LeaderF'
Plug 'Yggdroot/indentLine'
" Plug 'mhinz/vim-signify'
" Plug 'justinmk/vim-dirvish'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'Shougo/neocomplcache.vim'  
Plug 'liuchengxu/vim-which-key'
Plug 'vim-airline/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'wakatime/vim-wakatime'
call plug#end()

" ---------------- gitgutter -----------------------------------------
" let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'
set updatetime=100



" ---------------- nerdcommenter -----------------------------------------
"
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


" ---------------- youcompleteme ------------------------------------------
" set completeopt=menu,menuone
" let g:ycm_add_preview_to_completeopt = 0
" " 开启实时错误或者warning的检测
" "let g:ycm_show_diagnostics_ui = 0
" let g:ycm_server_log_level = 'info'
"
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" " 语法关键字补全
" let g:ycm_seed_identifiers_with_syntax=1
" " 补全功能在注释中同样有效
" let g:ycm_complete_in_strings=1
" " 从第二个键入字符就开始罗列匹配项
" let g:ycm_min_num_identifier_candidate_chars = 2
" let g:ycm_key_invoke_completion = '<c-z>'
" noremap <c-z> <NOP>
" let g:ycm_semantic_triggers =  {
"             \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"             \ 'cs,lua,javascript': ['re!\w{2}'],
"             \ }
" "ycm白名单
" let g:ycm_filetype_whitelist = {
"             \'c' : 1,
"             \'cpp' : 1,
"             \'python' : 1,
"             \'sh':1,
"             \}
 
" ---------------- ctags -------------------------------------------------
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
"let g:gutentags_ctags_tagfile = '.tags'
"let s:vim_tags = expand('~/.vim/cache/tags')
"let g:gutentags_cache_dir = s:vim_tags
"if !isdirectory(s:vim_tags)
"   silent! call mkdir(s:vim_tags, 'p')
"endif
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" ---------------- color scheme ------------------------------------------
syntax enable
colorscheme molokai
set guifont=Ubuntu\ Mono:h14


" ---------------- airline -----------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1


" ---------------- echodoc -----------------------------------------------
set noshowmode
"let g:echodoc_enable_at_startup = 1

" ---------------- LeaderF -----------------------------------------------
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
noremap <c-n> :LeaderfFunction!<cr>
" noremap <c-m> :LeaderfRgRecall<cr>
"全局搜索
noremap <c-f> :<C-U><C-R>=printf("Leaderf! rg --stayOpen -e %s ", expand("<cword>"))<CR>


" --------------- signify ------------------------------------------------
" let g:signify_disable_by_default = 1
" noremap <m-g> :SignifyToggle<cr>
" noremap <m-d> :SignifyDiff<cr>


" --------------- easymotion------------------------------------------------
"easymotion 特殊映射，其他不变
map E <Plug>(easymotion-e)
map B <Plug>(easymotion-b)

" --------------- nerdtree ------------------------------------------------
map <F3> :NERDTreeToggle<CR>


" ---------------------ctags设置----------------------------
"更新tags
map tt :!ctags -R *<cr><cr>
"更新tag着色文件
map tup :UpdateTypesFile<cr>


" ---------------------tagbar设置----------------------------
map tl :TagbarToggle<CR>


" ---------------------neocomplcache设置----------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" ---------------- vim-vim-which-key --------------------------------------
" By default timeoutlen is 1000 ms
set timeoutlen=500

let g:which_key_map =  {}

" `name` 是一个特殊字段，如果 dict 里面的元素也是一个 dict，那么表明一个 group，比如 `+file`, 就会高亮和显示 `+file` 。默认是 `+prefix`.

" =======================================================
" 基于已经存在的快捷键映射，直接使用一个字符串说明介绍信息即可
" =======================================================
" You can pass a descriptive text to an existing mapping.

" let g:which_key_map.c = { 'name' : '+commenter' }

" nnoremap <silent> <Space>cc <Leader>cc
" let g:which_key_map.c.c = '注释当前行和选中行'
"
" nnoremap <silent> <Space>ci <Leader>ci
" let g:which_key_map.c.i = '反转注释'


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

let g:which_key_map.l = {
      \ 'name' : '+lsp'                                            ,
      \ 'f' : ['LanguageClient#textDocument_formatting()'     , 'formatting']       ,
      \ 'h' : ['LanguageClient#textDocument_hover()'          , 'hover']            ,
      \ 'r' : ['LanguageClient#textDocument_references()'     , 'references']       ,
      \ 'R' : ['LanguageClient#textDocument_rename()'         , 'rename']           ,
      \ 's' : ['LanguageClient#textDocument_documentSymbol()' , 'document-symbol']  ,
      \ 'S' : ['LanguageClient#workspace_symbol()'            , 'workspace-symbol'] ,
      \ 'g' : {
        \ 'name': '+goto',
        \ 'd' : ['LanguageClient#textDocument_definition()'     , 'definition']       ,
        \ 't' : ['LanguageClient#textDocument_typeDefinition()' , 'type-definition']  ,
        \ 'i' : ['LanguageClient#textDocument_implementation()'  , 'implementation']  ,
        \ },
      \ }


call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <Space> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <Space> :<c-u>WhichKeyVisual '<Space>'<CR>












" --------------- <keymap> ------------------------------------------------

 " 搜索模式里忽略大小写
 set ignorecase 
 " 禁止自动换行
 set nowrap
 "设置相对行号
 set relativenumber
 "设置行号颜色
 highlight LineNr guifg=#A4D3EE
 "设置行号背景色
 highlight LineNr guibg=black
 "突出显示当前行
 set cursorline 

 "用tab和shift+tab来切换标签页
 nmap <tab>   :bn<cr>
 nmap <s-tab> :bp<cr>

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

 "分割窗口并在新窗口中传向定义
 map gl :call MyMarkWord()<cr>gd:call MySetPos()<cr> 
 "分割窗口并在当前窗口中传向定义
 map gk :call MyMarkWordCur()<cr>

 "修改S为把当前词替换成之前复制的内容
 map S viw"0p
 "系统复制粘贴
 map <unique> <leader>y "*y
 map <unique> <leader>p "*p
 map <unique> <leader>P "*P
