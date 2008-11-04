; 1. Create figure for convergence rate

set_device,'test_lowrie3_amr.eps',/eps
logfilename='test_lowrie3_amr.err'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-2],yrange=[1e-3,1e-1],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 3"
oplot,[1e-3,1e-2],[2e-3,2e-2],linestyle=2  
xyouts,0.004,0.0052,'1st order slope',charsize=2,charthick=1
close_device

; 2. Create 2D figures to demonstrate the AMR grids

filename='test_lowrie3_amr_results/96/GM/z=0_var_1_n0_109.outs'
func='Trad'
physics='hd33'
plotmode='contbargrid'
transform='n'
loadct,26
bottomline=0
plottitle="radiation temperature"

set_device,'test_lowrie3_amr_gridstart.eps',/eps
npict=1
.r getpict
.r plotfunc
close_device

set_device,'test_lowrie3_amr_gridstop.eps',/eps
npict=11
.r getpict
.r plotfunc
close_device

; 3. plot 1D profiles

!x.range=0
!y.range=0
func='Trad'
firstpict=[11,11]
.r getpict
bottomline=0
set_device,'test_lowrie3_amr_Trad.eps',/eps
filename='test_lowrie3_amr_results/96/GM/cut_var_2_n0_109.outs'
.r getpict
plot,x,w(*,4),psym=1,xtitle='x',ytitle='radiation temperature',charsize=2, $
     title="Lowrie's test 3 with variable opacities"
filename='test_lowrie3_amr_results/384/GM/cut_var_2_n0_435.outs'
.r getpict
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3

npict=100
bottomline=0
multiplot=1
func='Trad'
!x.range=[-0.025,-0.021]
!y.range=[0.5,2]
filename='test_lowrie3_amr_results/96/GM/cut_var_2_n0_109.outs'
.r getpict
plot,x,w(*,4),linestyle=0,/norm,POS=[0.475,0.25,0.875,0.65],/noerase,charsize=2
filename='test_lowrie3_amr_results/192/GM/cut_var_2_n0_218.outs'
.r getpict
oplot,x,w(*,4),linestyle=1
filename='test_lowrie3_amr_results/384/GM/cut_var_2_n0_435.outs'
.r getpict
oplot,x,w(*,4),linestyle=2
oplot,x,w(*,9),psym=0,linestyle=0,color=40,thick=3

close_device


!x.range=0
!y.range=0
func='Tgas'
firstpict=[11,11]
.r getpict
bottomline=0
set_device,'test_lowrie3_amr_Tgas.eps',/eps
filename='test_lowrie3_amr_results/96/GM/cut_var_2_n0_109.outs'
.r getpict
plot,x,w(*,3),psym=1,xtitle='x',ytitle='gas temperature',charsize=2, $
     title="Lowrie's test 3 with variable opacities"
filename='test_lowrie3_amr_results/384/GM/cut_var_2_n0_435.outs'
.r getpict
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3
close_device

npict=100
bottomline=0
multiplot=1
func='Tgas'
!x.range=[0.007,0.01]
!y.range=[5,6]
filename='test_lowrie3_amr_results/96/GM/cut_var_2_n0_109.outs'
.r getpict
plot,x,w(*,3),linestyle=0,/norm,POS=[0.475,0.25,0.875,0.65],/noerase,charsize=2
filename='test_lowrie3_amr_results/192/GM/cut_var_2_n0_218.outs'
.r getpict
oplot,x,w(*,3),linestyle=1
filename='test_lowrie3_amr_results/384/GM/cut_var_2_n0_435.outs'
.r getpict
oplot,x,w(*,3),linestyle=2
oplot,x,w(*,8),psym=0,linestyle=0,color=40,thick=3
close_device

exit
