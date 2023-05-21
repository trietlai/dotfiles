vim.g.barbar_auto_setup = false -- disable auto-setup

require('barbar').setup {
    -- Enable/disable animations
    animation = true,

    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,

    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,

    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = true,

    -- If true, new buffers will be inserted at the end of the list.
    -- Default is to insert after current buffer.
    insert_at_end = false,

    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,

    -- Sets the maximum buffer name length.
    maximum_length = 30,

    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,

    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustement
    -- for other layouts.
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
}

vim.cmd([[
function! My_hi_all(groups)
   for group in a:groups
      call call(function('My_hi'), group)
   endfor
endfunc

function! My_hi_link(pairs)
   for pair in a:pairs
      execute 'hi default link ' . join(pair)
   endfor
endfunc

function! My_hi(name, ...)
   let fg = ''
   let bg = ''
   let attr = ''

   if type(a:1) == 3
      let fg   = get(a:1, 0, '')
      let bg   = get(a:1, 1, '')
      let attr = get(a:1, 2, '')
   else
      let fg   = get(a:000, 0, '')
      let bg   = get(a:000, 1, '')
      let attr = get(a:000, 2, '')
   end

   let has_props = v:false

   let cmd = 'hi default ' . a:name
   if !empty(fg) && fg != 'none'
      let cmd .= ' guifg=' . fg
      let has_props = v:true
   end
   if !empty(bg) && bg != 'none'
      let cmd .= ' guibg=' . bg
      let has_props = v:true
   end
   if !empty(attr) && attr != 'none'
      let cmd .= ' gui=' . attr
      let has_props = v:true
   end
   execute 'hi default clear ' a:name
   if has_props
      execute cmd
   end
endfunc

let fg_target = 'red'

let fg_current  = '#87FF00'
let fg_visible  = '#7AA2F7'
let fg_inactive = '#00f9fd'

let fg_modified = '#FF6059'
let fg_special  = '#b237b6'
let fg_subtle   = '#d8a657'

let bg_current  = '#282828'
let bg_visible  = '#282828'
let bg_inactive = '#282828'

"      Current: current buffer
"      Visible: visible but not current buffer
"     Inactive: invisible but not current buffer
"        -Icon: filetype icon
"       -Index: buffer index
"         -Mod: when modified
"        -Sign: the separator between buffers
"      -Target: letter in buffer-picking mode
" NOTE: have to call multiple times as passing Vim list causing error
call My_hi_all([ ['BufferCurrent',        fg_current,  bg_current] ])
call My_hi_all([ ['BufferCurrentIndex',   fg_special,  bg_current] ])
call My_hi_all([ ['BufferCurrentMod',     fg_modified, bg_current] ])
call My_hi_all([ ['BufferCurrentSign',    fg_special,  bg_current] ])
call My_hi_all([ ['BufferCurrentTarget',  fg_target,   bg_current,   'bold'] ])
call My_hi_all([ ['BufferVisible',        fg_visible,  bg_visible] ])
call My_hi_all([ ['BufferVisibleIndex',   fg_visible,  bg_visible] ])
call My_hi_all([ ['BufferVisibleMod',     fg_modified, bg_visible] ])
call My_hi_all([ ['BufferVisibleSign',    fg_visible,  bg_visible] ])
call My_hi_all([ ['BufferVisibleTarget',  fg_target,   bg_visible,   'bold'] ])
call My_hi_all([ ['BufferInactive',       fg_inactive, bg_inactive] ])
call My_hi_all([ ['BufferInactiveIndex',  fg_subtle,   bg_inactive] ])
call My_hi_all([ ['BufferInactiveMod',    fg_modified, bg_inactive] ])
call My_hi_all([ ['BufferInactiveSign',   fg_subtle,   bg_inactive] ])
call My_hi_all([ ['BufferInactiveTarget', fg_target,   bg_inactive,  'bold'] ])
call My_hi_all([ ['BufferTabpages',       fg_special,  bg_inactive, 'bold'] ])
call My_hi_all([ ['BufferTabpageFill',    fg_inactive, bg_inactive] ])

call My_hi_link([ ['BufferCurrentIcon',  'BufferCurrent'] ])
call My_hi_link([ ['BufferVisibleIcon',  'BufferVisible'] ])
call My_hi_link([ ['BufferInactiveIcon', 'BufferInactive'] ])
call My_hi_link([ ['BufferOffset',       'BufferTabpageFill'] ])

lua require'bufferline.icons'.set_highlights()
]])

