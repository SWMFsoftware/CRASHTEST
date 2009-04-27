; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_shu_osher_2d_results/'

filename_ref = 'test_shu_osher_1d_ref.out '

!x.range=[0,3]
firstpict=10
npictmax=1
func='rho'
multiplot=1

filename = resdir+'Rusanov_*/GM/cut*.outs'
plottitle='Rusanov n=200, 400, 800, 1600'
set_device,resdir+'Rusanov.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*/GM/cut*.outs'
plottitle='Linde n=200, 400, 800, 1600'
set_device,resdir+'Linde.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*/GM/cut*.outs'
plottitle='Godunov n=200, 400, 800, 1600'
set_device,resdir+'Godunov.eps',/eps, /land
.r animate
close_device,/pdf

!x.range=0

; 2. calculate errors and save it into a file
; order is Godunov, Linde, Rusanov (alphabetical) for sake of simplicity
openw,99,resdir+'error.dat'
printf,99,'Shu-Osher test in 2D'
printf,99,'n godunov_error linde_error rusanov_error'

; read the reference solution
npict=1
filename = filename_ref
.r getpict
wref = w

; read the last snapshot 
npict=10

filename=resdir+'*_200/GM/cut*.outs'
.r getpict
printf,99,200,calc_error(w0,wref),calc_error(w1,wref),calc_error(w2,wref)

filename=resdir+'*_400/GM/cut*.outs'
.r getpict
printf,99,400,calc_error(w0,wref),calc_error(w1,wref),calc_error(w2,wref)

filename=resdir+'*_800/GM/cut*.outs'
.r getpict
printf,99,800,calc_error(w0,wref),calc_error(w1,wref),calc_error(w2,wref)

filename=resdir+'*_1600/GM/cut*.outs'
.r getpict
printf,99,1600,calc_error(w0,wref),calc_error(w1,wref),calc_error(w2,wref)

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device,resdir+'error.eps',/eps, /land
logfilename=resdir+'error.dat'
.r getlog
plot_oo,[1e-3,1e-1],[1e-3,1e-1], $
  xrange=[1e-3,1e-1],yrange=[2e-3,2e-1],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Shu-Osher test in 2D"
oplot,10/wlog(*,0),wlog(*,1),psym=-4,thick=3
oplot,10/wlog(*,0),wlog(*,2),psym=-5,thick=3
oplot,10/wlog(*,0),wlog(*,3),psym=-6,thick=3

oplot,[0.0012,0.0017],[0.01,0.01],linestyle=2
xyouts,0.002,0.01,'1st order slope'
oplot,[0.0015],[0.02],psym=4 & xyouts,0.002,0.02,'Godunov'
oplot,[0.0015],[0.04],psym=5 & xyouts,0.002,0.04,'Linde'
oplot,[0.0015],[0.08],psym=6 & xyouts,0.002,0.08,'Rusanov'

close_device,/pdf

exit
