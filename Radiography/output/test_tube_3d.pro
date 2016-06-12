; 1. plot results, 2. calculate errors, 3. plot errors

resdir='test_tube_3d_results/'
; 1. plot results for various options 

filename=resdir+'tube_/GM/los*.out'
func='cube10 rho rhoxe rhobe rhopl rho-{rhoxe}-{rhobe}-{rhopl}'
plotmode='contbar
bottomline=0
set_device, resdir + 'tube_los.eps', /eps, /port
loadct,39
.r animate
close_device,/pdf


filename=resdir+'tube_/GM/?=*.out'
func='rho rhoxe rhobe rhopl rho-{rhoxe}-{rhobe}-{rhopl}'
set_device, resdir + 'tube_cuts.eps', /eps, /port
loadct,39
.r animate
close_device,/pdf

exit
