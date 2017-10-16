let g:testfile = 't/' . tolower(substitute(substitute(substitute(escape(expand("%:."),' '),'lib/','',''),'custom/[A-Z]*/','',''),'\.pm$','.t',''))

function! Prove ( verbose )
    let s:params = " "
    if a:verbose
        let s:params = s:params . " -v "
    endif
    execute "!prove -Ilib -Icustom/lib" . s:params . g:testfile
endfunction

nmap <leader>p :call Prove (0)<cr>
