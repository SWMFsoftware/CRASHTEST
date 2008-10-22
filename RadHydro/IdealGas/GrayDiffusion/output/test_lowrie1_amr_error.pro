openw,99,'test_lowrie1_amr.err'
printf,99,'lowrie test 1'
printf,99,'n error'

resdir='test_lowrie1_amr_results/'
; read the last snapshot
npict=100

filename=resdir+'24/GM/cut_var_2_n0_59.outs' 
.r getpict
printf,99,24,calc_error(w)

filename=resdir+'48/GM/cut_var_2_n0_117.outs' 
.r getpict
printf,99,48,calc_error(w)

filename=resdir+'96/GM/cut_var_2_n0_234.outs' 
.r getpict
printf,99,96,calc_error(w)

filename=resdir+'192/GM/cut_var_2_n0_467.outs' 
.r getpict
printf,99,192,calc_error(w)

close,99

exit
