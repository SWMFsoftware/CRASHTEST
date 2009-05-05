resdir='test_lowrie1_semi_results/'

; 0: calculate the errors
openw,  99, resdir + 'error.dat'
printf, 99, 'lowrie test 1'
printf, 99, 'n error_conservative error_nonconservative'

; read the last snapshot
npict=100

filename = resdir+'*/72/GM/cut*.outs' 
.r getpict
print,filename
printf,99,72,calc_error(w0),calc_error(w1)
filename = resdir+'*/144/GM/cut*.outs' 
.r getpict
printf,99,144,calc_error(w0),calc_error(w1)
filename = resdir+'*/288/GM/cut*.outs' 
.r getpict
printf,99,288,calc_error(w0),calc_error(w1)

close,99

; 1. Create figure for convergence rate

!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[1e-3,1e-1],[2e-4,2e+0], $
        xrange=[1e-3,1e-1],yrange=[1e-3,1e-1], $
        linestyle=2,ystyle=1, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 1"
oplot,1/wlog(*,0),(wlog(*,1)),psym=-4,thick=3
oplot,1/wlog(*,0),(wlog(*,2)),psym=-5,thick=3
xyouts,0.003,0.03,'2nd order slope',charsize=2,charthick=1
oplot,[0.017],[0.0033],psym=4,thick=3 & xyouts,0.02,0.003,'conservative'
oplot,[0.017],[0.0043],psym=5,thick=3 & xyouts,0.02,0.004,'nonconservative'
close_device,/pdf

; 2. Create 2D figures to demonstrate the AMR grids

filename = resdir + 'CONS/72/GM/z*.outs'
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
set_device, resdir+'Trad_conservative.eps', /eps, /land
filename = resdir+'CONS/72/GM/cut*.outs'
.r getpict
plot,x,w(*,4),linestyle=0,xtitle='x',ytitle='radiation temperature',charsize=2, $
     title="Lowrie's test 1 with constant opacities",thick=3
filename = resdir+'CONS/144/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=1,thick=3
filename = resdir+'CONS/288/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=2,thick=3
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

!x.range=[-0.08,0.0]
!y.range=[0.6,0.63]
func='Tgas'
npict=100
bottomline=0
set_device, resdir+'Tgas_conservative.eps', /eps, /land
filename = resdir+'CONS/72/GM/cut*.outs'
.r getpict
plot,x,w(*,3),linestyle=0,xtitle='x',ytitle='gas temperature',charsize=2, $
     title="Lowrie's test 1 with constant opacities",thick=3
filename = resdir+'CONS/144/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=1,thick=3
filename = resdir+'CONS/288/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=2,thick=3
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

!x.range=[-0.08,0.0]
!y.range=[0.6,0.63]
func='Trad'
npict=100
bottomline=0
set_device, resdir+'Trad_nonconservative.eps', /eps, /land
filename = resdir+'NONCONS/72/GM/cut*.outs'
.r getpict
plot,x,w(*,4),linestyle=0,xtitle='x',ytitle='radiation temperature',charsize=2, $
     title="Lowrie's test 1 with constant opacities",thick=3
filename = resdir+'NONCONS/144/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=1,thick=3
filename = resdir+'NONCONS/288/GM/cut*.outs'
.r getpict
oplot,x,w(*,4),linestyle=2,thick=3
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

!x.range=[-0.08,0.0]
!y.range=[0.6,0.63]
func='Tgas'
npict=100
bottomline=0
set_device, resdir+'Tgas_nonconservative.eps', /eps, /land
filename = resdir+'NONCONS/72/GM/cut*.outs'
.r getpict
plot,x,w(*,3),linestyle=0,xtitle='x',ytitle='gas temperature',charsize=2, $
     title="Lowrie's test 1 with constant opacities",thick=3
filename = resdir+'NONCONS/144/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=1,thick=3
filename = resdir+'NONCONS/288/GM/cut*.outs'
.r getpict
oplot,x,w(*,3),linestyle=2,thick=3
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3
close_device,/pdf

exit
