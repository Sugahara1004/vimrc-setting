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

if has('lua') " lua機能が有効になっている場合・・・・・・①
	"コードの自動補完
	NeoBundle 'Shougo/neocomplete.vim'
	" スニペットの補完機能
	NeoBundle "Shougo/neosnippet"
	" スニペット集
	NeoBundle 'Shougo/neosnippet-snippets'
endif

call neobundle#end()



filetype plugin indent on

highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 補完ウィンドウの設定
set completeopt=menuone

" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
let g:rsenseHome = '/usr/local/lib/rsense-0.3'

" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion  =  1
" 最初の補完候補を選択状態にする
let g:neocomplcache_enable_auto_select = 1
" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20
" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

" 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

  if !exists('g:neocomplete#keyword_patterns')
          let g:neocomplete#keyword_patterns = {}
          endif
          let g:neocomplete#keyword_patterns['default'] = '\h\w*'

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

" 見た目系
" 行番号を表示
set number
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
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

let OSTYPE = system('uname')
set term=xterm-256color 
syntax on 

"キー割り当て
noremap <S-h>   ^
noremap <S-l>   $
noremap <S-o>   o<esc>k



" Unit.vimの設定
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
" noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')


"neocompleteの設定
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化.大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
"3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
"区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
"1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
"エンターキーで補完候補の確定.スニペットの展開もエンターキーで確定・・・・・・②
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" スニペット内のジャンプもタブキーでジャンプ・・・・・・③
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"補完候補の色設定
hi Pmenu ctermbg=2
hi PmenuSel ctermbg=5
hi PMenuSbar ctermbg=8

"コメントアウト機能
nmap <C-K> <Plug>(caw:hatpos:toggle)
vmap <C-K> <Plug>(caw:hatpos:toggle)
