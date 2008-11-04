; 1. Create figure for convergence rate

set_device,'test_lowrie1_amr.eps',/eps
logfilename='test_lowrie1_amr.err'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-4,1e-0],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 1"
oplot,[1e-3,1e-1],[2e-4,2e+0],linestyle=2  
xyouts,0.01,0.3,'2nd order slope',charsize=2,charthick=1
close_device

; 2. Create 2D figures to demonstrate the AMR grids

filename='test_lowrie1_amr_results/48/GM/z=0_var_1_n0_117.outs'
func='Trad'
plotmode='contbargrid'
transform='n'
loadct,26
bottomline=0
plottitle="radiation temperature"
!p.charsize=2

set_device,'test_lowrie1_amr_gridstart.eps',/eps
npict=1
.r getpict
.r plotfunc
close_device

set_device,'test_lowrie1_amr_gridstop.eps',/eps
npict=8
.r getpict
.r plotfunc
close_device

; 3. plot 1D profiles

!x.range=[-0.08,0.0]
!y.range=[0.6,0.63]
func='Trad'
firstpict=[8,8]
npictmax=1
.r getpict
bottomline=0
set_device,'test_lowrie1_amr_Trad.eps',/eps
filename='test_lowrie1_amr_results/24/GM/cut_var_2_n0_59.outs'
.r getpict
plot,x,w(*,4),linestyle=0,xtitle='x',ytitle='radiation temperature',charsize=2, $
     title="Lowrie's test 1 with constant opacities"
filename='test_lowrie1_amr_results/48/GM/cut_var_2_n0_117.outs'
.r getpict
oplot,x,w(*,4),linestyle=1
filename='test_lowrie1_amr_results/96/GM/cut_var_2_n0_234.outs'
.r getpict
oplot,x,w(*,4),linestyle=2
filename='test_lowrie1_amr_results/192/GM/cut_var_2_n0_467.outs'
.r getpict
oplot,x,w(*,4),linestyle=3
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3
close_devise

!x.range=[-0.08,0.0]
!y.range=[0.6,0.63]
func='Tgas'
firstpict=[8,8]
npictmax=1
.r getpict
bottomline=0
set_device,'test_lowrie1_amr_Tgas.eps',/eps
filename='test_lowrie1_amr_results/24/GM/cut_var_2_n0_59.outs'
.r getpict
plot,x,w(*,3),linestyle=0,xtitle='x',ytitle='gas temperature',charsize=2, $
     title="Lowrie's test 1 with constant opacities"
filename='test_lowrie1_amr_results/48/GM/cut_var_2_n0_117.outs'
.r getpict
oplot,x,w(*,3),linestyle=1
filename='test_lowrie1_amr_results/96/GM/cut_var_2_n0_234.outs'
.r getpict
oplot,x,w(*,3),linestyle=2
filename='test_lowrie1_amr_results/192/GM/cut_var_2_n0_467.outs'
.r getpict
oplot,x,w(*,3),linestyle=3
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3
close_device

exit
