; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_uniform_2d_results/'

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'uniform heat conduction test in 2D'
printf,99,'n error'

; read the last snapshot 
npict=100

filename=resdir+'100/GM/z*.outs'
.r getpict
printf,99,100,calc_error(w)

filename=resdir+'200/GM/z*.outs'
.r getpict
printf,99,200,calc_error(w)

filename=resdir+'400/GM/z*.outs'
.r getpict
printf,99,400,calc_error(w)

;filename=resdir+'800/GM/z*.outs'
;.r getpict
;printf,99,800,calc_error(w)

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-2],yrange=[1e-7,1e-4],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="uniform heat conduction test in rz geometry"
oplot,[1e-3,1e-2],[1e-7,1e-5],linestyle=2,thick=3
xyouts,0.002,0.0000003,'2nd order slope',charsize=2,charthick=1
close_device
spawn,'cd '+resdir+'; ps2pdf error.eps'

exit