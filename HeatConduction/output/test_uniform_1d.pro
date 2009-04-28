physics='hd33'

; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_uniform_1d_results/'

!p.charsize=2
!p.charthick=1

filename=resdir+'200/GM/z*.outs'
npict=1
.r getpict
cut=grid(*,1)
set_device, resdir + 'Tmat.eps', /eps, /land
plot,x,w(*,1), $
     xrange=[-5.,5.],yrange=[8.,20.],$
     linestyle=0,thick=3, $
     xtitle='x', $
     ytitle='material temperature', $
     title="uniform heat conduction test in 1D"
oplot,x,w(*,0),psym=-4,thick=2
npict=3
.r getpict
oplot,x,w(*,1),linestyle=0,thick=3
oplot,x,w(*,0),psym=-5,thick=2
oplot,[2.8],[18.15],psym=4,thick=3 & xyouts,3.,18.,'time = 0'
oplot,[2.8],[17.15],psym=5,thick=3 & xyouts,3.,17.,'time = 3'
close_device,/pdf

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'uniform heat conduction test in 1D'
printf,99,'n error'

; read the last snapshot 
npict=100

filename=resdir+'200/GM/z*.outs'
.r getpict
printf,99,200,calc_linf(w)

filename=resdir+'400/GM/z*.outs'
.r getpict
printf,99,400,calc_linf(w)

filename=resdir+'800/GM/z*.outs'
.r getpict
printf,99,800,calc_linf(w)

filename=resdir+'1600/GM/z*.outs'
.r getpict
printf,99,1600,calc_linf(w)

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-4,1e-2],yrange=[1e-5,1e-2],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Maximum absolute error (Linf)', $
        title="uniform heat conduction test in 1D"
oplot,[1e-4,1e-2],[8e-7,8e-3],linestyle=2,thick=3
xyouts,0.00014,0.000025,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

exit
