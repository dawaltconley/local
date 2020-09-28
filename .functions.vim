function Indent(s)
    execute 'setlocal ts='.a:s.' sts='.a:s.' sw='.a:s
endfunction

let s:num = '\v%(%(-|(\d|\.)@<!)%(\d+\.\d+|\d+|\.\d+)|%(\v(\.\d+)@<=\.\d+))\D@='
let s:val = s:num.'\v%(,| )='

function! ShiftSVGPath(type, dx, dy)
    let l:more = 1
    let l:i = 0
    while l:more
        if a:type ==# 'A'
            execute '%s/\vA%('.s:val.'){'.(l:i + 5).'}\zs'.s:num.'/\=(str2float(submatch(0))+a:dx)/ge'
            execute '%s/\vA%('.s:val.'){'.(l:i + 6).'}\zs'.s:num.'/\=(str2float(submatch(0))+a:dy)/ge'
            let l:i += 7
        elseif a:type ==# 'H'
            execute '%s/\vH%('.s:val.'){'.l:i.'}\zs'.s:num.'/\=(str2float(submatch(0))+a:dx)/ge'
            let l:i += 1
        elseif a:type ==# 'V'
            execute '%s/\vV%('.s:val.'){'.l:i.'}\zs'.s:num.'/\=(str2float(submatch(0))+a:dy)/ge'
            let l:i += 1
        else
            execute '%s/\v'.a:type.'%('.s:val.'){'.l:i.'}\zs'.s:num.'/\=(str2float(submatch(0))+a:dx)/ge'
            execute '%s/\v'.a:type.'%('.s:val.'){'.(l:i + 1).'}\zs'.s:num.'/\=(str2float(submatch(0))+a:dy)/ge'
            let l:i += 2
        endif
        let l:more = search('\v'.a:type.'%('.s:val.'){'.l:i.'}'.s:num, 'w')
    endwhile 
endfunction

function! ShiftSVG(dx, dy)
    " Save cursor position
    let l:cursor = winsaveview()
    " Update positioning attributes
    execute '%s/\v\s%(c)=x%(1|2)=\="\zs'.s:num.'/\=(str2float(submatch(0))+a:dx)/ge'
    execute '%s/\v\s%(c)=y%(1|2)=\="\zs'.s:num.'/\=(str2float(submatch(0))+a:dy)/ge'
    " Update paths
    let l:pathtypes = ['M', 'L', 'H', 'V', 'C', 'S', 'Q', 'T', 'A']
    for l:type in l:pathtypes
        call ShiftSVGPath(l:type, a:dx, a:dy)
    endfor
    " Reset cursor position
    call winrestview(l:cursor)
endfunction

function! ScopeInclude()
    let l:v_register = @v
    " Mark top and bottom locations of file
    normal! G
    let l:top = search('{% \=assign global_scope_.\{-} \=%}', 'b')
    if l:top
        execute l:top
        normal! jmt
    else
        normal! ggOmt
    endif
    normal! G
    let l:bottom = search('{% \=assign .\{-}= \=global_scope_.\{-} \=%}', 'bc')
    if l:bottom
        execute l:bottom
        normal! mb
    else
        normal! Gomb
    endif
    " Get all liquid variables in the include
    normal! gg
    let l:vars = []
    while search('{% \=assign \(global_scope_\)\@!\S\{1,} \==.\{-} \=%}', 'zW')
        normal! /{% \=assign \zs\S\{-}\ze \=="vygn
        if index(l:vars, @v) < 0 && !search('global_scope_'.@v, 'nbw')
            let l:vars = l:vars + [@v]
        endif
    endwhile
    normal! gg
    while search('{% \=capture \(global_scope_\)\@<!\S\{1,} \=%}', 'zW')
        normal! /{% \=capture \zs\S\{-}\ze \=%}"vygn
        if index(l:vars, @v) < 0 && !search('global_scope_'.@v, 'nw')
            let l:vars = l:vars + [@v]
        endif
    endwhile
    normal! gg
    while search('{% \=for \(global_scope_\)\@!\S\{1,} in.\{-} \=%}', 'zW')
        normal! /{% \=for \zs\S\{-}\ze in"vygn
        if index(l:vars, @v) < 0 && !search('global_scope_'.@v, 'nw')
            let l:vars = l:vars + [@v]
        endif
    endwhile
    for l:v in l:vars
        let @v = l:v
        normal! 'tO{% assign global_scope_v = v %}
        normal! 'bo{% assign v = global_scope_v %}mb
    endfor
    let @v = l:v_register
    noh
endfunction
