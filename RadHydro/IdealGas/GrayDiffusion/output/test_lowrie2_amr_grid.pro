filename='test_lowrie2_amr_results/48/GM/z=0_var_1_n0_130.outs'
func='Rho'
plotmode='contbargrid'
transform='n'
loadct,26

set_plot,'PS'
device,filename='test_lowrie2_amr_gridstart.eps',/color,xsize=24,ysize=6
npict=1
.r getpict
.r plotfunc
close_device

set_plot,'PS'
device,filename='test_lowrie2_amr_gridstop.eps',/color,xsize=24,ysize=6
npict=12
.r getpict
.r plotfunc
close_device

exit
