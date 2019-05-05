call plug#begin()

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'euclio/vim-markdown-composer'
Plug 'rhysd/clever-f.vim'
Plug 'junegunn/goyo.vim'
Plug 'ervandew/supertab'

call plug#end()

set relativenumber 

map <silent> <Space>ft :NERDTreeToggle<CR>
map <silent> <Space>fs :w<CR>
 
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap <Bslash>j o<ESC>
nnoremap <Bslash>k O<ESC>

inoremap <c-\>j <ESC>o

inoremap jj <ESC>


noremap <silent> <space> :nohlsearch<CR>
noremap <silent> <esc> :nohlsearch<CR>


noremap <silent> <space>wc :Goyo<CR>
