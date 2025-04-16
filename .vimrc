set ts=4 sw=4 ai cul nu rnu mps+=<:> hls noswf so=8 
syntax on
let mapleader=" "
vnoremap <leader>y "+y
nnoremap <leader>s :s/\<<C-r><C-w>\>//gc<Left><Left><Left>
noremap x "_x
vnoremap x "_x
autocmd TextChanged,TextChangedI * silent! write
colorscheme retrobox
nnoremap <leader>b :ls<CR>:b<space>
nnoremap <esc> :noh<CR>
