" run
nmap <leader>r :w <Bar> GoRun<CR>
"nmap <leader>r <Plug>(go-run)

" lint
nmap <leader>w <Plug>(go-lint)

" all possible linters
nmap <leader>c <Plug>(go-metalinter)

" build
nmap <leader>b <Plug>(go-build)

" run test
nmap <leader>p <Plug>(go-test)

command! -range=% -nargs=* Gofmt <line2>,<line2>GoFmt
noremap <F4> :Gofmt<CR>

set noexpandtab
set nu

setlocal keywordprg=go\ doc\ \$1
