resdir='test_laser_rz_results/'

; 1. plot results for various solvers and resolutions

transform='n'
firstpict=14
npictmax=1
!p.charsize=1.2

; Limit to interesting part of the tube
!x.range=[-150,500]

; Plot all primitive variables
multiplot = [2,5,1]
func     ='level 1/{dx} ux uy zavg rho p pe tikev tekev trkev'
plotmode ='contbar contover contbar contbar contbar contbarlog'
plottitle='level and AMR; ;default'

; logarithmic plot
filename = resdir+'Linde/GM/z*.outs'
set_device,resdir+'laser_rz.eps',/eps,/port
loadct,39
.r animate
close_device, /pdf

exit
