" Vundle
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

"" Vundle Plugins
"Bundle 'php.vim-for-php5'
"Bundle 'cake.vim'
"Bundle 'unite.vim'
"Bundle 'unite-yarm'
"Bundle 'unite-gem'
"Bundle 'unite-locate'
"Bundle 'unite-font'
"Bundle 'unite-colorscheme'
"Bundle 'sudo.vim'

":runtime macros/justify.vim

 " -------------------
 " 色の設定
 " -------------------
 " 強調表示(色付け)のON
 syntax on
 
 " 形式の切り替え
 set nocompatible

 highlight LineNr ctermfg=darkyellow    " 行番号
 "highlight SpecialKey ctermfg=grey " 特殊記号
 highlight Comment ctermfg=Green
 
 " -------------------
 " スペース＆タブの設定
 " -------------------
 " 全角スペースを視覚化
 highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
 match ZenkakuSpace /　/
 
 " タブ幅
 set expandtab
 set ts=2
 set sw=2
 set softtabstop=2
 
 
 " -------------------
 " 日本語の設定
 " -------------------
 set termencoding=utf-8
 set encoding=japan
 set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp
 set fenc=utf-8
 set enc=utf-8
 
 " -------------------
 " 検索
 " -------------------
 " 検索文字列が小文字の場合は大文字小文字を区別なく検索する(noignorecase)
 set ignorecase
 " 検索文字列に大文字が含まれている場合は区別して検索する(nosmartcase)
 set smartcase
 " 検索文字のハイライトをしない
 set hlsearch
 " インクリメンタルサーチ
 set incsearch
 
 " -------------------
 " バッファ関連
 " -------------------
 "変更中のファイルでも、保存しないで他のファイルを表示
 set hidden
 
 " -------------------
 " その他
 " -------------------
 set notitle
 " 自動的にファイルに保存
 "set autowrite
 " スクロール時の余白確保
 set scrolloff=5
 " 閉じ括弧が入力されたとき、対応する括弧を表示
 set showmatch
 " バックアップファイルを作る
 "set backup
 " 行番号を表示
 set number
 set history=50
 " タブ文字、行末など不可視文字を表示
 set list
 " listで表示される文字のフォーマットを指定
 set listchars=tab:\ \ ,extends:<,trail:\ 
 " 常にステータスラインを表示
 set laststatus=2
 " スワップファイル用のディレクトリ
 set directory=/tmp
 "set wildmode=full:list
 " メッセージのハイライト方法
 set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L
 


" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"" Key Remap
" カーソル位置の単語をヤンクした単語に置換
"nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
"nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
"vnoremap <silent> cy   c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

