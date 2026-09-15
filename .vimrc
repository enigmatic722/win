let g:mapleader=" "
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
set nossl
set nostartofline
set ttimeoutlen=0

if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
colorscheme onedark

set cursorline

set vb t_vb=
set formatoptions-=co
nnoremap cu :set cursorline! <CR>
set shellcmdflag=-command
set autochdir
set splitright
set splitbelow
set matchpairs+=<:>
set omnifunc=syntaxcomplete#Complete
set suffixesadd=.java
set path+=**
set nu rnu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set wildmode=list:full
set shortmess-=S
set hlsearch
set incsearch
set ff=dos
set scrolloff=3
set mouse=a
nnoremap <rightmouse> P
xnoremap <rightmouse> y

inoremap <rightmouse> <C-r>*
xnoremap <rightmouse> y

inoremap <middlemouse> <Esc>
tnoremap <middlemouse> <leftmouse><C-@>N
nnoremap <middlemouse> i
vnoremap <middlemouse> <Esc>

noremap j gj
noremap k gk

nnoremap <leader>q :bd<cr>
nnoremap <leader>! :bd!<cr>
inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
inoremap <C-b> <C-k>

inoremap <C-f>. <Space>-><Space>
inoremap <C-f>> <Space>=><Space>
inoremap <C-f>, <Space><-<Space>
inoremap <C-f>\| \|\|<Left>
inoremap <C-f>[ 「」<Left>
inoremap <C-f>, <><Left>

nnoremap <leader>- i----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------<esc>^ 
nnoremap <silent> <leader>h :noh<cr>
inoremap <C-s> <C-o>:w<cr>
nnoremap <C-s> :w<cr>
nnoremap <cr> %
vnoremap <cr> %
nnoremap - 3<C-w><
nnoremap = 3<C-w>>
nnoremap _ 3<C-w>+
nnoremap + 3<C-w>-

nnoremap zh zszH
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

cnoremap <C-a>  <Home>
cnoremap <C-d>  <Del>
cnoremap <C-e>  <End>
cnoremap <C-l>  <Right>
cnoremap <C-h>  <Left>
cnoremap <C-j> <down>
cnoremap <C-k>  <Up>



nnoremap & :&&<CR>
xnoremap & :&&<CR>
nnoremap <C-w><PageDown> <C-w>j
nnoremap <C-w><PageUp> <C-w>k
nnoremap <leader>; :tabe $MYVIMRC<cr>
nnoremap <leader>z :source $MYVIMRC<cr>
nnoremap <leader>/ /\<\>/<Left><Left><Left>
command! D windo diffthis
command! Do diffoff!
command! Uniq normal! :g/^\(.*\)$\n\1$/d<cr>
nnoremap <C-j> ]c
nnoremap <C-k> [c
nnoremap <expr> <Down> &diff ? ']c' : '<down>'


command! -nargs=1 SS let @/ = '\V'.escape(<q-args>, '\')
command! -nargs=1 SearchWithSlash let @/ = '\V'.escape(<q-args>, '/\')|normal! /<C-R>/<CR>

xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
cnoremap <C-s> <C-r>=escape('','/')<left><left><left><left><left><left>

autocmd BufRead *.class set syntax=java
autocmd BufNewFile,BufRead * setlocal formatoptions-=o
autocmd! FileType json set filetype=jsonc
au BufRead,BufNewFile *.vrapperrc set filetype=vim
au BufRead,BufNewFile *.v set filetype=coq
au BufRead,BufNewFile *.idr set filetype=idris
au BufRead,BufNewFile *.hsc set filetype=haskell
au BufRead,BufNewFile *.bpk set filetype=haskell
au BufRead,BufNewFile *.hsig set filetype=haskell
au BufRead,BufNewFile *.jsh set filetype=java
au BufRead,BufNewFile *.log set filetype=log
au BufRead,BufNewFile FTPS*.txt set filetype=log
au BufRead,BufNewFile *.syslog set filetype=log
au BufRead,BufNewFile *sql set filetype=SQL
au BufRead,BufNewFile *bat set filetype=dosbatch
au BufRead,BufNewFile .temprc set filetype=bash
au BufRead,BufNewFile *tmprc set filetype=bash
au BufRead,BufNewFile .termrc set filetype=vim
au BufRead,BufNewFile .dirrc set filetype=bash
au BufRead,BufNewFile bash set filetype=bash
au BufRead,BufNewFile ssl*.conf set filetype=apache
au BufRead,BufNewFile httpd*.conf set filetype=apache
au BufRead,BufNewFile *.conf set filetype=config
au BufRead,BufNewFile *.dat set filetype=csv_pipe
au BufRead,BufNewFile Jenkinsfile set filetype=groovy
au BufRead,BufNewFile Jenkinsfile* set filetype=groovy
au BufRead,BufNewFile *.jenkinsfile set filetype=groovy
au BufRead,BufNewFile *.md set formatoptions+=r comments-=fb:- comments+=:- | silent TableModeEnable
au BufRead,BufNewFile *.nft,nftables.conf set filetype=nftables

autocmd VimEnter memo.md exe "normal gg0d$i# \<c-r>=strftime('%m/%d (%a)')\<cr>\<home>\<esc>:w\<cr>"

autocmd! FileType autohotkey setl cms=\;%s 
autocmd! FileType jsonc setl cms=//%s 
autocmd! FileType markdown inoremap <buffer> <tab> <C-t>
set wildignore+=*.hi,*.o


noremap <C-z> <Esc>
nnoremap <home> ^
inoremap <home> <c-o>^

vnoremap g; g_
nnoremap <C-h> <C-o>
nnoremap <C-l> <C-i>

if !exists('g:lasttab')
  let g:lasttab = 1
endif

command! -nargs=1 Vgrep vimgrep <q-args> % | copen
nnoremap <leader>g :vimgrep // % <bar> :copen<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
nnoremap <A-S-k> :cp<cr>
nnoremap <A-S-j> :cn<cr>
nnoremap <leader>j :cn<cr>
nnoremap <leader>k :cp<cr>
nnoremap <A-l> :.cc<cr>
nnoremap co :copen<cr>
command! Co copen
command! Cc cclose

set fencs=utf-8,ucs-bom,utf-16le,big5,gbk,latin1,default
set encoding=utf-8
set ignorecase
set autoread
set nowrap
set ai
set background=dark
set termguicolors
set laststatus=2
set statusline=%F%h%m%r\ %=%l,%c%V\ %P

set iskeyword+=\$
syntax on
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
nnoremap dl ^"_D
nnoremap d "_d
nnoremap D "_D
nnoremap x "_x
nnoremap s "_s
vnoremap s "_s
nnoremap c "_c
nnoremap C "_C
vnoremap d "_d
vnoremap D "_D
vnoremap c "_c
vnoremap y "*y
nnoremap y "*y
nnoremap yl ^"*y$
nnoremap Y "*y$ 
nnoremap y" "*yi"
nnoremap y( "*yi(
nnoremap y' "*yi'
nnoremap y< "*yi<
nnoremap y{ "*yi{
nnoremap y[ "*yi[
vnoremap x "*x
nnoremap gp "_cw<C-r>*<Esc>b
noremap <leader>p p
noremap <leader>P P
nnoremap <leader>x "*x
nnoremap <leader>d "*d
nnoremap <leader>dl ^"*D

nnoremap <leader>D "*D
nnoremap <leader>c "*c
nnoremap <leader>C "*C
nnoremap <F2> :set nonu nornu<CR>
nnoremap <F3> :set nu <CR>
nnoremap <leader>n :set nonu! rnu!<CR>
nnoremap <leader>w :set wrap!<CR>
nnoremap <C-n> :set rnu!<CR>
nnoremap <leader>w :set nowrap!<CR>
inoremap <C-o>o <Esc>o
inoremap <C-o>O <Esc>O
nnoremap o o<Space><BS><Esc>
nnoremap O O<Space><BS><Esc>
vnoremap v( vi(
vnoremap v' vi'
vnoremap " c""<Esc>P
vnoremap ' c''<Esc>P
vnoremap ( c()<Esc>P
vnoremap { c{}<Esc>P
vnoremap [ c[]<Esc>P
vnoremap S c$$<Esc>P
nnoremap gs i~~<C-o>A~~<Esc>
vnoremap gs c~~~~<esc><left><left>p
nnoremap gb i**<C-o>A**<Esc>
vnoremap gb c****<esc><left><left>p
nnoremap gh i*<C-o>A*<Esc>
vnoremap gh c**<esc><left>p
nnoremap dh f*xr)F*Xr(

vnoremap < <gv
vnoremap > >gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <S-tab> gT
nnoremap <tab>   gt

nnoremap <silent> <A-S-i> :tabm 0 <CR>
nnoremap <silent> <A-S-m> :execute 'tabm' tabpagenr('$') <CR>
nnoremap <A-h> :tabm -1 <CR>
nnoremap <A-l> :tabm +1 <CR>
nnoremap <leader>1 :tabr<CR>
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 :tabl<CR>
nnoremap <leader>v :vnew 
nnoremap <C-t> :tabnew 
nnoremap <leader>kb /KB[0-9].\{-}\s<cr>

nnoremap <leader>/ /\<\>/<Left><Left><Left>
nnoremap <leader>y <enter> 

inoremap <C-f>d **<c-r>=strftime('%m/%d')<cr>**<left><left>
nnoremap <leader>i O# <c-r>=strftime('%m/%d (%a)')<cr><Esc>0
nnoremap <leader>' gg0"_d$i# <c-r>=strftime('%m/%d (%a)')<cr><Esc>0:let @/ = strftime("%m\\/%d") <bar> /<cr>:w<cr>
nnoremap <leader>m :tabnew \| :view D:/memo/memo.md \| :vert sview D:/memo/memo_done.md<cr> \| :wincmd w<cr>
nnoremap <C-w>q :windo bd<cr>
nmap <C-o> gx
xmap <C-o> gx



vnoremap <C-r> "hy:%s/<C-r>h//gcI<left><left><left>
nnoremap <silent> cpd :let @+ = expand("%:p:h") <bar> let @+ = substitute(@+, "\/d\/", "D:\/", "g") <bar> let @+ = substitute(@+, "\/c\/", "C:\/", "g")<cr>
nnoremap <silent> cpf :let @+ = expand("%:p") <bar> let @+ = substitute(@+, "\/d\/", "D:\/", "g") <bar> let @+ = substitute(@+, "\/c\/", "C:\/", "g")<cr>


nnoremap <silent> cpn :let @+ = expand("%")<cr>
command! Pd normal! i<c-r>=expand('%:p')<Cr>
command! Pn normal! i<c-r>=expand('%:r')<Cr>
command! Pf normal! i<c-r>=expand('%')<Cr>
command! Grp %s/.*\n.*\n/\0\r/g
command! ReverseBackslash %s/\\/\//g "reverse backslash
command! ReverseSlash %s/\//\\/g "reverse backslash
command! -range=% DeleteBlankLine :<line1>,<line2>g/^\s*$/d  "delete blank line with visual select
command! -range=% DeleteBlankLineAll :<line1>,<line2>s/^\d*//g  "delete blank line
command! DeleteTrailingSpace :%s/\s\+$//e<cr> " delete trainling space
command! -range=% Trl :<line1>,<line2>s/\s\+$//e "delete blank 
command! -range=% Trh :<line1>,<line2>s/^\s\+//e "delete blank 
command! -range=% B :<line1>,<line2>s/\S\s\zs\s\+//e " 第一個非空白後的第一個空白後(\zh)，開始把空白刪除
command! -range=% B1 :<line1>,<line2>s/\S\zs\s\+/  /e " 第一個非空白後的第一個空白後(\zh)，開始把空白刪除
command! -range=% To1Blank :<line1>,<line2>s/\s\+/\ /g " 將多個空白取代為1個空白 
command! Edq %s/\"/\\\"/g "escape double quote
command! -nargs=1 Lh %s/^\w\@=/<args>/g 
command! -nargs=1 Ll %s/$/<args>/g
command! -nargs=1 Hh normal! /.*<args>/g<CR>
command! -nargs=1 Ht normal! /<args>.*/g<CR>
command! -nargs=1 Hl normal! /.*<args>/g<CR>
command! -nargs=1 Ha normal! /<args>\S\+/<CR>
command! -nargs=1 Hb normal! /\S\+<args>/<CR>
command! -nargs=1 Hc normal! /\S\+<args>\S*/<CR>
command! -nargs=+ Hcc call Hcc (<f-args>)
function! Hcc(...)
    let arg1 = get(a:, 1, 0)
    let arg2 = get(a:, 2, 0)
    if a:0 == 2
		let pattern = '\%>'. arg1 . 'c' . '\%<' . arg2 . 'c'   
		let @/ = pattern
		call feedkeys("/\<CR>")
       " execute printf("normal /\\%%>%sc\\%%<%sc\<CR>", arg1, arg2)
    else
        let pattern = '\%>'. arg1 . 'c' 
		let @/ = pattern
		call feedkeys("/\<CR>")
    endif
endfunction


vnoremap r :s///g<left><left>
nnoremap <leader>r :%s///gcI<left><left><left><left>
nnoremap <leader><leader>r :%s///gI<left><left><left>
nnoremap <leader>l :s///gI<left><left><left>
nnoremap <leader>b :.,$s///gcI<left><left><left><left>
nnoremap <leader>\ :s/\//\\/gI<left><left><left><cr>

command! -nargs=1 Rl s//<args>/gcI
command! -nargs=+ Rw call Rw (<f-args>)
function! Rw(...)
    let arg1 = get(a:, 1, 0)
    let arg2 = get(a:, 2, 0)
    if a:0 == 2
        execute printf('%%substitute/\<%s\>/%s/gcI', arg1, arg2)
    else
        execute printf('%%substitute//%s/gcI', arg1)
    endif
endfunction

command! -nargs=+ Dh call Dh(<f-args>)
function! Dh( ... )
	let arg1 = get(a:, 1, 0)
    let arg2 = get(a:, 2, 0)
    if a:0 == 2
		execute printf('%%substitute/.*%s/%s/g', a:1, a:2)
    else
	    execute printf('%%substitute/.*%s//g', a:1)
    endif
endfunction

command! -nargs=+ Dbw call Dbw(<f-args>)
function! Dbw( ... )
    let arg1 = get(a:, 1, 0)
    let arg2 = get(a:, 2, 0)
    if a:0 == 2
        execute printf('%%substitute/.*\<%s\>/%s/g', a:1, a:2)
    else
        execute printf('%%substitute/.*\<%s\>/%s/g', a:1, a:1)
    endif
endfunction

command! -nargs=+ Da call Da(<f-args>) 
function! Da( ... )
    let arg1 = get(a:, 1, 0)
    let arg2 = get(a:, 2, 0)
    if a:0 == 2
		execute printf('%%substitute/%s.*/%s/g', a:1, a:2)
    else
		execute printf('%%substitute/%s.*//g', a:1)
    endif	
endfunction

nnoremap <A-w> :BufCurOnly<cr>

function! TabCloseRight(bang)
    let cur=tabpagenr()
    while cur < tabpagenr('$')
        exe 'tabclose' . a:bang . ' ' . (cur + 1)
    endwhile
endfunction

function! TabCloseLeft(bang)
    while tabpagenr() > 1
        exe 'tabclose' . a:bang . ' 1'
    endwhile
endfunction

command! -bang Tcl call TabCloseRight('<bang>')
command! -bang Tcr call TabCloseLeft('<bang>')

function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction




let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide='.*\.swp$'
let g:netrw_chgwin=3
let g:netrw_browse_split = 3
let g:netrw_winsize = 20
let g:netrw_altv = 1
let g:netrw_preview = 1
let g:netrw_alto = 0

function! NetrwMapping()
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> <Leader>r <C-l>
    noremap <buffer> <C-l> gt
    "nnoremap <buffer> <C-r> <C-l>
    nmap <buffer> H u
    ""nmap <buffer> h -^
    nmap <buffer> o <CR>
    nmap <buffer> . gh
    nmap <buffer> P <C-w>z
    nmap <buffer> L <CR>:Lexplore<CR>
    nmap <buffer> ti :tabr<CR>
    nmap <buffer> t; :tabl<CR>
    nmap <buffer> tci :Tcr<cr>
    nmap <buffer> tc; :Tcl<cr>
    nmap <buffer> <C-j> ]c
    "nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction

call plug#begin()
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'mtdl9/vim-log-highlighting'
Plug 'justinmk/vim-sneak'
call plug#end()

let g:syntastic_python_python_exec = 'python3' 

let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'sh', 'xml', 'conf', 'ps1', 'bash', 'sshdconfig']

let g:delimitMate_expand_cr=1
let g:delimitMate_expand_space=1
let g:delimitMate_matchpairs='(:),{:},[:]'
autocmd! FileType rs let b:delimitMate_matchpairs = '(:),{:},[:],":"'
augroup mydelimitMate
au!
    au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
    au FileType tex let b:delimitMate_quotes = ""
    au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
    au FileType python let b:delimitMate_nesting_quotes = ['"', "'", "_"]
augroup END
au BufRead,BufNewFile markdown let b:delimitMate_matchpairs = '(:),{:},[:]'

au! FileType markdown let g:table_mode_motion_left_map = '<C-h>' | let g:table_mode_motion_right_map = '<C-l>' | inoremap <buffer> <tab> <C-t>

xmap <C-_> <Plug>Commentary
imap <C-_> <C-o><Plug>CommentaryLine
nmap <C-_> <Plug>Commentary
omap <C-_> <Plug>Commentary
nmap <C-_> <Plug>CommentaryLine

set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.class 
set wildignore+=**/target/**
set wildignore+=**/node_modules/**
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_custom_ignore = {
  \ 'dir':  'target',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
	\ 'AcceptSelection("h")': ['<a-x>', '<c-x>'],
	\ 'AcceptSelection("v")': ['<a-v>', '<c-v>', '<RightMouse>'],
    \ }

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_multiple_files = 'tj'

let g:EasyMotion_do_mapping = 0
map <leader>s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1

let g:sneak#use_ic_scs = 1
nmap ' <Plug>Sneak_s
nmap " <Plug>Sneak_S
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F

xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F

let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'


set showtabline=1
set tabline=%!MyTabLine()
function MyTabLine()
  let s = '' " complete tabline goes here
  " loop through each tab page
  for t in range(tabpagenr('$'))
    " select the highlighting for the buffer names
    if t + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " empty space
    let s .= ' '
    " set the tab page number (for mouse clicks)
    let s .= '%' . (t + 1) . 'T'
    " set page number string
    let s .= t + 1 . ' '
    " get buffer names and statuses
    let n = ''  "temp string for buffer names while we loop and check buftype
    let m = 0 " &modified counter
    let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
    " loop through each buffer in a tab
    for b in tabpagebuflist(t + 1)
      " buffer types: quickfix gets a [Q], help gets [H]{base fname}
      " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
      if getbufvar( b, "&buftype" ) == 'help'
        let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
      elseif getbufvar( b, "&buftype" ) == 'quickfix'
        let n .= '[Q]'
      else
        "let n .= pathshorten(bufname(b))
        let n .= bufname(b)
      endif
      " check and ++ tab's &modified count
      if getbufvar( b, "&modified" )
        let m += 1
      endif
      " no final ' ' added...formatting looks better done later
      if bc > 1
        let n .= ' '
      endif
      let bc -= 1
    endfor
    " add modified label [n+] where n pages in tab are modified
    if m > 0
      "let s .= '[' . m . '+]'
      let s.= '+ '
    endif
    " add buffer names
    if n == ''
      let s .= '[No Name]'
    else
      "let s .= n
      let s .= fnamemodify(n, ":t") 
    endif
    " switch to no underlining and add final space to buffer list
    "let s .= '%#TabLineSel#' . ' '
    let s .= ' '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'
  endif
  return s
endfunction

let g:haskell_classic_highlighting = 1
let g:python_highlight_all = 1


ab sout System.out.println
ab psvm public static void main(String[] args)
ab pcl public class

ab pmain if __name__ == '__main__':
ab pcons def __init__(self):


let g:sp = 'D:/memo/sp/servers.md'

let g:table_mode_corner='|'
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

nnoremap <leader>f :TableModeRealign<cr>
nnoremap <leader>s :TableSort<cr>

augroup mytablemode
au!
    au! FileType markdown let g:table_mode_motion_left_map = '<C-h>' | let g:table_mode_motion_right_map = '<C-l>'
    au! FileType markdown map <C-j> ]]| map <C-k> [[| inoremap <buffer> <tab> <C-t>
augroup END


function! Fix_dos()
    " This would be the correct syntax, but no need for :normal:
    "execute "normal :e ++ff=dos\<cr>"
    " Also, no need for execute:
    "execute "e ++ff=dos"
    edit ++ff=dos
endfunction

command! Ct set ft=csv_pipe | %Tableize
command! Tc silent! %s/^|\||$\|\s\+//g | silent! %s/|/,/g | set ft=csv | noh

nnoremap <expr> t, &filetype == 'csv' ? ':Ct<CR>' : ':Tc<CR>'
nnoremap <expr> <leader>, &filetype == 'csv' ? ':Ct<CR>' : ':Tc<CR>'

nnoremap <expr> <C-l> get(b:, 'rbcsv', 0) == 1 ? ':RainbowCellGoRight<CR>' : '<C-i>'
nnoremap <expr> <C-h> get(b:, 'rbcsv', 0) == 1 ? ':RainbowCellGoLeft<CR>' : '<C-o>'


:command! FixDos edit ++ff=dos





set shell=pwsh
set shellxquote=
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
let &shellquote   = ''
let &shellpipe    = '| Out-File -Encoding UTF8 %s'
let &shellredir   = '| Out-File -Encoding UTF8 %s'

let $TMP = $HOME."/tmp"
nnoremap <silent> <leader>s :term<cr><C-@>:file <c-r>="pwsh".bufnr("%")<cr><cr>
nnoremap <silent> <leader>v :vert term<cr><C-@>:file <c-r>="pwsh".bufnr("%")<cr><cr>

nnoremap <expr> <C-q> bufwinnr("!pwsh") != -1 ? ':call win_gotoid(bufwinid("!pwsh")) \| <C-@>:hide<cr>' : (bufexists("!pwsh") == 1 ? ':bo sb !pwsh \| 18wincmd _<CR>' : ':bo term ++rows=18<cr><C-@>:file !pwsh<cr>')
tnoremap <expr> <C-q> bufname("%") == '!pwsh' ? '<C-@>:hide<CR>' : '<C-@>:bo sb !pwsh<cr>'

nnoremap <expr> <C-@>8 bufwinnr("pwsh8") != -1 ? ':call win_gotoid(bufwinid("pwsh8")) \| <C-@>:hide<cr>' : (bufexists("pwsh8") == 1 ? ':vert sb pwsh8<CR>' : ':vert term<cr><C-@>:file pwsh8<cr>')
tnoremap <expr> <C-@>8 bufwinnr("pwsh8") != -1 ? '<C-@>:call win_gotoid(bufwinid("pwsh8")) \| <C-@>:hide<cr>' : (bufexists("pwsh8") == 1 ? '<C-@>:vert sb pwsh8<CR>' : '<C-@>:vert term<cr><C-@>:file pwsh8<cr>')


tnoremap <C-@>m <C-@>:hide<CR>
tnoremap <C-@><C-m> <C-@>:hide<CR>

nmap <C-@> <C-w>


nnoremap <C-@><C-@> :<BS>
nnoremap <C-w>r <C-w>=
nnoremap <C-w><C-r> <C-w>=
nnoremap <C-w>m :hide<CR>
nnoremap <C-w><C-m> :hide<CR>

nnoremap <C-w>; :ls<cr>:vert sb
nnoremap <C-w>' :ls<cr>:sb
nnoremap <C-w>: :sbnext<cr>
nnoremap <C-w>v :vert term<cr>
nnoremap <C-w><C-v> :vert term<cr>
nnoremap <C-w>s :term<cr>
nnoremap <C-w><C-@> :term<cr>
nnoremap <C-w>w :tabclose<cr>


nnoremap <C-@>d <C-w>T

nnoremap - 3<C-w><
nnoremap = 3<C-w>>
nnoremap + 3<C-w>+
nnoremap _ 3<C-w>-

nnoremap <C-up> <C-w>3+
nnoremap <C-down> <C-w>3-
nnoremap <C-left> <C-w>3<
nnoremap <C-right> <C-w>3>

nnoremap <C-@>] gt
nnoremap <C-@><C-]> gt
nnoremap <C-@>[ gT
nnoremap <C-@><C-[> gT

set termwinkey=<C-@>
tnoremap <C-j> <C-j>
tnoremap <C-j> <Down>
tnoremap <C-@>r <C-@>=
tnoremap <C-@><C-r> <C-@>=
tnoremap <C-@>i <C-@>\|
tnoremap <C-@><C-i> <C-@>\|

tnoremap <C-up> <C-@>3+
tnoremap <C-down> <C-@>3-
tnoremap <C-left> <C-@>3<
tnoremap <C-right> <C-@>3>


tnoremap <silent> <C-@>s <C-@>:term<cr><C-@>:file <c-r>="pwsh".bufnr("%")<cr><cr>
tnoremap <silent> <C-@><C-s> <C-@>:term<cr><C-@>:file <c-r>="pwsh".bufnr("%")<cr><cr>

tnoremap <silent> <C-@>v <C-@>:vert term<cr><C-@>:file <c-r>="pwsh".bufnr("%")<cr><cr>
tnoremap <silent> <C-@><C-v> <C-@>:vert term<cr><C-@>:file <c-r>="pwsh".bufnr("%")<cr><cr>
tnoremap <silent> <C-@>n <C-@>:tab term<cr><C-@>:file <c-r>="pwsh".bufnr("%")<cr><cr>
tnoremap <silent> <C-@><C-n> <C-@>:tab term<cr><C-@>:file <c-r>="pwsh".bufnr("%")<cr><cr>
tnoremap <C-@>d <C-@>T
tnoremap <C-@>q <C-@>:q!<cr>
tnoremap <C-@><C-q> <C-@>:q!<cr>
tnoremap <C-@>z <C-@>:qa!<cr>
tnoremap <C-@><C-c> <C-@>:qa!<cr>

tnoremap <C-@>o <C-@>:ls<cr>:sb
tnoremap <C-@><C-o> <C-@>:ls<cr>:sb

tnoremap <C-@>; <C-@>:ls<cr>:vert sb
tnoremap <C-@>' <C-@>:ls<cr>:sb

tnoremap <C-@>] <C-@>gt
tnoremap <C-@><C-]> <C-@>gt
tnoremap <C-@>[ <C-@>gT
tnoremap <C-@><C-[> <C-@>gT


tnoremap <C-@>/ <C-@>N/
tnoremap <C-@>? <C-@>N?
tnoremap <C-@>p <C-@>""
tnoremap <C-@><c-p> <C-@>""

tnoremap <C-@><BS> <C-@>N:<BS>i
nnoremap <C-@><BS> :<BS>i

nnoremap <leader>e :NERDTreeToggle<CR>
tnoremap <C-@>e <C-@>:NERDTreeToggle<CR>
nnoremap <C-@>e :NERDTreeToggle<CR>
let NERDTreeMapOpenInTab='<ENTER>'
let g:NERDTreeMapActivateNode = 'l'
nmap <right> l
set pastetoggle=<F4>

command! BufCurOnly silent! execute '%bd|e#|bd#'
function! OnlyAndNerdtree()
    let currentWindowID = win_getid()
    windo if win_getid() != currentWindowID && &filetype != 'nerdtree' | close | endif
endfunction
command! Only call OnlyAndNerdtree()


execute "set <M-l>=\el"

execute "set <M-h>=\eh"
inoremap <M-l> <Esc>ea
inoremap <M-h> <S-Left>
tnoremap <M-l> <C-Right>
tnoremap <M-h> <C-Left>
tnoremap <M-l> <C-Right>
tnoremap <M-h> <C-Left>
tnoremap <M-l> :tabm -1 <CR>
tnoremap <M-h> :tabm +1 <CR>

function! ToggleQuickfix()
    " if &buftype == 'quickfix'
    if bufexists("[Quickfix List]")
        cclose
    else
        copen
    endif
endfunction
nnoremap <leader>o :call ToggleQuickfix()<CR>

execute "set <M-j>=\ej"
nnoremap <M-j> :cn<CR>

execute "set <M-k>=\ek"
nnoremap <M-k> :cp<CR>

execute "set <M-e>=\ee"
nnoremap <M-e> :Tcl<cr>

execute "set <M-q>=\eq"
nnoremap <M-q> :Tcr<cr>

execute "set <M-w>=\eq"
nnoremap <M-w> :wq<cr>

execute "set <M-s>=\es"
inoremap <M-s> $$<left>


tnoremap <C-@><space> <C-@>N
tnoremap <C-@><C-@> <C-@>N



autocmd QuitPre * call <sid>TermForceCloseAll()
function! s:TermForceCloseAll() abort
  let term_bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"')
  for t in term_bufs
    execute "bd! " t
  endfor
endfunction

autocmd VimEnter * exe "term ++hidden"

command! Ary normal! :g/^\s*$/d<cr> | :%s/\s*$//g | 1,$-1s/$/","/gI | %j! | %s/^/@("/gI | %s/$/")/gI<cr> | :nohlsearch<CR> 
command! Wf normal! g/^\s*$/d<cr> | :%s/\s*$//g | %j | %s/ /","/gI | %s/^/$newips = @("/gI | %s/$/")/gI<cr> | :nohlsearch<CR> 


set fillchars+=vert:\▏
set fillchars+=eob:\ 



