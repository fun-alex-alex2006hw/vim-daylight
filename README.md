vim-daylight
============

Vim plugin to choose your colorscheme based on the time of day

Still under development -- TODO below for project goals

Installation
------------
I recommend using [Pathogen](https://github.com/tpope/vim-pathogen) or
[Vundle](https://github.com/gmarik/vundle) to manage your plugins.

* Pathogen:

        git clone https://github.com/gmarik/vundle ~/.vim/bundle/vim-daylight

* Vundle:
  Add the following to your .vimrc:

        Bundle 'daf-/vim-daylight'

  Then launch vim and run

        :BundleInstall

Settings
--------
For now, you need to specify four themes corresponding to the following times
of day: morning, afternoon, evening, and late night for terminal and gvim
accordingly. For example:

    let g:daylight_morning_color_gvim = "Tomorrow"
    let g:daylight_afternoon_color_gvim = "solarized"
    let g:daylight_evening_color_gvim = "Tomorrow-Night"
    let g:daylight_late_color_gvim = "jellybeans"

    let g:daylight_morning_color_term = "Tomorrow"
    let g:daylight_afternoon_color_term = "mayansmoke"
    let g:daylight_evening_color_term = "Tomorrow-Night"
    let g:daylight_late_color_term = "jellybeans"

You may also specify the starting times - the hours at which the morning,
afternoon, evening, and late night phases each begin. For example:

    let g:daylight_morning_hour = 8 " after 6am, the morning colorscheme is applied

By default, the values are defined as follows:

    let g:daylight_late_hour = 22
    let g:daylight_morning_hour = 6
    let g:daylight_afternoon_hour = 12
    let g:daylight_evening_hour = 18


TODO
----
* Place the Daylight() function in a loop, which will re-check the time of day
  every 5 or 10 minutes (or some arbitrary constant)
* Shorten variable names
