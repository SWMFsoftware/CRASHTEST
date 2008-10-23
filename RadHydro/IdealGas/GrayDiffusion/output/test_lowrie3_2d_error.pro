openw,99,'test_lowrie3_2d.err'
printf,99,'lowrie test 3'
printf,99,'n error'

resdir='test_lowrie3_2d_results/'
; read the last snapshot
npict=100

filename=resdir+'100/GM/cut_var_2_n0_80.outs'
.r getpict
printf,99,100,calc_error(w)

filename=resdir+'200/GM/cut_var_2_n0_160.outs'
.r getpict
printf,99,200,calc_error(w)

filename=resdir+'400/GM/cut_var_2_n0_319.outs'
.r getpict
printf,99,400,calc_error(w)

filename=resdir+'800/GM/cut_var_2_n0_637.outs'
.r getpict
printf,99,800,calc_error(w)

close,99

exit
