set ts=4 sw=4 ai cul nu rnu mps+=<:> hls noswf so=8
let mapleader=" "
vnoremap <leader>y "+y
nnoremap <leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap > >gv
vnoremap < <gv
nnoremap x "_x
vnoremap x "_x
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <leader>q :bd<CR>
autocmd TextChanged,TextChangedI * silent! write
colorscheme habamax
syntax on
