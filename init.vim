call plug#begin()
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'rhysd/clever-f.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'mhinz/vim-startify'
	Plug 'hecal3/vim-leader-guide'
	Plug 'sheerun/vim-polyglot'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'omnisharp/omnisharp-vim', { 'do': 'cd server && xbuild' }
	Plug 'OrangeT/vim-csharp'
	Plug 'rhysd/vim-clang-format'
	Plug 'lervag/vimtex'
 	Plug 'vim-airline/vim-airline'
	Plug '/usr/local/opt/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'stevearc/vim-arduino'
	Plug 'LucHermitte/mu-template'
        "Plug 'arzg/vim-colors-xcode'
        Plug 'nickaroot/vim-xcode-dark-theme'
        "Plug 'octol/vim-cpp-enhanced-highlight'
"        Plug 'arakashic/chromatica.nvim'
call plug#end()


let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
set relativenumber 

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

"Window Menu
nnoremap <Space>wh <C-W><C-H>
nnoremap <Space>wj <C-W><C-J>
nnoremap <Space>wk <C-W><C-K>
nnoremap <Space>wl <C-W><C-L>
noremap  <Space>wc :Goyo<CR>

"File Menu
nnoremap <Space>ft :NERDTreeToggle<CR>
nnoremap <Space>fs :w <CR>

"Normal Mappings
nnoremap <Bslash>j o<ESC>
nnoremap <Bslash>k O<ESC>
noremap <Tab> i<Tab><ESC>
noremap <Space><Tab> :tabNext<CR>
noremap <C-]> <C-]>zt
noremap <Space>bb :Buffers<CR>
noremap <S-Tab> :bdelete<CR>
":bprevious<CR>

"noremap <BS> i<BS><ESC>
noremap <silent> <space> :nohlsearch<CR>
noremap <silent> <esc> :nohlsearch<CR>

"Insert Mappings
inoremap <c-\>j <ESC>o
inoremap jj <ESC>
"inoremap <ESC> :UpdateTags<ESC>
"Latex
let g:tex_flavor = 'latex'
function! OnLatexFile()
	set spell
	inoremap <C-,> <ESC><F7>
	nnoremap <C-,> <F7>
	nnoremap <Space>mc :w<CR> :!pdflatex %:p<CR>
	nnoremap <Space>mo :!zathura % &<CR>
endfunction
autocmd FileType tex call OnLatexFile() 

"C++ 
function! OnCPPFile()
	nnoremap <Space>mc :w<CR> :!cmake .<CR> :!make<CR>
	nnoremap <Space>mf :ClangFormat<CR>
        nnoremap <Space>ms :w<CR> :CocCommand clangd.switchSourceHeader<CR>
	let g:clang_format#code_style = "llvm"
	let g:detect_style_file = 1
        nn <silent> K :call CocActionAsync('doHover')<cr>
        set updatetime=300
        au CursorHold * sil call CocActionAsync('highlight')
        au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
"        au CursorHoldI * sil CocCommand clangd.symbolInfo
"	call clang_format#enable_format_on_insert()
"	call clang_format#enable_auto_format()
	abbreviate cincludes #include <stdio.h>
           \<CR>#include <stdlib.h>
           \<CR>#include <stdint.h>

	abbreviate cmain int main(int argc, char **argv)
            \<CR>{<CR>return 0;<CR>}<UP><UP>

endfunction
autocmd FileType cpp call OnCPPFile() 
autocmd FileType c call OnCPPFile() 

function! OnCmakeFile()
	inoremap <ESC> <ESC>
	inoremap jj <ESC>
	
	call clang_format#disable_auto_format()
	abbreviate cproj project(<ESC>:put =expand('%:p:h:t')<CR>i<BS><ESC>ea)
				\<CR>add_executable(<ESC>:put =expand('%:p:h:t')<CR>i<BS><ESC>ea)
	
endfunction 	
autocmd FileType cmake call OnCmakeFile()

function! OnCSharpFile()
	nnoremap <Space>mc :w<CR> :!dotnet build<CR>
endfunction 	
autocmd FileType cs call OnCSharpFile()

function! BuffersList()
  let all = range(0, bufnr('$'))
  let res = []
  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor
  return res
endfunction


command! -nargs=0 Cclear call setqflist([]) | cclose

command! -nargs=+ Search call setqflist([]) | call GrepBuffers(<q-args>) | copen

let g:airline_powerline_fonts=1

let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

let g:multi_cursor_exit_from_insert_mode = 0


let g:clang_format#style_options = {
\ "Language" : "Cpp",
\ "AlignEscapedNewlinesLeft" : "true",  
\ "AccessModifierOffset" : -4,
\ "AlignTrailingComments" : "true",
\ "AllowAllParametersOfDeclarationOnNextLine" : "false",
\ "AllowShortBlocksOnASingleLine" : "false",
\ "AllowShortFunctionsOnASingleLine" : "None",  
\ "AllowShortIfStatementsOnASingleLine" : "true",
\ "AlwaysBreakTemplateDeclarations" : "true",
\ "Standard" : "C++11",
\ "BreakBeforeBraces" : "Stroustrup"}

set completeopt -=preview
syntax enable
autocmd FocusLost * call feedkeys("\<esc>")

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'
let NERDTreeMapOpenInTab='<ENTER>'



nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <Space>r <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

set expandtab
set shiftwidth=4
set softtabstop=4

colorscheme xcode_dark

"let g:chromatica#libclang_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

