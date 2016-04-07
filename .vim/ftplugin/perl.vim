let b:ctags_command = "ctags -f '%f' -R --exclude='*.js' --languages=-javascript lib interchange"

vmap <leader>w !perl -Ilib -Icustom/lib -wc<CR>
nmap <leader>w :w <Bar> :!perl -Ilib -Icustom/lib -wc %<CR>
vmap <leader>r !perl<CR>
nmap <leader>r :w <Bar> !perl %<CR>
"nmap <leader>st :!prove -v <CR>
