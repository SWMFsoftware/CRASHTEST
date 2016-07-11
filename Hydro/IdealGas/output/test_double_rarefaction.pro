; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_double_rarefaction_results/'

firstpict=15
npictmax=1
func='rho p/rho'
multiplot=2
bottomline=1

filename = resdir+'Linde_*/GM/1d*.outs'
plottitle='Linde n=200, 400, 800, 3200'
set_device, resdir + 'Linde.eps', /eps, /land
.r animate
close_device,/pdf

filename = resdir+'HLLDW_*/GM/1d*.outs'
plottitle='HLLDW n=200, 400, 800, 3200'
set_device, resdir + 'HLLDW.eps', /eps, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*/GM/1d*.outs'
plottitle='Godunov n=200, 400, 800, 3200'
set_device, resdir + 'Godunov.eps', /eps, /land
.r animate
close_device,/pdf

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'Double rarefaction test'
printf,99,'n density_error'

; read the last snapshot
npict=15

; read the high resolution solutions
filename = resdir+'HLLDW_3200/GM/1d.outs'
.r getpict
wref = w

filename=resdir+'HLLDW_200/GM/1d*.outs'
.r getpict
printf,99,200,rel_errors(w,wref,ivar=[0])

filename=resdir+'HLLDW_400/GM/1d*.outs'
.r getpict
printf,99,400,rel_errors(w,wref,ivar=[0])

filename=resdir+'HLLDW_800/GM/1d*.outs'
.r getpict
printf,99,800,rel_errors(w,wref,ivar=[0])

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[2e-3,2e-1],[1e-3,1e+1], $
        xrange=[1e-3,1e-1],yrange=[1e-4,1e-1],$
        linestyle=2,ystyle=1, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Double rarefaction test"
oplot,1/wlog(*,0),wlog(*,1),psym=-5,thick=3
oplot,[2e-3,2e-1],[1e-3,1e+1],linestyle=2,thick=3
xyouts,0.017,0.05,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

exit
