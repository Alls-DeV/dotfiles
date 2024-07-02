set ts=4 sw=4 ai cul nu rnu mps+=<:> hls noswf so=8

let mapleader=" "
vnoremap <leader>y "+y
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

vnoremap > >gv
vnoremap < <gv

nnoremap x "_x
vnoremap x "_x

nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <C-q> :bd<CR>

autocmd TextChanged,TextChangedI * silent! write

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
	Plug 'sainnhe/everforest'
	Plug 'sheerun/vim-polyglot'
    Plug 'lilydjwg/colorizer'
call plug#end()
set termguicolors bg=dark
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
colorscheme everforest
