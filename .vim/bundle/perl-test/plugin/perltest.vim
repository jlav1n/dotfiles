let g:testfile = 't/' . tolower(substitute(escape(expand("%:t"),' '),'\.pm$','.t',''))

function! Prove ( verbose )
    let s:params = " "
    if a:verbose
        let s:params = s:params . " -v "
    endif
    execute "!/home/camp/.plenv/shims/prove -Ilib -Icustom/lib" . s:params . g:testfile
endfunction

nmap <leader>p :call Prove (0)<cr>
