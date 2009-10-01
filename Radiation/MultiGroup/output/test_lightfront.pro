physics='hd11'

; 1. plot results, 2. calculate errors, 3. plot errors

resdir='test_lightfront_results/'

firstpict = 11
!p.psym=-1
multiplot=-2
func='erad1 erad2'

filename = resdir+'X_*/GM/cut*.outs'
set_device, resdir + 'lightfront_x.eps', /eps, /land
.r animate
oplot,[0.7,0.75],[0.8,0.8],linestyle=0,thick=3 & xyouts,0.77,0.78,'160'
oplot,[0.7,0.75],[0.7,0.7],linestyle=2,thick=3 & xyouts,0.77,0.68,' 80'
oplot,[0.7,0.75],[0.6,0.6],linestyle=1,thick=3 & xyouts,0.77,0.58,' 40'
close_device,/pdf

filename = resdir+'Y_*/GM/cut*.outs'
set_device, resdir + 'lightfront_y.eps', /eps, /land
.r animate
oplot,[0.7,0.75],[0.8,0.8],linestyle=0,thick=3 & xyouts,0.77,0.78,'160'
oplot,[0.7,0.75],[0.7,0.7],linestyle=2,thick=3 & xyouts,0.77,0.68,' 80'
oplot,[0.7,0.75],[0.6,0.6],linestyle=1,thick=3 & xyouts,0.77,0.58,' 40'
close_device,/pdf

filename = resdir+'Z_*/GM/cut*.outs'
set_device, resdir + 'lightfront_z.eps', /eps, /land
.r animate
oplot,[0.7,0.75],[0.8,0.8],linestyle=0,thick=3 & xyouts,0.77,0.78,'160'
oplot,[0.7,0.75],[0.7,0.7],linestyle=2,thick=3 & xyouts,0.77,0.68,' 80'
oplot,[0.7,0.75],[0.6,0.6],linestyle=1,thick=3 & xyouts,0.77,0.58,' 40'
close_device,/pdf

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'lightfront test in 1D'
printf,99,'n x_error y_error z_error'

npict=11

filename=resdir+'*_40/GM/cut*.outs'
.r getpict
printf,99,40,calc_error_lightfront(x0,w0), $
       calc_error_lightfront(x1,w1), $
       calc_error_lightfront(x2,w2)

filename=resdir+'*_80/GM/cut*.outs'
.r getpict
printf,99,80,calc_error_lightfront(x0,w0), $
       calc_error_lightfront(x1,w1), $
       calc_error_lightfront(x2,w2)

filename=resdir+'*_160/GM/cut*.outs'
.r getpict
printf,99,160,calc_error_lightfront(x0,w0), $
       calc_error_lightfront(x1,w1), $
       calc_error_lightfront(x2,w2)

close,99

; 3. Create figure for convergence rate

!p.charsize=2

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),wlog(*,1),psym=-1,thick=4, $
        xrange=[1e-3,1e-1],yrange=[1e-2,0.1],$
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="lightfront test with two groups"
oplot,1/wlog(*,0),wlog(*,2),psym=-2,thick=4
oplot,1/wlog(*,0),wlog(*,3),psym=-4,thick=4
oplot,[0.015],[0.037],psym=1 & xyouts,0.018,0.036,'x-direction'
oplot,[0.015],[0.031],psym=2 & xyouts,0.018,0.03,'y-direction'
oplot,[0.015],[0.026],psym=4 & xyouts,0.018,0.025,'z-direction'
close_device,/pdf

exit
