" Daylight.vim - Chooses your favorite colorschemes based on the time of day
" Maintainer: Dan Friedman
" Version: 1.0

if !exists("*strftime")
    echom "Error: strftime() function required"
    finish
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
    let g:daylight_late_hour = 4
endif

if !exists("g:daylight_morning_hour")
    let g:daylight_morning_hour = 12
endif

if !exists("g:daylight_afternoon_hour")
    let g:daylight_afternoon_hour = 18
endif

if !exists("g:daylight_evening_hour")
    let g:daylight_evening_hour = 22
endif
" }}}

" Helper functions {{{

" Chooses colorscheme when g:daylight_term is set
function! s:setTermColor()
    let l:time = strftime("%H")

    if l:time ># g:daylight_evening_hour || l:time <# g:daylight_late_hour
        execute "colorscheme " . g:daylight_late_color_term
    elseif l:time <# g:daylight_morning_hour
        execute "colorscheme " . g:daylight_morning_color_term
    elseif l:time <# g:daylight_afternoon_hour
        execute "colorscheme " . g:daylight_afternoon_color_term
    elseif l:time <# g:daylight_evening_hour
        execute "colorscheme " . g:daylight_evening_color_term
    endif
endfunction

function! s:setGvimColor()
    let l:time = strftime("%H")

    if l:time ># g:daylight_evening_hour || l:time <# g:daylight_late_hour
        execute "colorscheme " . g:daylight_late_color_gvim
    elseif l:time <# g:daylight_morning_hour
        execute "colorscheme " . g:daylight_morning_color_gvim
    elseif l:time <# g:daylight_afternoon_hour
        execute "colorscheme " . g:daylight_afternoon_color_gvim
    elseif l:time <# g:daylight_evening_hour
        execute "colorscheme " . g:daylight_evening_color_gvim
    endif
endfunction
" }}}

function! Daylight()
    if has("gui_running")
        call s:setGvimColor()
    else
        call s:setTermColor()
    endif
endfunction

call Daylight()
" vim: set fdm=marker:
