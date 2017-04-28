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
