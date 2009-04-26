; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_uniform_2d_amr_results/'

!p.charsize=2
!p.charthick=1

filename=resdir+'90/GM/cut_var_2*.outs'
npict=1
.r getpict
set_device, resdir + 'Tmat_r=0.eps', /eps, /land
plot,x,w(*,1), $
     xrange=[-3.,3.],yrange=[2.,6.],$
     linestyle=0,thick=3, $
     xtitle='z', $
     ytitle='material temperature', $
     title="uniform heat conduction in rz-geometry, r=0 cut"
oplot,x,w(*,0),psym=-4,thick=2
npict=3
.r getpict
oplot,x,w(*,1),linestyle=0,thick=3
oplot,x,w(*,0),psym=-5,thick=2
oplot,[1.8],[5.05],psym=4,thick=3 & xyouts,2.,5.,'time = 1'
oplot,[1.8],[4.85],psym=5,thick=3 & xyouts,2.,4.8,'time = 1.2'
close_device,/pdf

filename=resdir+'90/GM/cut_var_3*.outs'
npict=1
.r getpict
set_device, resdir + 'Tmat_z=0.eps', /eps, /land
plot,x,w(*,1), $
     xrange=[0.,1.],yrange=[2.,6.], $
     linestyle=0,thick=3, $
     xtitle='r', $
     ytitle='material temperature', $
     title="uniform heat conduction in rz-geometry, z=0 cut"
oplot,x,w(*,0),psym=-4,thick=2
npict=3
.r getpict
oplot,x,w(*,1),linestyle=0,thick=3
oplot,x,w(*,0),psym=-5,thick=2
oplot,[0.62],[5.15],psym=4,thick=3 & xyouts,0.65,5.1,'time = 1'
oplot,[0.62],[4.85],psym=5,thick=3 & xyouts,0.65,4.8,'time = 1.2'
close_device,/pdf

filename = resdir + '90/GM/z*.outs'
func='t dx'
plotmode='contbar contover'
transform='n'
bottomline=1
plottitle="material temperature"
multiplot=[1,2,0]
set_device, resdir+'isotemperature.eps', /eps, /land
loadct,26
dpict=2
.r animate
close_device,/pdf


; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'uniform heat conduction test in 2D with amr'
printf,99,'n error'

; read the last snapshot 
npict=100

filename=resdir+'90/GM/z*.outs'
.r getpict
printf,99,90,calc_error(w)

filename=resdir+'180/GM/z*.outs'
.r getpict
printf,99,180,calc_error(w)

filename=resdir+'360/GM/z*.outs'
.r getpict
printf,99,360,calc_error(w)

close,99

openw, 99, resdir + 'error_linf.dat'
printf,99,'uniform heat conduction test in 2D with amr'
printf,99,'n error'

; read the last snapshot 
npict=100

filename=resdir+'90/GM/z*.outs'
.r getpict
printf,99,90,calc_linf(w)

filename=resdir+'180/GM/z*.outs'
.r getpict
printf,99,180,calc_linf(w)

filename=resdir+'360/GM/z*.outs'
.r getpict
printf,99,360,calc_linf(w)

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-7,1e-4],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="uniform heat conduction in rz-geometry"
oplot,[1e-3,1e-1],[1e-7,1e-3],linestyle=2,thick=3
xyouts,0.002,0.0000003,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

set_device, resdir + 'error_linf.eps', /eps, /land
logfilename = resdir + 'error_linf.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-5,1e-3],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Linf error', $
        title="uniform heat conduction in rz-geometry"
oplot,[1e-3,1e-1],[1e-5,1e-1],linestyle=2,thick=3
xyouts,0.002,0.00003,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

exit
