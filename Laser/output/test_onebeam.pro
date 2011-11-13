; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_onebeam_results/'

!p.charsize=2
!p.charthick=1
bottomline=0
loadct,39

filename=resdir+'1/GM/z=0_var_1_t000.0010_n0000001.out'
.r getpict
set_device, resdir + 'single_ray.eps', /eps
func='{elaser}>1e-6
plottitle="log(laser energy deposition)"
plotmode='contbarlog
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
oplot,[0.1,1.0],[1e-5,1e-3],linestyle=2,thick=3
xyouts,0.3,0.00006,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

set_device, resdir + 'error_energy_deposition.eps', /eps
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,2)),xrange=[0.1,1.0],yrange=[8e-5,1e-3],$
        psym=-4,charsize=2,thick=3, ystyle=1, $
        xtitle='Grid resolution', $
        ytitle='absolute error', $
        title="energy deposition error"
oplot,[0.1,1.0],[1e-4,1e-3],linestyle=2,thick=3
xyouts,0.15,0.0003,'1st order slope',charsize=2,charthick=1
close_device,/pdf

exit
