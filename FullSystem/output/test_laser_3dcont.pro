; plot results for various solvers and resolutions

resdir='test_laser_3dcont_results/'

transform='n'

firstpict=2
npictmax=1
func='level 1/{dx} ux uy uz rho p pe tekev tikev trkev'
plotmode='contbar contover contbar contbar contbar contbarlog'
multiplot=-10
!p.charsize=1.4

filename = resdir+'Linde/GM/y*.outs'
set_device,resdir+'y=0_cut.eps',/eps,/port
loadct,39
.r animate
close_device,/pdf

filename = resdir+'Linde/GM/z*.outs'
set_device,resdir+'z=0_cut.eps',/eps,/port
loadct,39
.r animate
close_device,/pdf

; Radiograph image from Y direction
filename = resdir+'Linde/GM/los_var_6*.outs'
set_device,resdir+'radiograph_from_y.eps',/epe, /land
loadct,3
func='randomn(seed,400,400,poisson=50)*smooth(exp({radiograph}/1000),3)'
multiplot=0
bottomline=0
plotmode='contbar'
firstpict=2
.r getpict
cut=grid(100:300,150:250)
!x.range=0
!y.range=0
.r animate
close_device,/pdf

; Radiograph image from Z direction
filename = resdir+'Linde/GM/los_var_7*.outs'
set_device,resdir+'radiograph_from_z.eps',/epe, /land
loadct,3
.r animate
close_device,/pdf

exit
