; 1. plot results, 2. calculate errors, 3. plot errors

transform='n

; 1. plot results for various solvers and resolutions
resdir='test_uniform_2d_amr_results/'


; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'uniform heat conduction test in 2D'
printf,99,'n error'

; read the last snapshot 
npict=100

filename=resdir+'90/GM/z*.outs'
.r getpict
printf,99,90,calc_error(w)

filename=resdir+'180/GM/z*.outs'
.r getpict
printf,99,180,calc_error(w)

filename=resdir+'360/GM/z*.outs'
.r getpict
printf,99,360,calc_error(w)

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-7,1e-4],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="uniform heat conduction in rz-geometry"
oplot,[1e-3,1e-1],[1e-7,1e-3],linestyle=2,thick=3
xyouts,0.002,0.0000003,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

exit
