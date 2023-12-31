
resdir='test_tube_rz_results/'
; 1. plot results for various options 

filename=resdir+'tube_rz/GM/los*.out'
func='cube10 rho rhoxe rhobe rhopl rho-{rhoxe}-{rhobe}-{rhopl}'
plotmode='contbar
bottomline=0
set_device, resdir + 'tube_rz_los.eps', /eps, /port
loadct,39
.r animate
close_device,/pdf

filename=resdir+'tube_rz/GM/z*.out'
func='rho rhoxe rhobe rhopl rho-{rhoxe}-{rhobe}-{rhopl}'
set_device, resdir + 'tube_rz_z0cut.eps', /eps, /port
loadct,39
.r animate
close_device,/pdf

exit
