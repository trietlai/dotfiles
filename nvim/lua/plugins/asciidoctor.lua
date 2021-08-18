vim.g.asciidoctor_extensions = {'asciidoctor-diagram', 'asciidoctor-rouge'}
vim.g.asciidoctor_pdf_extensions = {'asciidoctor-diagram', 'asciidoctor-rouge'}
vim.g.asciidoctor_fenced_languages = {'python', 'c', 'java', 'shell'}
vim.g.asciidoctor_img_paste_command = 'xclip -selection clipboard -t image/png -o > %s%s'
vim.g.asciidoctor_img_paste_pattern = 'img_%s_%s.png'
vim.g.asciidoctor_fold_options = 1
vim.g.asciidoctor_folding = 1

vim.cmd([[
" Function to create buffer local mappings and add default compiler
fun! AsciidoctorMappings()
    nnoremap <buffer> <localleader>oo :AsciidoctorOpenRAW<CR>
    nnoremap <buffer> <localleader>op :AsciidoctorOpenPDF<CR>
    nnoremap <buffer> <localleader>oh :AsciidoctorOpenHTML<CR>
    nnoremap <buffer> <localleader>ox :AsciidoctorOpenDOCX<CR>
    nnoremap <buffer> <localleader>ch :Asciidoctor2HTML<CR>
    nnoremap <buffer> <localleader>cp :Asciidoctor2PDF<CR>
    nnoremap <buffer> <localleader>cx :Asciidoctor2DOCX<CR>
    nnoremap <buffer> <localleader>p :AsciidoctorPasteImage<CR>
    nmap <buffer> <localleader><tab> <Plug>(AsciidoctorFold)
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
    hi asciidoctorTitle guifg=#ff0000 gui=bold ctermfg=red cterm=bold
    hi asciidoctorOption guifg=#00ff00 ctermfg=green
    hi link asciidoctorH1 '#f1fa8c'
    hi link asciidoctorIndented PreProc
endfunc
augroup ASCIIDOCTOR_COLORS | au!
    au Colorscheme * call AsciidoctorHighlight()
    au BufNew,BufRead *.adoc call AsciidoctorHighlight()
augroup end
]])

