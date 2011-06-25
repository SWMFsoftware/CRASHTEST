resdir='test_lowrie3_semi_results/'

; 0: calculate the errors
openw,  99, resdir + 'error.dat'
printf, 99, 'lowrie test 3'
printf, 99, 'n error'

;physics='hd33'
; read the last snapshot
npict=100

filename = resdir+'96/GM/cut*.outs'
.r getpict
printf,99,96,calc_error(w)
filename=resdir+'192/GM/cut*.outs'
.r getpict
printf,99,192,calc_error(w)
filename=resdir+'384/GM/cut*.outs'
.r getpict
printf,99,384,calc_error(w)
;filename=resdir+'768/GM/cut*.outs'
;.r getpict
;printf,99,768,calc_error(w)

close,99

; 1. Create figure for convergence rate

set_device, resdir + 'error.eps', /eps
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-2],yrange=[1e-3,1e-1],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 3"
oplot,[1e-3,1e-2],[3e-3,3e-2],linestyle=2,thick=3
xyouts,0.004,0.009,'1st order slope',charsize=2,charthick=1
close_device,/pdf

; 2. Create 2D figure to demonstrate the AMR grids

filename = resdir + '96/GM/z*.outs'
func='Trad'
physics='hd33'
plotmode='contbargrid'
transform='n'
bottomline=0
plottitle="radiation temperature"
multiplot=[1,2,0]
set_device, resdir+'grid.eps', /eps
loadct,26
dpict=10
.r animate
close_device,/pdf
multiplot=0

; 3. plot 1D profiles

!x.range=[-0.04,0.04]
!y.range=0
func='Trad'
npict=11
.r getpict
bottomline=0
set_device, resdir+'Trad.eps',/eps
filename= resdir+'96/GM/cut*.outs'
.r getpict
plot,x,w(*,4),psym=1,xtitle='x',ytitle='radiation temperature',charsize=2, $
     title="Lowrie's test 3 with variable opacities"
filename= resdir+'384/GM/cut*.outs'
.r getpict
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3

bottomline=0
multiplot=1
func='Trad'
!x.range=[-0.025,-0.021]
!y.range=[0.5,2]
filename= resdir+'96/GM/cut*.outs'
.r getpict
plot,x,w(*,4),linestyle=0,/norm,POS=[0.475,0.25,0.875,0.65], $
     /noerase,charsize=2,thick=3
filename= resdir+'???/GM/cut*.outs'
.r getpict
oplot,x0,w0(*,4),linestyle=1,thick=3
oplot,x1,w1(*,4),linestyle=2,thick=3
;oplot,x2,w2(*,4),linestyle=3,thick=3
oplot,x1,w1(*,9),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

!x.range=0
!y.range=0
func='Tgas'
npict=11
.r getpict
bottomline=0
set_device, resdir+'Tgas.eps',/eps
filename= resdir+'384/GM/cut*.outs'
.r getpict
plot,x,w(*,3),psym=1,xtitle='x',ytitle='gas temperature',charsize=2, $
     title="Lowrie's test 3 with variable opacities"
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3

bottomline=0
multiplot=1
func='Tgas'
!x.range=[0.007,0.01]
!y.range=[5,6]
filename= resdir+'96/GM/cut*.outs'
.r getpict
plot,x,w(*,3),linestyle=0,/norm,POS=[0.475,0.25,0.875,0.65],/noerase,charsize=2,thick=3
filename= resdir+'???/GM/cut*.outs'
.r getpict
oplot,x0,w0(*,3),linestyle=1,thick=3
oplot,x1,w1(*,3),linestyle=2,thick=3
;oplot,x2,w2(*,3),linestyle=3,thick=3
oplot,x1,w1(*,8),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

exit
