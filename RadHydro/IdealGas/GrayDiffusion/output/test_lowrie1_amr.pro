resdir='test_lowrie1_amr_results/'

; 0: calculate the errors
openw,  99, resdir + 'error.dat'
printf, 99, 'lowrie test 1'
printf, 99, 'n error'

; read the last snapshot
npict=100

filename = resdir+'72/GM/cut*.outs' 
.r getpict
printf,99,72,calc_error(w)
filename = resdir+'144/GM/cut*.outs' 
.r getpict
printf,99,144,calc_error(w)
filename = resdir+'288/GM/cut*.outs' 
.r getpict
printf,99,288,calc_error(w)

close,99

; 1. Create figure for convergence rate

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-3,1e-1],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 1"
oplot,[1e-3,1e-1],[2e-4,2e+0],linestyle=2,thick=3
xyouts,0.01,0.3,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

; 2. Create 2D figures to demonstrate the AMR grids

filename = resdir + '72/GM/z*.outs'
func='Trad'
physics='hd33'
plotmode='contbargrid'
transform='n'
bottomline=0
plottitle="radiation temperature"
multiplot=[1,2,0]
set_device, resdir+'grid.eps', /eps, /land
loadct,26
dpict=7
.r animate
close_device,/pdf
multiplot=0

; 3. plot 1D profiles

!x.range=[-0.08,0.0]
!y.range=[0.6,0.63]
func='Trad'
npict=100
bottomline=0
set_device, resdir+'Trad.eps', /eps, /land
filename = resdir+'72/GM/cut*.outs'
.r getpict
plot,x,w(*,4),linestyle=0,xtitle='x',ytitle='radiation temperature',charsize=2, $
     title="Lowrie's test 1 with constant opacities",thick=3
filename = resdir+'144/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=1,thick=3
filename = resdir+'288/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=2,thick=3
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

!x.range=[-0.08,0.0]
!y.range=[0.6,0.63]
func='Tgas'
npict=100
bottomline=0
set_device, resdir+'Tgas.eps', /eps, /land
filename = resdir+'72/GM/cut*.outs'
.r getpict
plot,x,w(*,3),linestyle=0,xtitle='x',ytitle='gas temperature',charsize=2, $
     title="Lowrie's test 1 with constant opacities",thick=3
filename = resdir+'144/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=1,thick=3
filename = resdir+'288/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=2,thick=3
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

exit
