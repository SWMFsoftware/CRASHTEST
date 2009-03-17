5Bphysics='hd33'

; 1. plot results, 2. calculate errors, 3. plot errors

resdir='test_suolson_1d_results/'

; read the reference solution
filename = resdir+'960/GM/cut*.outs'
npict=2
.r getpict
wref = w

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'Su-Olson test in 1D'
printf,99,'n error'

; read the last snapshot
npict=2

filename=resdir+'80/GM/cut*.outs'
.r getpict
printf,99,80,calc_error(w,wref)

filename=resdir+'160/GM/cut*.outs'
.r getpict
printf,99,160,calc_error(w,wref)

filename=resdir+'320/GM/cut*.outs'
.r getpict
printf,99,320,calc_error(w,wref)

close,99

; 3. Create a figure of convergence rates                                       
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-4,1e-2],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Su-Olson test in 1D"
oplot,[2e-3,2e-1],[1e-4,1e-0],linestyle=2,thick=3
xyouts,0.017,0.005,'2nd order slope',charsize=2,charthick=1
close_device
spawn,'cd '+resdir+'; ps2pdf error.eps'

exit
