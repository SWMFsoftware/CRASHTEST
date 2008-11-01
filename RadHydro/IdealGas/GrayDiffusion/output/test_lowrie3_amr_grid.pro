filename='test_lowrie3_amr_results/96/GM/z=0_var_1_n0_109.outs'
func='Trad'
physics='hd33'
plotmode='contbargrid'
transform='n'
loadct,26

set_plot,'PS'
device,filename='test_lowrie3_amr_gridstart.eps',/color,xsize=24,ysize=6
npict=1
.r getpict
.r plotfunc
close_device

set_plot,'PS'
device,filename='test_lowrie3_amr_gridstop.eps',/color,xsize=24,ysize=6
npict=11
.r getpict
.r plotfunc
close_device

exit
