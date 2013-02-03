" Daylight.vim - Chooses your favorite colorschemes based on the time of day
" Maintainer: Dan Friedman
" Version: 1.0

if !exists("*strftime")
    echom "Error: strftime() function required"
    finish
endif

if !has("python")
    echom "Error: Vim must be compiled with +python"
endif

" Global variables {{{
if !exists("g:daylight_late_color_gvim")
    let g:daylight_late_color_gvim = "default"
endif

if !exists("g:daylight_morning_color_gvim")
    let g:daylight_morning_color_gvim = "default"
endif

if !exists("g:daylight_afternoon_color_gvim")
    let g:daylight_afternoon_color_gvim = "default"
endif

if !exists("g:daylight_evening_color_gvim")
    let g:daylight_evening_color_gvim = "default"
endif



if !exists("g:daylight_late_color_term")
    let g:daylight_late_color_term = "default"
endif

if !exists("g:daylight_morning_color_term")
    let g:daylight_morning_color_term = "default"
endif

if !exists("g:daylight_afternoon_color_term")
    let g:daylight_afternoon_color_term = "default"
endif

if !exists("g:daylight_evening_color_term")
    let g:daylight_evening_color_term = "default"
endif
 


if !exists("g:daylight_late_hour")
    let g:daylight_late_hour = 22
endif

if !exists("g:daylight_morning_hour")
    let g:daylight_morning_hour = 6
endif

if !exists("g:daylight_afternoon_hour")
    let g:daylight_afternoon_hour = 12
endif

if !exists("g:daylight_evening_hour")
    let g:daylight_evening_hour = 18
endif
" }}}

" Helper functions {{{

function! s:setTermColor(time)
    if a:time ># g:daylight_late_hour || a:time <# g:daylight_morning_hour
        execute "colorscheme " . g:daylight_late_color_term
    elseif a:time <# g:daylight_afternoon_hour
        execute "colorscheme " . g:daylight_morning_color_term
    elseif a:time <# g:daylight_evening_hour
        execute "colorscheme " . g:daylight_afternoon_color_term
    elseif a:time <# g:daylight_late_hour
        execute "colorscheme " . g:daylight_evening_color_term
    endif
endfunction

function! s:setGvimColor(time)
    if a:time ># g:daylight_late_hour || a:time <# g:daylight_morning_hour
        execute "colorscheme " . g:daylight_late_color_gvim
    elseif a:time <# g:daylight_afternoon_hour
        execute "colorscheme " . g:daylight_morning_color_gvim
    elseif a:time <# g:daylight_evening_hour
        execute "colorscheme " . g:daylight_afternoon_color_gvim
    elseif a:time <# g:daylight_late_hour
        execute "colorscheme " . g:daylight_evening_color_gvim
    endif
endfunction
" }}}

function! Daylight()
    let l:time = strftime("%H")

    if has("gui_running")
        call s:setGvimColor(l:time)
    else
        call s:setTermColor(l:time)
    endif
endfunction

augroup ReloadDaylight
    au!
    " TODO: Make this comprehensive
    au BufRead,BufWrite,BufEnter,BufNew,FocusGained,CursorHold,WinEnter call DayLight()
augroup END

" vim: set fdm=marker:
