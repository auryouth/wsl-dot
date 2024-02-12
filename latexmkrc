# 1:$pdflatex
# 2:$ps2pdf
# 3:$dvipdf
# 4:$lualatex
# 5:$xelatex and $xdvipdfmx
$pdf_mode=1;

# To set all of $dvilualatex, $latex, $pdflatex, $lualatex, and $xelatex to a common pattern
set_tex_cmds( '-file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 %O %S' );

#$pdf_previewer = 'start "C:/Users/ausosa/scoop/apps/sumatrapdf/current/SumatraPDF.exe" %O %S';

# run a previewer to preview the document
# equivalent to the command 'latexmk -pv'
#$preview_mode = 1;

# Extra extensions of files for latexmk to remove when any of the clean-up options (-c  or  -C) is selected.
$clean_ext = "bbl aux blg idx ind lof lot out toc acn acr alg glg glo gls ist fls log fdb_latexmk bcf run.xml xdv";
