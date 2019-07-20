call plug#begin()
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'rhysd/clever-f.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'mhinz/vim-startify'
	Plug 'hecal3/vim-leader-guide'
	if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
	Plug 'Shougo/deoplete.nvim'
	endif
	"Plug 'arakashic/chromatica.nvim'
	"Plug 'zchee/deoplete-clang'
	Plug 'lervag/vimtex'
call plug#end()

"let g:deoplete#enable_at_startup = 1
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
"noremap <BS> i<BS><ESC>
noremap <silent> <space> :nohlsearch<CR>
noremap <silent> <esc> :nohlsearch<CR>

"Insert Mappings
inoremap <c-\>j <ESC>o
inoremap jj <ESC>

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

	abbreviate cincludes #include <stdio.h>
           \<CR>#include <stdlib.h>
           \<CR>#include <stdint.h>

	abbreviate cmain int main(int Count, char **Args)
            \<CR>{<CR>return EXIT_SUCCESS;<CR>}<UP><UP>

endfunction
autocmd FileType cpp call OnCPPFile() 
autocmd FileType c call OnCPPFile() 

function! OnCmakeFile()
	
	abbreviate cproj project(expand('%:p:h:t'))
				\<CR>add_executable(expand('%:p:h:t'))
	
endfunction 	
autocmd FileType cmake call OnCmakeFile()

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


let g:deoplete#enable_at_startup = 1

let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'

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

let g:chromatica#responsive_mode=1
let g:chromatica#enable_at_startup=1

set completeopt -=preview
syntax enable

call deoplete#custom#var('omni', 'input_patterns', {                       
          \ 'tex': g:vimtex#re#deoplete
          \})
