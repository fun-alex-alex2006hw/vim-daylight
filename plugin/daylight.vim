" Daylight.vim - Chooses your favorite colorschemes based on the time of day
" Maintainer: Dan Friedman
" Version: 0.2

if !exists("*strftime")
    echom "Error: strftime() function required"
    finish
endif

" Global variables {{{

if !exists("g:daylight_prev_window")
    let s:daylight_prev_window = ""
endif

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

function! s:setTermColor(window)
    if a:window ==# "late"
        execute "colorscheme " . g:daylight_late_color_term
    elseif a:window ==# "morning"
        execute "colorscheme " . g:daylight_morning_color_term
    elseif a:window ==# "afternoon"
        execute "colorscheme " . g:daylight_afternoon_color_term
    else
        execute "colorscheme " . g:daylight_evening_color_term
    endif
endfunction

function! s:setGvimColor(window)
    if a:window ==# "late"
        execute "colorscheme " . g:daylight_late_color_gvim
    elseif a:window ==# "morning"
        execute "colorscheme " . g:daylight_morning_color_gvim
    elseif a:window ==# "afternoon"
        execute "colorscheme " . g:daylight_afternoon_color_gvim
    else
        execute "colorscheme " . g:daylight_evening_color_gvim
    endif
endfunction
" }}}

" Re-sets the colorscheme if we've crossed over into a new window
function! Daylight()
    let l:time = strftime("%H")
    let l:window = ""

    " Figure out the time window
    if l:time ># g:daylight_late_hour || l:time <# g:daylight_morning_hour
        let l:window = "late"
    elseif l:time <# g:daylight_afternoon_hour
        let l:window = "morning"
    elseif l:time <# g:daylight_evening_hour
        let l:window = "afternoon"
    elseif l:time <# g:daylight_late_hour
        let l:window = "evening"
    endif

    " Only set the color if we're in a new window
    if l:window != s:daylight_prev_window
        if has("gui_running")
            call s:setGvimColor(l:window)
        else
            call s:setTermColor(l:window)
        endif

        if exists("g:Powerline_loaded")
            execute "silent PowerlineReloadColorscheme"
        endif

        let s:daylight_prev_window = l:window
    endif
endfunction

" Call Daylight() when we open vim, and after some idle time
augroup LoadDaylight
    autocmd!
    autocmd VimEnter * call Daylight()
    autocmd CursorHold * call Daylight()
augroup END

" vim: set fdm=marker:
