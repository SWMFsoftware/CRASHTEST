; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_3d_ray_results/'

!p.charsize=2
!p.charthick=1
bottomline=0
loadct,39

filename=resdir+'1/GM/z*1.out'
.r getpict
set_device, resdir + 'single_ray.eps', /eps
func='{elaser}*y>1e-6
plottitle="log(laser energy deposition)"
plotmode='contbarlog
.r animate
close_device,/pdf

exit
