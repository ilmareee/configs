runtime! archlinux.vim

scriptencoding utf-8
filetype on
filetype plugin on
filetype indent on
syntax on

" Show all changes.
set report=0
set showcmd
set list
" octal base support for ctrl+A and ctrl+X
set nrformats+=octal
" fixed line number around the cursor
set scrolloff=5
" When closing a tab, remove the buffer
set nohidden

" KEYS-----------------------------------------{{{
set backspace=indent,eol,start
" Allow cursor keys in insert mode.
set esckeys
" Make j/k respect the columns
set nostartofline

" PAIR CLOSING--------------------{{{
inoremap {      {}<Left>
inoremap {<CR>  {<CR>\}<Left><BS><BS><Esc>O
inoremap {{     {
inoremap {}     {}

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Left><BS><Esc>O
inoremap ((     (
inoremap ()     ()

inoremap <      <><Left>
inoremap <<CR>  <<CR>><Left><BS><Esc>O
inoremap <<     <
inoremap <>     <>

inoremap /*     /**/<Left><Left>
inoremap /*<CR> /*<CR>*/<Left><Left><BS><Esc>O
inoremap /*/    /*
inoremap /**/   /**/

autocmd FileType c,cpp,java inoremap =     =;<Left>
autocmd FileType c,cpp,java inoremap ==    ==
"}}}

"}}}

" HISTORY--------------------------------------{{{
set history=999
set undolevels=999
"}}}

" COMMAND COMPLETION---------------------------{{{
" Hitting TAB in command mode to show completions
set wildmenu
set wildchar=<TAB>
set wildmode=list:longest,full
"}}}

" INDENTATION----------------------------------{{{
set autoindent smartindent
set copyindent
set noexpandtab
" expanded Tab key results in # spaces
set softtabstop=5
" Tab is # spaces
set tabstop=4
" The # of spaces for indenting.
set shiftwidth=4
" At start of line, <Tab> inserts shift width spaces, <Bs> deletes shift width spaces.
set smarttab
"}}}

" FOLDING--------------------------------------{{{
set foldmethod=marker foldlevel=0 foldmarker={{{,}}}
highlight Folded cterm=bold ctermfg=10 ctermbg=NONE
set foldcolumn=1
highlight FoldColumn ctermfg=14 ctermbg=NONE
"}}}

" HIGHLIGHTINGS--------------------------------{{{

" USUAL CODE SYNTAX----------------------------{{{

highlight clear Normal

" HIGHLIGHT COUPLES----------------------------{{{
set showmatch
set matchpairs+=<:>
autocmd FileType c,cpp,java set mps+==:;
highlight MatchParen ctermbg=13
"}}}

highlight Comment ctermfg=12

" CONSTANT-------------------------------------{{{
highlight Constant ctermfg=3
"highlight String links to Constant
"highlight Character links to Constant
"highlight Number links to Constant
     "highlight Float links to Number
"highlight Boolean links to Constant
"}}}

" SPECIAL--------------------------------------{{{
highlight Special ctermfg=22
"highlight Tag links to Special
"highlight SpecialChar links to Special
"highlight Delimiter links to Special
"highlight SpecialComment links to Special
"highlight Debug links to Special
"}}}

" IDENTIFIER-----------------------------------{{{
highlight Identifier cterm=bold ctermfg=13
"highlight Function links to Identifier
"}}}

" STATEMENTS-----------------------------------{{{
highlight Statement ctermfg=9
"highlight Conditional links to Statement
highlight Conditional ctermfg=10
"highlight Repeat links to Statement
highlight Repeat ctermfg=202
"highlight Label links to Statement
highlight Label ctermfg=10
"highlight Operator links to Statement
highlight Operator ctermfg=201
"highlight Keyword links to Statement
"highlight Exception links to Statement
highlight Exception ctermfg=10
"}}}

" PREPROC--------------------------------------{{{
highlight PreProc ctermfg=2
"highlight Include links to PreProc
"highlight Define links to PreProc
"highlight Macro links to PreProc
"highlight PreCondit links to PreProc
"}}}

" TYPE-----------------------------------------{{{
highlight Type ctermfg=129
"highlight StorageClass links to Type
"highlight Structure links to Type
"highlight Typedef links to Type
"}}}

" SPECIAL CHARS--------------------------------{{{
" displays returned lines when too long
set showbreak=\\\\
" displays some invisible chars
set listchars=tab:»\ 
set listchars+=multispace:·
set listchars+=trail:·
set listchars+=nbsp:·
set listchars+=extends:>
set listchars+=precedes:<

highlight SpecialKey ctermfg=243
"}}}

" OTHERS---------------------------------------{{{
highlight Underlined cterm=underline ctermfg=5
highlight Ignore ctermfg=15
highlight Error ctermfg=15 ctermbg=9
highlight Todo ctermfg=0 ctermbg=11
highlight Directory ctermfg=5
highlight ErrorMsg ctermfg=15 ctermbg=9
"}}}

"}}}

" VIM FEATURES---------------------------------{{{

highlight Visual ctermbg=201

"SEARCHING ------------------------------------{{{
set hlsearch
set incsearch
set ignorecase smartcase
highlight IncSearch cterm=reverse
highlight Search ctermfg=5 ctermbg=10
"}}}

"STATUS LINE-----------------------------------{{{
set noshowmode
set noruler
" Always show status line
set laststatus=2

" UPDATEBAR------------------------------------{{{
" initialise the call of Redraw, called each time mode is changed
let &stl.='%{RedrawStatuslineColors(mode())}'

function! RedrawStatuslineColors(mode)
     if a:mode == 'n'
          call NormalHighlight()
     elseif a:mode == 'i'
          call InsertHighlight()
     elseif a:mode == 'R'
          call ReplaceHighlight()
     elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
          call VisualHighlight()
     endif
     return ''
endfunction
"}}}

"DEFINITIONS OF STATUS BARS--------------------{{{
function! NormalHighlight()
     set statusline=%-15(%5*\ \ --NORMAL--%)%<%9*%F%2*%m%{RedrawStatuslineColors(mode())}%9*%=%50(char:%B\ %=line:%4*%l/%L%9*,col:%3*%c%V\ \ %6*%-6(%p%%%)%1*\(%{strftime('%d/%m\ %H:%M')}\)%)
endfunction
function! InsertHighlight()
     set statusline=%-15(%6*\ \ --INSERT--%)%<%9*%F%2*%m%{RedrawStatuslineColors(mode())}%9*%=%50(char:%B\ %=line:%4*%l/%L%9*,col:%3*%c%V\ \ %6*%-6(%p%%%)%1*\(%{strftime('%d/%m\ %H:%M')}\)%)
endfunction
function! ReplaceHighlight()
     set statusline=%-15(%7*\ \ --REPLACE--%)%<%9*%F%2*%m%{RedrawStatuslineColors(mode())}%9*%=%50(char:%B\ %=line:%4*%l/%L%9*,col:%3*%c%V\ \ %6*%-6(%p%%%)%1*\(%{strftime('%d/%m\ %H:%M')}\)%)
endfunction
function! VisualHighlight()
     set statusline=%-15(%8*\ \ --VISUAL--%)%<%9*%F%2*%m%{RedrawStatuslineColors(mode())}%9*%=%50(char:%B\ %=line:%4*%l/%L%9*,col:%3*%c%V\ \ %6*%-6(%p%%%)%1*\(%{strftime('%d/%m\ %H:%M')}\)%)
endfunction
"}}}

"USER COLORS FOR STATUS BAR--------------------{{{
" date
highlight User1 ctermfg=11
" [+] modified flag
highlight User2 ctermfg=2
" column number
highlight User3 ctermfg=4
" lines ratio
highlight User4 cterm=bold ctermfg=165
" --NORMAL--
highlight User5 cterm=bold ctermfg=14
" --INSERT--
highlight User6 cterm=bold ctermfg=10
" --REPLACE--
highlight User7 cterm=bold ctermfg=93
" --VISUAL--
highlight User8 cterm=bold ctermfg=202
" neutral
highlight User9 ctermfg=7
"}}}

"STATUS GENERAL HIGHLIGHT----------------------{{{
highlight StatusLine cterm=bold
highlight StatusLineNC cterm=strikethrough

highlight StatusLineTerm cterm=bold
highlight StatusLineTermNC cterm=strikethrough
"}}}

"}}}

"LINE NUMBER-----------------------------------{{{
set number
highlight LineNr ctermfg=242
"highlight LineNrAbove cleared
"highlight LineNrBelow cleared
"}}}

"CURRENT LINE----------------------------------{{{
set cursorline
highlight CursorLineNr cterm=underline,bold ctermbg=232 ctermfg=196
highlight CursorLine cterm=NONE ctermbg=232
"highlight CursorLineSign links to SignColumn
highlight CursorLineFold cterm=bold ctermfg=10 ctermbg=232
"}}}

" CURRENT COLUMN-------------------------------{{{
set nocursorcolumn
"highlight CursorColumn ctermbg=7
set colorcolumn=""
"highlight ColorColumn ctermbg=224
"highlight SignColumn ctermfg=4 ctermbg=248
"}}}

" NONTEXT--------------------------------------{{{
"highlight EndOfBuffer links to NonText
highlight NonText ctermfg=14
"}}}

" SPELLCHECK-----------------------------------{{{
highlight SpellBad ctermbg=124
"highlight SpellCap ctermbg=81
"highlight SpellRare ctermbg=225
"highlight SpellLocal ctermbg=14
"}}}

" UNUSED/DEFAULTS------------------------------{{{

" TOOLBARLINE----------------------------------{{{
"highlight ToolbarLine ctermbg=7
"highlight ToolbarButton cterm=bold ctermfg=15 ctermbg=242
"}}}

" TABLINE--------------------------------------{{{
"highlight TabLine cterm=underline ctermfg=0 ctermbg=7
"highlight TabLineSel cterm=bold
"highlight TabLineFill cterm=reverse
"}}}

" PMENU----------------------------------------{{{
"highlight Pmenu ctermfg=0 ctermbg=225
"highlight PmenuSel ctermfg=0 ctermbg=7
"highlight PmenuSbar ctermbg=248
"highlight PmenuThumb ctermbg=0
"}}}

" DIFFS----------------------------------------{{{
"highlight DiffAdd ctermbg=81
"highlight DiffChange ctermbg=225
"highlight DiffDelete ctermfg=12 ctermbg=159
"highlight DiffText cterm=bold ctermbg=9
"}}}

" OTHERS---------------------------------------{{{
"highlight Conceal ctermfg=7 ctermbg=242
"highlight QuickFixLine links to Search
"highlight VertSplit cterm=reverse
"highlight Title ctermfg=5
"highlight VisualNOS cleared
"}}}

"}}}

" OTHERS---------------------------------------{{{
highlight MoreMsg ctermfg=2
highlight Question cterm=bold ctermfg=1
highlight WarningMsg cterm=bold ctermfg=1
highlight WildMenu ctermfg=0 ctermbg=10
"}}}

"}}}

"}}}
