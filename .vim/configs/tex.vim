
" IMPORTANT: grep will sometimes skip displaying the file name if you search in a singe file. This will confuse Latex-Suite. Set your grep program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='pdflatex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode -fmt pdflatex $*'
"let g:Tex_ViewRule_pdf='Document Viewer'
let g:Tex_CustomTemplateDirectory='$HOME/.vim/templates/latex'

" Instead of using ,ll which might be broken for some reason, use ,lc instead, which runs the correct compile rule where ,ll was not for some reason
nnoremap <leader>lc :!pdflatex -interaction=nonstopmode -fmt pdflatex %<CR>
