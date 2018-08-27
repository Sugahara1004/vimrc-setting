"--------------------------------------------------------------------------
" neobundle
set nocompatible               " Be iMproved
filetype off                   " Required!

" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle "ctrlpvim/ctrlp.vim"
NeoBundle "tyru/caw.vim.git"
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'freeo/vim-kalisi'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ap/vim-css-color'
NeoBundle 'rking/ag.vim'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'w0rp/ale'
NeoBundle "slim-template/vim-slim"

if has('lua') " lua機能が有効になっている場合・・・・・・①
	"コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
	" スニペットの補完機能
	NeoBundle "Shougo/neosnippet"
	" スニペット集
	NeoBundle 'Shougo/neosnippet-snippets'
endif

if executable('ag')
	let g:ctrlp_use_caching=0
	let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif

call neobundle#end()

if neobundle#is_installed('neocomplete.vim')
	" Vim起動時にneocompleteを有効にする
	let g:neocomplete#enable_at_startup = 1
	" smartcase有効化.
	" 大文字が入力されるまで大文字小文字の区別を無視する
	let g:neocomplete#enable_smart_case = 1
	" 3文字以上の単語に対して補完を有効にする
	let g:neocomplete#min_keyword_length = 3
	" 区切り文字まで補完する
	let g:neocomplete#enable_auto_delimiter = 1
	" 1文字目の入力から補完のポップアップを表示
	let g:neocomplete#auto_completion_start_length = 1
	" 最初の候補を選択した状態にする
	let g:neocomplete#enable_auto_select = 1

	" バックスペースで補完のポップアップを閉じる
	inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
	" エンターキーで補完候補の確定.スニペットの展開もエンターキーで確定・・・・・・②
	imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
	" タブキーで補完候補の選択.
	" スニペット内のジャンプもタブキーでジャンプ・・・・・・③
	imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"	
endif

let OSTYPE = system('uname')

syntax enable
" themeカラー
colorscheme kalisi
set background=light


filetype plugin indent on

" エラーチェックのあれこれ
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '']

" タブの可視化
set list
set list listchars=tab:\|\  
hi SpecialKey ctermbg=NONE ctermfg=lightgray

" setting 
"文字コードをUFT-8に設定 
set fenc=utf-8 
" バックアップファイルを作らない 
set nobackup 
" スワップファイルを作らない 
set noswapfile 
" 編集中のファイルが変更されたら自動で読み直す 
set autoread 
" バッファが編集中でもその他のファイルを開けるように 
set hidden 
" 入力中のコマンドをステータスに表示する
set showcmd
"gitの変更箇所をすぐに反映させるためのやつ
set updatetime=250
"ヤンクしたものクリップボードに反映する
set clipboard+=unnamed
"カーソルを行頭，行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"BSで削除できるものを指定する
set backspace=indent,eol,start
" 行末にセミコロンを入れる
nnoremap ; A;<ESC>^



" 見た目系
" 行番号を表示
set number
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" 新しい行を開始したとき、新しい行のインデントを現在行と同じにする
set autoindent
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返さない
set nowrap
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Unit.vimの設定
let g:unite_enable_start_insert=1
"過去に開いたファイル一覧を表示
nnoremap <silent> <S-u> :<C-u>Unite buffer<CR>

"コメントアウト機能
nmap <C-K> <Plug>(caw:hatpos:toggle)
vmap <C-K> <Plug>(caw:hatpos:toggle)

"tree表示
map <C-n> :NERDTreeToggle<CR>

" grepした時に自動でプレフィックスを表示させる
augroup QuickFixCmd
	autocmd!
	autocmd QuickFixCmdPost *grep* cwindow
augroup END

" vimgrepを簡単にするもの 
" 使い方: Grep word file 
command! -nargs=* Vgrep call s:grep(<f-args>)
function! s:grep(word, file)
	execute 'vimgrep ' . a:word . ' **/*.' . a:file
endfunction

" ファイル内置換を簡単にするもの 
" 使い方: Grep word file 
command! -nargs=* Rep call s:rep(<f-args>)
function! s:rep(aRep, bRep)
	execute '%s/' . a:aRep . '/' . a:bRep . '/g'
endfunction

" 自動でコメントアウトされるのを防ぐ
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=r
	autocmd BufEnter * setlocal formatoptions-=o
augroup END

" 画面の大きさを変更しやすくする
nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap <C-l> <C-w>>
nnoremap <C-h> <C-w><

" 正規表現を書きやすくする
nnoremap /  /\v

" 移動を楽にする
nmap L $
vmap L $
nmap H ^
vmap H ^

" 閉じるのを自動でやる
inoremap ( ()<ESC>i
inoremap { {}<ESC>i
inoremap [ []<ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i

nnoremap O  o<ESC>k

