physics='hd33'

; 1. plot results, 2. calculate errors, 3. plot errors

resdir='test_suolson_1d_results/'

; read the reference solutions
filename = resdir+'*_960/GM/cut*.outs'
npict=2
.r getpict
wref0 = w0
wref1 = w1

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'Su-Olson test in 1D'
printf,99,'n radcond_error radiation_error'

; read the last snapshot
npict=2

filename=resdir+'*_80/GM/cut*.outs'
.r getpict
printf,99,80,calc_error(w0,wref0),calc_error(w1,wref1)

filename=resdir+'*_160/GM/cut*.outs'
.r getpict
printf,99,160,calc_error(w0,wref0),calc_error(w1,wref1)

filename=resdir+'*_320/GM/cut*.outs'
.r getpict
printf,99,320,calc_error(w0,wref0),calc_error(w1,wref1)

close,99

; 3. Create a figure of convergence rates                                       
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[2e-3,2e-1],[1e-4,1e-0], $
        xrange=[1e-3,1e-1],yrange=[1e-4,1e-2],$
        linestyle=2,ystyle=1, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Su-Olson test in 1D"
oplot,1/wlog(*,0),wlog(*,1),psym=-4,thick=3
oplot,1/wlog(*,0),wlog(*,2),psym=-5,thick=3
oplot,[2e-3,2e-1],[1e-4,1e-0],linestyle=2,thick=3
xyouts,0.017,0.005,'2nd order slope',charsize=2,charthick=1
oplot,[0.0015],[0.003],psym=4 & xyouts,0.002,0.003,'radcond'
oplot,[0.0015],[0.004],psym=5 & xyouts,0.002,0.004,'radiation'
close_device
spawn,'cd '+resdir+'; ps2pdf error.eps'

exit
