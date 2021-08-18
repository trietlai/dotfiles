vim.g.asciidoctor_extensions = {'asciidoctor-diagram', 'asciidoctor-rouge'}
vim.g.asciidoctor_pdf_extensions = {'asciidoctor-diagram', 'asciidoctor-rouge'}
vim.g.asciidoctor_fenced_languages = {'python', 'c', 'java', 'shell'}
vim.g.asciidoctor_img_paste_command = 'xclip -selection clipboard -t image/png -o > %s%s'
vim.g.asciidoctor_img_paste_pattern = 'img_%s_%s.png'

vim.cmd([[
" Function to create buffer local mappings and add default compiler
fun! AsciidoctorMappings()
    nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
    nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
    nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR>
    nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
    nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
    nnoremap <buffer> <leader>cp :Asciidoctor2PDF<CR>
    nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>
    nnoremap <buffer> <leader>p :AsciidoctorPasteImage<CR>
    " :make will build pdfs
    compiler asciidoctor2pdf
endfun
" Call AsciidoctorMappings for all `*.adoc` and `*.asciidoc` files
augroup asciidoctor
    au!
    au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
augroup END
func! AsciidoctorHighlight()
    " Highlight asciidoctor syntax with colors you like.
    " For solarized8 colorscheme
    if get(g:, "colors_name", "default") == "solarized8"
        hi asciidoctorTitle guifg=#ff0000 gui=bold ctermfg=red cterm=bold
        hi asciidoctorOption guifg=#00ff00 ctermfg=green
        hi link asciidoctorH1 Directory
    elseif get(g:, "colors_name", "default") == "default"
        hi link asciidoctorIndented PreProc
    endif
endfunc
augroup ASCIIDOCTOR_COLORS | au!
    au Colorscheme * call AsciidoctorHighlight()
    au BufNew,BufRead *.adoc call AsciidoctorHighlight()
augroup end
]])

