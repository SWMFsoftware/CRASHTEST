openw,99,'test_lowrie3_amr.err'
printf,99,'lowrie test 3'
printf,99,'n error'

resdir='test_lowrie3_amr_results/'
physics='hd33'
; read the last snapshot
npict=100

filename=resdir+'96/GM/cut_var_2_n0_109.outs'
.r getpict
printf,99,96,calc_error(w)

filename=resdir+'192/GM/cut_var_2_n0_218.outs'
.r getpict
printf,99,192,calc_error(w)

filename=resdir+'384/GM/cut_var_2_n0_435.outs'
.r getpict
printf,99,384,calc_error(w)

filename=resdir+'768/GM/cut_var_2_n0_870.outs'
.r getpict
printf,99,768,calc_error(w)

close,99

exit
