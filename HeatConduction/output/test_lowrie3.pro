resdir='test_lowrie3_results/'

; 0: calculate the errors
openw,  99, resdir + 'error.dat'
printf, 99, 'lowrie test 3'
printf, 99, 'n godunov_error linde_error'

;physics='hd33'
; read the last snapshot
npict=100

filename = resdir+'*_96/GM/cut*.outs'
.r getpict
printf,99,96,calc_error_lowrie3(w0),calc_error_lowrie3(w1)
filename=resdir+'*_192/GM/cut*.outs'
.r getpict
printf,99,192,calc_error_lowrie3(w0),calc_error_lowrie3(w1)
filename=resdir+'*_384/GM/cut*.outs'
.r getpict
printf,99,384,calc_error_lowrie3(w0),calc_error_lowrie3(w1)

close,99

; 1. Create figure for convergence rate

!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[1e-3,1e-1],[4e-3,4e-1], $
        xrange=[1e-3,1e-1],yrange=[3e-3,3e-1],$
        linestyle=2,ystyle=1, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie test 3 for electron energy"
oplot,1/wlog(*,0),wlog(*,1),psym=-4,thick=3
oplot,1/wlog(*,0),wlog(*,2),psym=-5,thick=3
xyouts,0.017,0.05,'1st order slope'
oplot,[0.017],[0.0063],psym=4,thick=3 & xyouts,0.02,0.006,'Godunov'
oplot,[0.017],[0.0083],psym=5,thick=3 & xyouts,0.02,0.008,'Linde'
close_device,/pdf

; 2. Create 2D figure to demonstrate the AMR grids

filename = resdir + 'Godunov_96/GM/z*.outs'
func='te'
physics='hd33'
plotmode='contbargrid'
transform='n'
bottomline=0
plottitle="electron temperature"
multiplot=[1,2,0]
set_device, resdir+'grid.eps', /eps, /land
loadct,26
dpict=10
.r animate
close_device,/pdf
multiplot=0

; 3. plot 1D profiles

!x.range=[-0.04,0.04]
!y.range=0
func='te'
npict=11
.r getpict
bottomline=0
set_device, resdir+'Te.eps',/eps, /land
filename= resdir+'Godunov_96/GM/cut*.outs'
.r getpict
plot,x,w(*,4),psym=1,xtitle='x',ytitle='electron temperature',charsize=2, $
     title="Lowrie's test 3 for electron energy"
filename= resdir+'384/GM/cut*.outs'
.r getpict
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3

bottomline=0
multiplot=1
func='te'
!x.range=[-0.025,-0.021]
!y.range=[0.5,2]
filename= resdir+'Godunov_96/GM/cut*.outs'
.r getpict
plot,x,w(*,4),linestyle=0,/norm,POS=[0.475,0.25,0.875,0.65], $
     /noerase,charsize=2,thick=3
filename= resdir+'Godunov_???/GM/cut*.outs'
.r getpict
oplot,x0,w0(*,4),linestyle=1,thick=3
oplot,x1,w1(*,4),linestyle=2,thick=3
;oplot,x2,w2(*,4),linestyle=3,thick=3
oplot,x1,w1(*,9),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

!x.range=0
!y.range=0
func='ti'
npict=11
.r getpict
bottomline=0
set_device, resdir+'Ti.eps',/eps, /land
filename= resdir+'Godunov_384/GM/cut*.outs'
.r getpict
plot,x,w(*,3),psym=1,xtitle='x',ytitle='ion temperature',charsize=2, $
     title="Lowrie's test 3 for electron energy"
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3

bottomline=0
multiplot=1
func='ti'
!x.range=[0.007,0.01]
!y.range=[5,6]
filename= resdir+'Godunov_96/GM/cut*.outs'
.r getpict
plot,x,w(*,3),linestyle=0,/norm,POS=[0.475,0.25,0.875,0.65],/noerase,charsize=2,thick=3
filename= resdir+'Godunov_???/GM/cut*.outs'
.r getpict
oplot,x0,w0(*,3),linestyle=1,thick=3
oplot,x1,w1(*,3),linestyle=2,thick=3
;oplot,x2,w2(*,3),linestyle=3,thick=3
oplot,x1,w1(*,8),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

exit
