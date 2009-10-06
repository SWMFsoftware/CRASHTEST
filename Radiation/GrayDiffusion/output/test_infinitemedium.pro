physics='hd11'

; 1. calculate errors, 2. plot errors

resdir='test_infinitemedium_results/'

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'gray-diffusion infinite medium test'
printf,99,'Dt radcond_error radiation_error'

npict=2

filename=resdir+'*_2/GM/cut*.outs'
.r getpict
printf,99,1.0/2,abs(w0(1,1)/w0(1,0)-(1-1/exp(1))),abs(w1(1,1)/w1(1,0)-(1-1/exp(1)))
filename=resdir+'*_4/GM/cut*.outs'
.r getpict
printf,99,1.0/4,abs(w0(1,1)/w0(1,0)-(1-1/exp(1))),abs(w1(1,1)/w1(1,0)-(1-1/exp(1)))
filename=resdir+'*_8/GM/cut*.outs'
.r getpict
printf,99,1.0/8,abs(w0(1,1)/w0(1,0)-(1-1/exp(1))),abs(w1(1,1)/w1(1,0)-(1-1/exp(1)))
close,99

; 3. Create figure for convergence rate

!p.charsize=2

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[0.1,1.0],[1.5e-4,1.5e-3],linestyle=2,ystyle=1, $
        xrange=[0.1,1.0],yrange=[1e-4,1e-3],$
        xtitle='time step (arbitrary units)', $
        ytitle='absolute error (at e-folding time)', $
        title="gray-diffusion infinite medium test"
xyouts,0.3,0.0004,'1st order slope',charsize=2,charthick=1
oplot,wlog(*,0),wlog(*,1),psym=-1,thick=4
oplot,wlog(*,0),wlog(*,2),psym=-2,thick=4
oplot,[0.45],[0.00026],psym=1 & xyouts,0.48,0.00025,'radcond: erad'
oplot,[0.45],[0.00021],psym=2 & xyouts,0.48,0.0002, 'radiation: erad'
close_device,/pdf

exit
