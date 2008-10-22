openw,99,'test_lowrie2_2d.err'
printf,99,'lowrie test 2'
printf,99,'n error'

resdir='test_lowrie2_2d_results/'
; read the last snapshot
npict=100

filename=resdir+'48/GM/cut_var_2_n0_59.outs' 
.r getpict
printf,99,48,calc_error(w)

filename=resdir+'96/GM/cut_var_2_n0_118.outs' 
.r getpict
printf,99,96,calc_error(w)

filename=resdir+'192/GM/cut_var_2_n0_236.outs' 
.r getpict
printf,99,192,calc_error(w)

filename=resdir+'384/GM/cut_var_2_n0_471.outs' 
.r getpict
printf,99,384,calc_error(w)

close,99

exit
