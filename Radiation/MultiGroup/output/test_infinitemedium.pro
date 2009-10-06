physics='hd11'

; 1. calculate errors, 2. plot errors

resdir='test_infinitemedium_results/'

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'multigroup infinite medium test'
printf,99,'Dt bin1_error bin2_error'

npict=2

filename=resdir+'2/GM/cut*.outs'
.r getpict
printf,99,1.0/2,abs(w(1,1)/w(1,0)-(1-1/exp(1))),abs(w(1,2)/w(1,0)-(1-1/exp(1)))

filename=resdir+'4/GM/cut*.outs'
.r getpict
printf,99,1.0/4,abs(w(1,1)/w(1,0)-(1-1/exp(1))),abs(w(1,2)/w(1,0)-(1-1/exp(1)))

filename=resdir+'8/GM/cut*.outs'
.r getpict
printf,99,1.0/8,abs(w(1,1)/w(1,0)-(1-1/exp(1))),abs(w(1,2)/w(1,0)-(1-1/exp(1)))

close,99

; 3. Create figure for convergence rate

!p.charsize=2

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[0.1,1.0],[1e-4,1e-3],linestyle=2,ystyle=1, $
        xrange=[0.1,1.0],yrange=[1e-4,1e-3],$
        xtitle='time step (arbitrary units)', $
        ytitle='Linf error (at e-folding time)', $
        title="infinite test with two groups"
xyouts,0.5,0.0004,'1st order slope',charsize=2,charthick=1
oplot,wlog(*,0),wlog(*,1),psym=-1,thick=4
oplot,wlog(*,0),wlog(*,2),psym=-2,thick=4
oplot,[0.15],[0.00037],psym=1 & xyouts,0.18,0.00036,'erad1'
oplot,[0.15],[0.00031],psym=2 & xyouts,0.18,0.0003, 'erad2'
close_device,/pdf

exit
