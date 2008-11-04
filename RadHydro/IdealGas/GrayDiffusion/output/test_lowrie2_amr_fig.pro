; 1. Create figure for convergence rate

set_device,'test_lowrie2_amr.eps',/eps
logfilename='test_lowrie2_amr.err'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-3,1e-1],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 2"
oplot,[1e-3,1e-1],[2e-3,2e-1],linestyle=2,thick=3
xyouts,0.0015,0.002,'1st order slope',charsize=2,charthick=1
close_device

; 2. Create 2D figures to demonstrate the AMR grids

filename='test_lowrie2_amr_results/48/GM/z=0_var_1_n0_130.outs'
func='Trad'
plotmode='contbargrid'
transform='n'
loadct,26
bottomline=0
plottitle="radiation temperature"
!p.charsize=1

set_device,'test_lowrie2_amr_gridstart.eps',/eps,/port
npict=1
.r getpict
.r plotfunc
close_device

set_device,'test_lowrie2_amr_gridstop.eps',/eps,/port
npict=12
.r getpict
.r plotfunc
close_device

; 3. plot 1D profiles

!x.range=[-0.022,-0.005]
!y.range=[0.6,1.3]
func='Trad'
firstpict=[12,12]
npictmax=1
.r getpict
bottomline=0
set_device,'test_lowrie2_amr_Trad.eps',/eps
filename='test_lowrie2_amr_results/48/GM/cut_var_2_n0_130.outs'
.r getpict
plot,x,w(*,4),linestyle=0,xtitle='x',ytitle='radiation temperature',charsize=2, $
     title="Lowrie's test 2 with constant opacities",thick=3
filename='test_lowrie2_amr_results/96/GM/cut_var_2_n0_259.outs'
.r getpict
oplot,x,w(*,4),linestyle=1,thick=3
filename='test_lowrie2_amr_results/192/GM/cut_var_2_n0_518.outs'
.r getpict
oplot,x,w(*,4),linestyle=2,thick=3
filename='test_lowrie2_amr_results/384/GM/cut_var_2_n0_1036.outs'
.r getpict
oplot,x,w(*,4),linestyle=3,thick=3
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3
close_device

!x.range=[-0.02,-0.005]
!y.range=[0.6,1.3]
func='Tgas'
firstpict=[12,12]
npictmax=1
.r getpict
bottomline=0
set_device,'test_lowrie2_amr_Tgas.eps',/eps
filename='test_lowrie2_amr_results/48/GM/cut_var_2_n0_130.outs'
.r getpict
plot,x,w(*,3),linestyle=0,xtitle='x',ytitle='gas temperature',charsize=2, $
     title="Lowrie's test 2 with constant opacities",thick=3
filename='test_lowrie2_amr_results/96/GM/cut_var_2_n0_259.outs'
.r getpict
oplot,x,w(*,3),linestyle=1,thick=3
filename='test_lowrie2_amr_results/192/GM/cut_var_2_n0_518.outs'
.r getpict
oplot,x,w(*,3),linestyle=2,thick=3
filename='test_lowrie2_amr_results/384/GM/cut_var_2_n0_1036.outs'
.r getpict
oplot,x,w(*,3),linestyle=3,thick=3
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3
close_device

exit
