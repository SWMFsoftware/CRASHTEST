physics='hd11'

; 1. calculate errors, 2. plot errors

resdir='test_infinitemedium_results/'

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'gray-diffusion infinite medium test'
printf,99,'Dt radiation_error'

npict=2

filename=resdir+'*_2/GM/cut*.outs'
.r getpict
printf,99,1.0/2,abs(w(1,2)/w(1,1)-(1-1/exp(1)))
filename=resdir+'*_4/GM/cut*.outs'
.r getpict
printf,99,1.0/4,abs(w(1,2)/w(1,1)-(1-1/exp(1)))
filename=resdir+'*_8/GM/cut*.outs'
.r getpict
printf,99,1.0/8,abs(w(1,2)/w(1,1)-(1-1/exp(1)))
close,99

; 3. Create figure for convergence rate

!p.charsize=2

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[0.1,1.0],[1e-3,1e-1],linestyle=2,ystyle=1, $
        xrange=[0.1,1.0],yrange=[1e-3,1e-1],$
        xtitle='time step (arbitrary units)', $
        ytitle='absolute error (at e-folding time)', $
        title="gray-diffusion uniform medium test"
xyouts,0.3,0.006,'2nd order slope',charsize=2,charthick=1
oplot,wlog(*,0),wlog(*,1),psym=-4,thick=4
oplot,[0.45],[0.0021],psym=4 & xyouts,0.48,0.002, 'radiation: erad'
close_device,/pdf

exit
