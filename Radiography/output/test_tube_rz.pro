
resdir='test_tube_rz_results/'
; 1. plot results for various options 

filename=resdir+'tube_rz/GM/los*.out'
func='cube10 rho rhoxe rhobe rhopl rho-{rhoxe}-{rhobe}-{rhopl}'
plotmode='contbar
bottomline=0
set_device, resdir + 'tube_rz_los.eps', /eps, /port
loadct,39
.r animate
close_device
spawn,'cd '+resdir+'; convert tube_rz_los.eps tube_rz_los.pdf'

filename=resdir+'tube_rz/GM/?=*.out'
func='rho rhoxe rhobe rhopl rho-{rhoxe}-{rhobe}-{rhopl}'
set_device, resdir + 'tube_rz_cuts.eps', /eps, /port
loadct,39
.r animate
close_device
spawn,'cd '+resdir+'; convert tube_rz_cuts.eps tube_rz_cuts.pdf'

exit
