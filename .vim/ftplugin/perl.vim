let b:ctags_command = "ctags -f '%f' -R --exclude='*.js' --languages=-javascript lib"

setlocal keywordprg=sh\ -c\ 'perldoc\ -f\ \$1\ \|\|\ perldoc\ \$1'\ --

" syntax
vmap <leader>w !perl -Ilib -Icustom/lib -wc<CR>
nmap <leader>w :w <Bar> !clear && perl -Ilib -Icustom/lib -wc %<CR>

" run
vmap <leader>r !perl<CR>
nmap <leader>r :w <Bar> !clear && perl %<CR>

" run with Dwarn
vmap <leader>d !perl -MDevel::Dwarn<CR>
nmap <leader>d :w <Bar> !clear && perl -MDevel::Dwarn %<CR>

" critic
nmap <leader>c :w <Bar> !clear && perlcritic %<CR>

command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy
noremap <F4> :Tidy<CR>

let perl_sub_signatures = 1
