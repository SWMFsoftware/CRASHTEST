physics='hd11'

; 1. calculate errors, 2. plot errors

resdir='test_planckian_results/'

; 1. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'80 group infinite medium test'
printf,99,'Dt absolute_error '

npict=2
filename=resdir+'2/GM/planckian.outs'
.r getpict
error = abs(w(*,0)/w(*,1)-(1-1/exp(1)))
printf,99,1.0/2,max(error)
filename=resdir+'4/GM/planckian.outs'
.r getpict
error = abs(w(*,0)/w(*,1)-(1-1/exp(1)))
printf,99,1.0/4,max(error)
filename=resdir+'8/GM/planckian.outs'
.r getpict
error = abs(w(*,0)/w(*,1)-(1-1/exp(1)))
printf,99,1.0/8,max(error)

close,99

; 2. Create figure for convergence rate

!p.charsize=2

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[0.1,1.0],[4e-4,4e-2],linestyle=2,ystyle=1, $
        xrange=[0.1,1.0],yrange=[1e-4,1e-2],$
        xtitle='time step (arbitrary units)', $
        ytitle='Linf error (at e-folding time)', $
        title="infinite medium test with 80 groups"
xyouts,0.2,0.006,'2nd order slope',charsize=2,charthick=1
oplot,wlog(*,0),wlog(*,1),psym=-1,thick=4
close_device,/pdf

exit
