require'lightspeed'.setup {
    jump_to_first_match                    = true,
    jump_on_partial_input_safety_timeout   = 400,
    highlight_unique_chars                 = false,
    grey_out_search_area                   = true,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches                       = 5,
    full_inclusive_prefix_key              = '<c-x>',
}

function repeat_ft(reverse)
    local ls = require'lightspeed'
    ls.ft['instant-repeat?'] = true
    ls.ft:to(reverse, ls.ft['prev-t-like?'])
end

local map = vim.api.nvim_set_keymap

map('n', ';', '<cmd>lua repeat_ft(false)<cr>', {noremap = true, silent = true})
map('x', ';', '<cmd>lua repeat_ft(false)<cr>', {noremap = true, silent = true})
-- ',' is not used very often so leave it for other bindings
-- map('n', ',', '<cmd>lua repeat_ft(true)<cr>', {noremap = true, silent = true})
-- map('x', ',', '<cmd>lua repeat_ft(true)<cr>', {noremap = true, silent = true})

