set ts=4 sw=4 ai cul nu rnu mps+=<:> hls noswf so=8 bg=dark
syntax on
let mapleader=" "
vnoremap <leader>y "+y
nnoremap <leader>s :s/\<<C-r><C-w>\>//gc<Left><Left><Left>
noremap x "_x
vnoremap x "_x
autocmd TextChanged,TextChangedI * silent! write
colorscheme habamax
nnoremap <esc> :noh<CR>
