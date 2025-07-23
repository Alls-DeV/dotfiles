set ts=4 sw=4 ai cul nu rnu mps+=<:> hls noswf so=8 bg=dark
syntax on
let mapleader=" "
vnoremap <leader>y "+y
nnoremap <leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
noremap x "_x
vnoremap x "_x
autocmd TextChanged,TextChangedI * silent! write
colorscheme habamax
nnoremap <esc> :noh<CR>
nnoremap <leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>


"statusline
set laststatus=2
set statusline=
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
