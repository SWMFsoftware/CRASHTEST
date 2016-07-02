; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

resdir='test_advection_2d_results/'

plotmode='tvbar'
firstpict=6
npictmax=1
func='p ux'

; use local procedure to write out resolution only
.r putbottom 

resdir='test_advection_2d_results/'

firstpict=6
npictmax=1
func='rho ux p Eint'
!p.charsize=1.4

filename = resdir+'Godunov_*_/GM/*.outs'
set_device,resdir+'godunov.eps',/eps, /land
loadct,39
.r animate
close_device,/pdf

filename = resdir+'Godunov_*_LIMIT/GM/*.outs'
set_device,resdir+'godunov_limit.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*_NONCONS/GM/*.outs'
set_device,resdir+'godunov_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*_LIMIT_MIXED/GM/*.outs'
set_device,resdir+'godunov_limit_mixed.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*_/GM/*.outs'
set_device,resdir+'linde.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*_LIMIT/GM/*.outs'
set_device,resdir+'linde_limit.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*_NONCONS/GM/*.outs'
set_device,resdir+'linde_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*_LIMIT_MIXED/GM/*.outs'
set_device,resdir+'linde_limit_mixed.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'HLLDW_*_/GM/*.outs'
set_device,resdir+'HLLDW.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'HLLDW_*_LIMIT/GM/*.outs'
set_device,resdir+'HLLDW_limit.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'HLLDW_*_NONCONS/GM/*.outs'
set_device,resdir+'HLLDW_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'HLLDW_*_LIMIT_MIXED/GM/*.outs'
set_device,resdir+'HLLDW_limit_mixed.eps',/eps, /land
.r animate
close_device,/pdf

; 2. calculate errors and save them into a file

openw,99,resdir+'error.dat'
printf,99,'Advection test in 2D'
printf,99,'n godunov g_lim g_noncons g_lim_mix ' $
  +          ' linde l_lim l_noncons l_lim_mix ' $
  +          ' HLLDW d_lim d_noncons d_lim_mix'

; array of errors for a given resolution
errors = fltarr(12)

; read the first snapshot and make it into reference solution
filename=resdir+'Linde_40_/GM/z*.outs'
npict=1
.r getpict
; the left state is advected up to 3/4 of the domain
for i=1,29 do w(i,*,*)=w(0,*,*)
; store the reference solution
wref = w

; plot the reference solution
func='rho level'
time = 5e-9
multiplot=-2
set_device,resdir+'reference_n40.eps',/eps,/port
.r plotfunc
close_device,/pdf

; read the last state for comparison
npict=10

; read at most 4 files at a time
filename=resdir+'Godunov_40_/GM/z*.outs ' $
  +      resdir+'Godunov_40_LIMIT/GM/z*.outs ' $
  +      resdir+'Godunov_40_NONCONS/GM/z*.outs ' $
  +      resdir+'Godunov_40_LIMIT_*/GM/z*.outs'
.r getpict
errors(0)=calc_error(w0,wref)
errors(1)=calc_error(w1,wref)
errors(2)=calc_error(w2,wref)
errors(3)=calc_error(w3,wref)

filename=resdir+'Linde_40_/GM/z*.outs ' $
  +      resdir+'Linde_40_LIMIT/GM/z*.outs ' $
  +      resdir+'Linde_40_NONCONS/GM/z*.outs ' $
  +      resdir+'Linde_40_LIMIT_*/GM/z*.outs'
.r getpict
errors(4)=calc_error(w0,wref)
errors(5)=calc_error(w1,wref)
errors(6)=calc_error(w2,wref)
errors(7)=calc_error(w3,wref)

filename=resdir+'HLLDW_40_/GM/z*.outs ' $
  +      resdir+'HLLDW_40_LIMIT/GM/z*.outs ' $
  +      resdir+'HLLDW_40_NONCONS/GM/z*.outs ' $
  +      resdir+'HLLDW_40_LIMIT_*/GM/z*.outs'
.r getpict
errors(8)=calc_error(w0,wref)
errors(9)=calc_error(w1,wref)
errors(10)=calc_error(w2,wref)
errors(11)=calc_error(w3,wref)

printf,99,40,errors,format='(i3,12f7.4)'

; resolution 80
filename=resdir+'Linde_80_/GM/z*.outs'
npict=1
.r getpict
; the left state is advected up to 3/4 of the domain
for i=1,59 do w(i,*,*)=w(0,*,*)
; store the reference solution
wref = w

; read the last state for comparison
npict=10

; read at most 4 files at a time
filename=resdir+'Godunov_80_/GM/z*.outs ' $
  +      resdir+'Godunov_80_LIMIT/GM/z*.outs ' $
  +      resdir+'Godunov_80_NONCONS/GM/z*.outs ' $
  +      resdir+'Godunov_80_LIMIT_*/GM/z*.outs'
.r getpict
errors(0)=calc_error(w0,wref)
errors(1)=calc_error(w1,wref)
errors(2)=calc_error(w2,wref)
errors(3)=calc_error(w3,wref)

filename=resdir+'Linde_80_/GM/z*.outs ' $
  +      resdir+'Linde_80_LIMIT/GM/z*.outs ' $
  +      resdir+'Linde_80_NONCONS/GM/z*.outs ' $
  +      resdir+'Linde_80_LIMIT_*/GM/z*.outs'
.r getpict
errors(4)=calc_error(w0,wref)
errors(5)=calc_error(w1,wref)
errors(6)=calc_error(w2,wref)
errors(7)=calc_error(w3,wref)

filename=resdir+'HLLDW_80_/GM/z*.outs ' $
  +      resdir+'HLLDW_80_LIMIT/GM/z*.outs ' $
  +      resdir+'HLLDW_80_NONCONS/GM/z*.outs ' $
  +      resdir+'HLLDW_80_LIMIT_*/GM/z*.outs'
.r getpict
errors(8)=calc_error(w0,wref)
errors(9)=calc_error(w1,wref)
errors(10)=calc_error(w2,wref)
errors(11)=calc_error(w3,wref)

printf,99,80,errors,format='(i3,12f7.4)'

; resolution 160
filename=resdir+'Linde_160_/GM/z*.outs'
npict=1
.r getpict
; the left state is advected up to 3/4 of the domain
for i=1,119 do w(i,*,*)=w(0,*,*)
; store the reference solution
wref = w

; read the last state for comparison
npict=10

; read at most 4 files at a time
filename=resdir+'Godunov_160_/GM/z*.outs ' $
  +      resdir+'Godunov_160_LIMIT/GM/z*.outs ' $
  +      resdir+'Godunov_160_NONCONS/GM/z*.outs ' $
  +      resdir+'Godunov_160_LIMIT_*/GM/z*.outs'
.r getpict
errors(0)=calc_error(w0,wref)
errors(1)=calc_error(w1,wref)
errors(2)=calc_error(w2,wref)
errors(3)=calc_error(w3,wref)

filename=resdir+'Linde_160_/GM/z*.outs ' $
  +      resdir+'Linde_160_LIMIT/GM/z*.outs ' $
  +      resdir+'Linde_160_NONCONS/GM/z*.outs ' $
  +      resdir+'Linde_160_LIMIT_*/GM/z*.outs'
.r getpict
errors(4)=calc_error(w0,wref)
errors(5)=calc_error(w1,wref)
errors(6)=calc_error(w2,wref)
errors(7)=calc_error(w3,wref)

filename=resdir+'HLLDW_160_/GM/z*.outs ' $
  +      resdir+'HLLDW_160_LIMIT/GM/z*.outs ' $
  +      resdir+'HLLDW_160_NONCONS/GM/z*.outs ' $
  +      resdir+'HLLDW_160_LIMIT_*/GM/z*.outs'
.r getpict
errors(8)=calc_error(w0,wref)
errors(9)=calc_error(w1,wref)
errors(10)=calc_error(w2,wref)
errors(11)=calc_error(w3,wref)

print,"help,w2"
help,w2
printf,99,160,errors,format='(i3,12f7.4)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

logfilename=resdir+'error.dat'
.r getlog

; The Godunov part of the header of error.dat:
; n godunov g_lim g_noncons g_lim_mix

set_device,resdir+'error_godunov.eps',/eps, /land

!p.thick=3

plot_oo,[1e-3,1e-1],[1e-3,1e-1], $
  xrange=[1e-3,1e-1],yrange=[1e-3,2e-1],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Be/Xe/Plastic advection test in 2D"
oplot,2/wlog(*,0),wlog(*,1),psym=-1,thick=3
oplot,2/wlog(*,0),wlog(*,2),psym=-2,thick=3
oplot,2/wlog(*,0),wlog(*,3),psym=-4,thick=3
oplot,2/wlog(*,0),wlog(*,4),psym=-5,thick=3

oplot,[0.0012,0.0017],[0.005,0.005],linestyle=2
xyouts,0.002,0.005,'1st order slope'
oplot,[0.0015],[0.16],psym=1 & xyouts,0.002,0.14,'Godunov'
oplot,[0.0015],[0.08],psym=2 & xyouts,0.002,0.08,'+ #LIMITER'
oplot,[0.0015],[0.04],psym=4 & xyouts,0.002,0.04,'+ #NONCONS'
oplot,[0.0015],[0.02],psym=5 & xyouts,0.002,0.02,'+ #MIXED'

close_device,/pdf

; The Linde part of the header of error.dat:
; n linde g_lim g_noncons g_lim_mix

set_device,resdir+'error_linde.eps',/eps, /land

plot_oo,[1e-3,1e-1],[1e-3,1e-1], $
  xrange=[1e-3,1e-1],yrange=[1e-3,2e-1],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Be/Xe/Plastic advection test in 2D"
oplot,2/wlog(*,0),wlog(*,5),psym=-1,thick=3
oplot,2/wlog(*,0),wlog(*,6),psym=-2,thick=3
oplot,2/wlog(*,0),wlog(*,7),psym=-4,thick=3
oplot,2/wlog(*,0),wlog(*,8),psym=-5,thick=3

oplot,[0.0012,0.0017],[0.005,0.005],linestyle=2
xyouts,0.002,0.005,'1st order slope'
oplot,[0.0015],[0.16],psym=1 & xyouts,0.002,0.14,'Linde'
oplot,[0.0015],[0.04],psym=4 & xyouts,0.002,0.04,'+ #NONCONS'
oplot,[0.0015],[0.08],psym=2 & xyouts,0.002,0.08,'+ #LIMITER'
oplot,[0.0015],[0.02],psym=5 & xyouts,0.002,0.02,'+ #MIXED'

close_device,/pdf

; The HLLDW part of the header of error.dat:
; n HLLDW d_lim d_noncons d_lim_mix

set_device,resdir+'error_HLLDW.eps',/eps, /land

plot_oo,[1e-3,1e-1],[1e-3,1e-1], $
  xrange=[1e-3,1e-1],yrange=[1e-3,2e-1],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Be/Xe/Plastic advection test in 2D"
oplot,2/wlog(*,0),wlog(*,9),psym=-1,thick=3
oplot,2/wlog(*,0),wlog(*,10),psym=-2,thick=3
oplot,2/wlog(*,0),wlog(*,11),psym=-4,thick=3
oplot,2/wlog(*,0),wlog(*,12),psym=-5,thick=3

oplot,[0.0012,0.0017],[0.005,0.005],linestyle=2
xyouts,0.002,0.005,'1st order slope'
oplot,[0.0015],[0.16],psym=1 & xyouts,0.002,0.14,'HLLDW'
oplot,[0.0015],[0.04],psym=4 & xyouts,0.002,0.04,'+ #NONCONS'
oplot,[0.0015],[0.08],psym=2 & xyouts,0.002,0.08,'+ #LIMITER'
oplot,[0.0015],[0.02],psym=5 & xyouts,0.002,0.02,'+ #MIXED'

close_device,/pdf

exit
