"nmap <leader>r !go install && $GOPATH/bin/%<CR>
nmap <leader>r :w <Bar> !clear && go run %<CR>
nmap <leader>p :w <Bar> !clear && go test %<CR>

command! -range=% -nargs=* Gofmt <line2>,<line2>!go fmt
noremap <F4> :Gofmt<CR>

set noexpandtab
set nu
let g:ale_enabled = 0
