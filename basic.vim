"---------------------------------------------------------------------------
"
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
" source $VIM/plugins/kaoriya/encode_japan.vim
" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
set mouse=a
if !(has('win32') || has('mac')) && has('multi_lang')
	if !exists('$LANG') || $LANG.'X' ==# 'X'
		if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
			language ctype ja_JP.eucJP
		endif
		if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
			language messages ja_JP.eucJP
		endif
	endif
endif

" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
	set termencoding=cp932
	set encoding=utf-8
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
	if &guioptions !~# "M"
		" vimrc_example.vimを読み込む時はguioptionsにMフラグをつけて、syntax on
		" やfiletype plugin onが引き起こすmenu.vimの読み込みを避ける。こうしない
		" とencに対応するメニューファイルが読み込まれてしまい、これの後で読み込
		" まれる.vimrcでencが設定された場合にその設定が反映されずメニューが文字
		" 化けてしまう。
		set guioptions+=M
		source $VIMRUNTIME/vimrc_example.vim
		set guioptions-=M
	else
		source $VIMRUNTIME/vimrc_example.vim
	endif
endif

"---------------------------------------------------------------------------

if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

set ambiwidth=double

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
"
set softtabstop=4
set shiftwidth=4
"--------------------------------------

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:\|\ ,extends:$,trail:_
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 印刷設定
set printfont=Consolas:h8:cSHIFTJIS

"---------------------------------------------------------------------------
" その他、見栄えに関する設定:

"Esc連打でハイライト解除：
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" ビープ音消し、フラッシュ警告消し
set visualbell t_vb=
"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
" バックアップファイルの出力先
set backupdir=~/.vim/tmp

" スワップファイルの出力先
set directory=~/.vim/tmp

" アンドゥーファイルの出力先
set undodir=~/.vim/tmp

" 開いてるファイルを外部プログラムから変更があった際自動リロード
set autoread

" 括弧の補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
set timeout timeoutlen=1000 ttimeoutlen=75

set cursorline
set clipboard=autoselect


"バイナリファイルの非印字可能文字を16進数で表示
set display=uhex

" インサートモードでもhjklで移動（Ctrl押すけどね）
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"--------------------------
"Jade
autocmd BufNewFile,BufRead *.jade  setf jade
autocmd BufNewFile,BufRead *.jade  set tabstop=2 shiftwidth=2 expandtab

"stylus
autocmd BufNewFile,BufRead *.styl  setf stylus
autocmd BufNewFile,BufRead *.styl  set tabstop=2 shiftwidth=2 expandtab

" vue
autocmd BufNewFile,BufRead *.vue set filetype=vue

"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"  (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
	" tagsファイルの重複防止
	set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
	let uname = system('uname')
	if uname =~? "linux"
		set term=builtin_linux
	elseif uname =~? "freebsd"
		set term=builtin_cons25
	elseif uname =~? "Darwin"
		set term=builtin_xterm
	else
		set term=builtin_xterm
	endif
	unlet uname
endif

" コンソール版色の設定
set t_Co=256

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	endif

	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!


" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" if_luaが有効ならneocompleteを使う
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'

if neobundle#is_installed('neocomplete')
	" neocomplete用設定
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_ignore_case = 1
	let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns._ = '\h\w*'
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
elseif neobundle#is_installed('neocomplcache')
	" neocomplcache用設定
	let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_enable_ignore_case = 1
	let g:neocomplcache_enable_smart_case = 1
	if !exists('g:neocomplcache_keyword_patterns')
		let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns._ = '\h\w*'
	let g:neocomplcache_enable_camel_case_completion = 1
	let g:neocomplcache_enable_underbar_completion = 1
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd ColorScheme * call ZenkakuSpace()
		autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
	augroup END
	call ZenkakuSpace()
endif


NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

NeoBundle 'fatih/vim-go'
" -------- vim-go
let g:go_fmt_command = "goimports"


call neobundle#end()
