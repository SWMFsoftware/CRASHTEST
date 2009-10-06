physics='hd11'

; 1. calculate errors, 2. plot errors

resdir='test_infinitemedium_results/'

; 1. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'multigroup infinite medium test'
printf,99,'Dt bin1_error bin2_error'

npict=2

filename=resdir+'2/GM/cut*.outs'
.r getpict
printf,99,1.0/2,abs(w(1,2)/w(1,1)-(1-1/exp(1))),abs(w(1,3)/w(1,1)-(1-1/exp(1)))

filename=resdir+'4/GM/cut*.outs'
.r getpict
printf,99,1.0/4,abs(w(1,2)/w(1,1)-(1-1/exp(1))),abs(w(1,3)/w(1,1)-(1-1/exp(1)))

filename=resdir+'8/GM/cut*.outs'
.r getpict
printf,99,1.0/8,abs(w(1,2)/w(1,1)-(1-1/exp(1))),abs(w(1,3)/w(1,1)-(1-1/exp(1)))

close,99

; 2. Create figure for convergence rate

!p.charsize=2

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[0.1,1.0],[3e-5,3e-4],linestyle=2,ystyle=1, $
        xrange=[0.1,1.0],yrange=[1e-5,1e-3],$
        xtitle='time step (arbitrary units)', $
        ytitle='absolute error (at e-folding time)', $
        title="uniform medium test with two groups"
xyouts,0.5,0.0001,'1st order slope',charsize=2,charthick=1
oplot,wlog(*,0),wlog(*,1),psym=-1,thick=4
oplot,wlog(*,0),wlog(*,2),psym=-4,thick=4
oplot,[0.12],[0.00075],psym=1 & xyouts,0.13,0.0007,'erad1'
oplot,[0.12],[0.00055],psym=4 & xyouts,0.13,0.0005,'erad2'
close_device,/pdf

exit
