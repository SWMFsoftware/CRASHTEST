; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_3d_ray_amr_results/'

!p.charsize=2
!p.charthick=1
bottomline=0
loadct,39

filename=resdir+'1/GM/z*1.out'
.r getpict
set_device, resdir + 'single_ray.eps', /eps
func='{elaser}*y>1e-6
plottitle="log(laser energy deposition)"
plotmode='contbarloggrid
.r animate
close_device,/pdf

logfilename = resdir + 'error.dat'

set_device, resdir + 'error_turning_point.eps', /eps
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[0.1,1.0],yrange=[1e-5,1e-2],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='absolute error', $
        title="turning point error"
oplot,[0.1,1.0],[2e-5,2e-3],linestyle=2,thick=3
xyouts,0.3,0.0001,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

set_device, resdir + 'error_energy_deposition.eps', /eps
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,2)),xrange=[0.1,1.0],yrange=[5e-5,1e-3],$
        psym=-4,charsize=2,thick=3, ystyle=1, $
        xtitle='Grid resolution', $
        ytitle='absolute error', $
        title="energy deposition error"
oplot,[0.1,1.0],[5e-5,5e-4],linestyle=2,thick=3
xyouts,0.15,0.00006,'1st order slope',charsize=2,charthick=1
close_device,/pdf

exit
