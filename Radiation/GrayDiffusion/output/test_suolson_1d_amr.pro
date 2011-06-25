physics='hd11'

; 1. plot results, 2. calculate errors, 3. plot errors

resdir='test_suolson_1d_amr_results/'

!x.range=[0.,5.]
!y.range=[0.,1000.]

!p.charsize=2
!p.charthick=1
set_device, resdir + 'Tmat.eps', /eps
func='tmat'

filename = 'suolson_0.02ns.out'
npict = 1
.r getpict
plot,x,w(*,0), $
     xrange=[0.,5.],yrange=[0.,1000.],$
     linestyle=0,thick=3, $
     xtitle='x (cm)', $
     ytitle='material temperature (eV)', $
     title="Su-Olson test in 1D"
filename = resdir+'radiation_960/GM/cut*.outs'
npict = 2
.r getpict
oplot,x,w(*,0),linestyle=2,thick=3
oplot,[2.8,2.95],[715.,715.],linestyle=0,thick=3 & xyouts,3.,700.,'reference'
oplot,[2.8,2.95],[815.,815.],linestyle=2,thick=3 & xyouts,3.,800.,'radiation'
close_device,/pdf

filename = 'suolson_0.02ns.out'
npict = 1
.r getpict
set_device, resdir + 'Trad.eps', /eps
func='trad'
plot,x,w(*,1), $
     xrange=[0.,5.],yrange=[0.,1000.],$
     linestyle=0,thick=3, $
     xtitle='x (cm)', $
     ytitle='radiation temperature (eV)', $
     title="Su-Olson test in 1D"
filename = resdir+'radiation_960/GM/cut*.outs'
npict = 2
.r getpict
oplot,x,w(*,1),linestyle=2,thick=3
oplot,[2.8,2.95],[715.,715.],linestyle=0,thick=3 & xyouts,3.,700.,'reference'
oplot,[2.8,2.95],[815.,815.],linestyle=2,thick=3 & xyouts,3.,800.,'radiation'
close_device,/pdf


; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'Su-Olson test in 1D'
printf,99,'n radcond_error radiation_error'

; read the last snapshot
npict=2

; read the high resolution solutions
filename = resdir+'*_960/GM/cut*.outs'
.r getpict
wref0 = w0
wref1 = w1

filename=resdir+'*_60/GM/cut*.outs'
.r getpict
printf,99,60,calc_error(w0,wref0),calc_error(w1,wref1)

filename=resdir+'*_120/GM/cut*.outs'
.r getpict
printf,99,120,calc_error(w0,wref0),calc_error(w1,wref1)

filename=resdir+'*_240/GM/cut*.outs'
.r getpict
printf,99,240,calc_error(w0,wref0),calc_error(w1,wref1)

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
oplot,[0.0017],[0.0033],psym=4,thick=3 & xyouts,0.002,0.003,'radcond'
oplot,[0.0017],[0.0043],psym=5,thick=3 & xyouts,0.002,0.004,'radiation'
close_device,/pdf

exit
