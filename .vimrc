" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

"-------------------
"dein
"-------------------

let g:python3_host_prog = expand('~/.pyenv/shims/python3')

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    let g:rc_dir = expand('~/.vim/rc')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

let s:noplugin = 0
" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on

"------------------------------------------------
" 検索関係
"------------------------------------------------
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ（≒逐次検索）
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

set wrapscan            " 検索時にファイルの最後まで行ったら最初に戻る

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"------------------------------------------------
" 編集関係
"------------------------------------------------
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

set ts=4 sw=4 sts=4     " タブを設定
set autoindent          " 自動的にインデントする
set smartindent         " 賢いインデント
set cindent             " さらに賢いインデント
set cinoptions+=:0      " Ｃインデントの設定
set expandtab           " TABを押した時に空白で代用
set smarttab            " 行頭でTABを押した時、自動インデントする

" ファイルタイプによってインデント幅を変更する
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.rb setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.ml setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.mli setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.html setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.js setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.css setlocal ts=2 sw=2 sts=2
augroup END

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
    set clipboard& clipboard+=unnamedplus,unnamed
else
    " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
    set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile

"------------------------------------------------
" 表示関係
"------------------------------------------------
set list                " 不可視文字の可視化
set relativenumber      " 相対行番号の表示
set cursorline          " カーソルラインをハイライト
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=120      " その代わり80文字目にラインを入れる

set shortmess+=I        " 起動時のメッセージを表示しない
set shellslash          " Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set title               " タイトルを表示
set ruler               " ルーラーを表示
set cmdheight=2         " コマンドラインの高さ
set laststatus=2
set showcmd             " コマンドをステータスラインに表示
set showmode            " モードを表示
syntax on               " ハイライトシンタックスをonに

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" colorschem
"colorscheme railscasts
let g:lightline = {}
let g:lightline.colorscheme = 'railscasts'

" devicon
let g:NERDTreeDirArrows = 1
let NERDTreeWinSize=22
" let NERDTreeShowHidden = 1
"vim-nerdtree-syntax-highlight
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

" vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" dir-icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:DevIconsDefaultFolderOpenSymbol = ''
" file-icons
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
set guifont=RictyDiscordForPowerline\ Nerd\ Font:h13

" TabPage関連 qiita参考
" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1] " first window, first appears
        let no = i " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = fnamemodify(bufname(bufnr), ':t')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction
let &tabline = '%!' . s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
" The prefix key.
nnoremap [Tag] <Nop>
nmap t [Tag]
" Tab jump
for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor
" t1で一番左のタブ、tnで左からn番目のタブにジャンプ
" tc 新しいタブ
map <silent> [Tag]o :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>

"------------------------------------------------
" マクロおよびキー設定
"------------------------------------------------
"----------------------------------------
" ノーマルモード(旧版より引き継ぎ）
"----------------------------------------
"ヘルプ検索
nnoremap <F1> K
"現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
"強制全保存終了を無効化
nnoremap ZZ <Nop>
"カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
"キーボードマクロには物理行移動を推奨
"h l はノーマルモードのみ行末、行頭を超えることが可能に設定(whichwrap)
" zvはカーソル位置の折り畳みを開くコマンド
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv
nnoremap H ^ "jump to BOL
nnoremap L $ "jump to EOL
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>
"ファイル間の移動
nnoremap <C-]> g<C-]>

"----------------------------------------
" 挿入モード
"----------------------------------------
"十字キーバグ解消
imap OA <Up>
imap OB <Down>
imap OC <Right>
imap OD <Left>
imap [3~ <Delete>
