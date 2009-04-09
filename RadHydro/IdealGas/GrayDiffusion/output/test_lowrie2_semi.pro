resdir='test_lowrie2_semi_results/'

;0: calculate the errors
openw,  99, resdir + 'error.dat'
printf, 99, 'lowrie test 2'
printf, 99, 'n error'

; read the last snapshot
npict=100

filename = resdir+'48/GM/cut*.outs' 
.r getpict
printf,99,48,calc_error(w)
filename = resdir+'96/GM/cut*.outs' 
.r getpict
printf,99,96,calc_error(w)
filename = resdir+'192/GM/cut*.outs' 
.r getpict
printf,99,192,calc_error(w)
filename = resdir+'384/GM/cut*.outs' 
.r getpict
printf,99,384,calc_error(w)

close,99

; 1. Create figure for convergence rate

set_device, resdir + 'error.eps', /eps
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-3,1e-1],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 2"
oplot,[1e-3,1e-1],[2e-3,2e-1],linestyle=2,thick=3
xyouts,0.0015,0.002,'1st order slope',charsize=2,charthick=1
close_device,/pdf

; 2. Create 2D figures to demonstrate the AMR grids

filename = resdir + '48/GM/z*.outs'
func='Trad'
physics='hd33'
plotmode='contbargrid'
transform='n'
bottomline=0
plottitle="radiation temperature"
multiplot=[1,2,0]
set_device, resdir+'grid.eps', /eps
loadct,26
dpict=11
.r animate
close_device,/pdf
multiplot=0

; 3. plot 1D profiles

!x.range=[-0.022,-0.005]
!y.range=[0.6,1.3]
func='Trad'
npict=100
bottomline=0
set_device, resdir+'Trad.eps', /eps
filename = resdir+'48/GM/cut*.outs'
.r getpict
plot,x,w(*,4),linestyle=0,xtitle='x',ytitle='radiation temperature',charsize=2, $
     title="Lowrie's test 2 with constant opacities",thick=3
filename = resdir+'96/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=1,thick=3
filename = resdir+'192/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=2,thick=3
filename = resdir+'384/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=3,thick=3
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

!x.range=[-0.02,-0.005]
!y.range=[0.6,1.3]
func='Tgas'
npict=100
bottomline=0
set_device, resdir+'Tgas.eps', /eps
filename = resdir+'48/GM/cut*.outs'
.r getpict
plot,x,w(*,3),linestyle=0,xtitle='x',ytitle='gas temperature',charsize=2, $
     title="Lowrie's test 2 with constant opacities",thick=3
filename = resdir+'96/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=1,thick=3
filename = resdir+'192/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=2,thick=3
filename = resdir+'384/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=3,thick=3
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

exit
