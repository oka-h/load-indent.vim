" ------------------------------------------------------------------------------
" loadindent.vim
" ------------------------------------------------------------------------------

if exists('g:loaded_loadindent')
    finish
endif
let g:loaded_loadindent = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:loadindent#indent_candidates')
    let g:loadindent#indent_candidates = [2, 3, 4, 8]
endif

if !exists('g:loadindent#max_read_lines')
    let g:loadindent#max_read_lines = 300
endif

augroup loadindent
    autocmd!
    autocmd BufRead * call s:load_indent_setting()
augroup END

function! s:load_indent_setting() abort
    let l:indent_count = {}
    for l:width in g:loadindent#indent_candidates
        let l:indent_count[l:width] = 0
    endfor

    let l:pre_sp_width = 0
    for l:line in readfile(expand('%'), '', g:loadindent#max_read_lines)
        if l:line !~# '\S'
            continue
        endif
        if l:line =~# '^\t'
            setlocal noexpandtab
            return
        endif

        let l:sp_width = len(substitute(l:line, '^ *\zs[^ ].*$', '', ''))
        let l:sp_diff = abs(l:sp_width - l:pre_sp_width)
        if has_key(l:indent_count, l:sp_diff)
            let l:indent_count[l:sp_diff] += 1
            let l:pre_sp_width = l:sp_width
        endif
    endfor

    let l:max_count = max(l:indent_count)
    if l:max_count > 0
        setlocal expandtab
        for l:width in sort(keys(l:indent_count))
            if l:indent_count[l:width] == l:max_count
                let &shiftwidth = l:width
                let &tabstop    = l:width
                break
            endif
        endfor
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
