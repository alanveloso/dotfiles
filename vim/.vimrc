call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
call plug#end()

map <F2> :NERDTreeToggle<CR>
map <C-o> :CtrlPBuffer<CR>

set number relativenumber
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
