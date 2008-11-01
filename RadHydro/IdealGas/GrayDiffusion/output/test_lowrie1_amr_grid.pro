filename='test_lowrie1_amr_results/48/GM/z=0_var_1_n0_117.outs'
func='Rho'
plotmode='contbargrid'
transform='n'
loadct,26

set_plot,'PS'
device,filename='test_lowrie1_amr_gridstart.eps',/color,xsize=24,ysize=11
npict=1
.r getpict
.r plotfunc
close_device

set_plot,'PS'
device,filename='test_lowrie1_amr_gridstop.eps',/color,xsize=24,ysize=11
npict=8
.r getpict
.r plotfunc
close_device

exit
