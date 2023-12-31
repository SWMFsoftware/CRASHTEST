; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

; use local procedure to write out resolution only
.r putbottom 

resdir='test_advection_1d_results/'

firstpict=6
npictmax=1
func='rho ux p Eint'
!p.charsize=1.4

filename = resdir+'Godunov_*_/GM/*.outs'
set_device,resdir+'godunov.eps',/eps, /land
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

; 2. calculate errors and save them into a file

openw,99,resdir+'error.dat'
printf,99,'Advection test in 1D'
printf,99, $
       'n godunov g_lim g_noncons g_lim_mix ' + $
       ' linde l_lim l_noncons l_lim_mix'

; array of errors for a given resolution
errors = fltarr(8)

; read the first snapshot and make it into reference solution
filename=resdir+'Linde_40_/GM/c*.outs'
npict=1
.r getpict
; the left state is advected up to 3/8 of the domain
for i=1,14 do w(i,*)=w(0,*)
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
filename=resdir+'Godunov_40_/GM/c*.outs ' $
  +      resdir+'Godunov_40_LIMIT/GM/c*.outs ' $
  +      resdir+'Godunov_40_NONCONS/GM/c*.outs ' $
  +      resdir+'Godunov_40_LIMIT_*/GM/c*.outs'
.r getpict
errors(0)=rel_error(w0,wref,[0,1,4,5])
errors(1)=rel_error(w1,wref,[0,1,4,5])
errors(2)=rel_error(w2,wref,[0,1,4,5])
errors(3)=rel_error(w3,wref,[0,1,4,5])

filename=resdir+'Linde_40_/GM/c*.outs ' $
  +      resdir+'Linde_40_LIMIT/GM/c*.outs ' $
  +      resdir+'Linde_40_NONCONS/GM/c*.outs ' $
  +      resdir+'Linde_40_LIMIT_*/GM/c*.outs'
.r getpict
errors(4)=rel_error(w0,wref,[0,1,4,5])
errors(5)=rel_error(w1,wref,[0,1,4,5])
errors(6)=rel_error(w2,wref,[0,1,4,5])
errors(7)=rel_error(w3,wref,[0,1,4,5])

printf,99,40,errors,format='(i3,8f7.4)'

; resolution 80
filename=resdir+'Linde_80_/GM/c*.outs'
npict=1
.r getpict
; the left state is advected up to 3/8 of the domain
for i=1,29 do w(i,*)=w(0,*)
; store the reference solution
wref = w

; read the last state for comparison
npict=10

; read at most 4 files at a time
filename=resdir+'Godunov_80_/GM/c*.outs ' $
  +      resdir+'Godunov_80_LIMIT/GM/c*.outs ' $
  +      resdir+'Godunov_80_NONCONS/GM/c*.outs ' $
  +      resdir+'Godunov_80_LIMIT_*/GM/c*.outs'
.r getpict
errors(0)=rel_error(w0,wref,[0,1,4,5])
errors(1)=rel_error(w1,wref,[0,1,4,5])
errors(2)=rel_error(w2,wref,[0,1,4,5])
errors(3)=rel_error(w3,wref,[0,1,4,5])

filename=resdir+'Linde_80_/GM/c*.outs ' $
  +      resdir+'Linde_80_LIMIT/GM/c*.outs ' $
  +      resdir+'Linde_80_NONCONS/GM/c*.outs ' $
  +      resdir+'Linde_80_LIMIT_*/GM/c*.outs'
.r getpict
errors(4)=rel_error(w0,wref,[0,1,4,5])
errors(5)=rel_error(w1,wref,[0,1,4,5])
errors(6)=rel_error(w2,wref,[0,1,4,5])
errors(7)=rel_error(w3,wref,[0,1,4,5])

printf,99,80,errors,format='(i3,8f7.4)'

; resolution 160
filename=resdir+'Linde_160_/GM/c*.outs'
npict=1
.r getpict
; the left state is advected up to 3/8 of the domain
for i=1,59 do w(i,*)=w(0,*)
; store the reference solution
wref = w

; read the last state for comparison
npict=10

; read at most 4 files at a time
filename=resdir+'Godunov_160_/GM/c*.outs ' $
  +      resdir+'Godunov_160_LIMIT/GM/c*.outs ' $
  +      resdir+'Godunov_160_NONCONS/GM/c*.outs ' $
  +      resdir+'Godunov_160_LIMIT_*/GM/c*.outs'
.r getpict
errors(0)=rel_error(w0,wref,[0,1,4,5])
errors(1)=rel_error(w1,wref,[0,1,4,5])
errors(2)=rel_error(w2,wref,[0,1,4,5])
errors(3)=rel_error(w3,wref,[0,1,4,5])

filename=resdir+'Linde_160_/GM/c*.outs ' $
  +      resdir+'Linde_160_LIMIT/GM/c*.outs ' $
  +      resdir+'Linde_160_NONCONS/GM/c*.outs ' $
  +      resdir+'Linde_160_LIMIT_*/GM/c*.outs'
.r getpict
errors(4)=rel_error(w0,wref,[0,1,4,5])
errors(5)=rel_error(w1,wref,[0,1,4,5])
errors(6)=rel_error(w2,wref,[0,1,4,5])
errors(7)=rel_error(w3,wref,[0,1,4,5])

printf,99,160,errors,format='(i3,8f7.4)'

; resolution 320
filename=resdir+'Linde_320_/GM/c*.outs'
npict=1
.r getpict
; the left state is advected up to 3/8 of the domain
for i=1,119 do w(i,*)=w(0,*)
; store the reference solution
wref = w

; read the last state for comparison
npict=10

; read at most 3 files at a time
filename=resdir+'Godunov_320_/GM/c*.outs ' $
  +      resdir+'Godunov_320_LIMIT/GM/c*.outs ' $
  +      resdir+'Godunov_320_NONCONS/GM/c*.outs ' $
  +      resdir+'Godunov_320_LIMIT_*/GM/c*.outs'
.r getpict
errors(0)=rel_error(w0,wref,[0,1,4,5])
errors(1)=rel_error(w1,wref,[0,1,4,5])
errors(2)=rel_error(w2,wref,[0,1,4,5])
errors(3)=rel_error(w3,wref,[0,1,4,5])

filename=resdir+'Linde_320_/GM/c*.outs ' $
  +      resdir+'Linde_320_LIMIT/GM/c*.outs ' $
  +      resdir+'Linde_320_NONCONS/GM/c*.outs ' $
  +      resdir+'Linde_320_LIMIT_*/GM/c*.outs'
.r getpict
errors(4)=rel_error(w0,wref,[0,1,4,5])
errors(5)=rel_error(w1,wref,[0,1,4,5])
errors(6)=rel_error(w2,wref,[0,1,4,5])
errors(7)=rel_error(w3,wref,[0,1,4,5])

printf,99,320,errors,format='(i3,8f7.4)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device,resdir+'error.eps',/eps, /land
logfilename=resdir+'error.dat'
.r getlog

; The Godunov part of the header of error.dat:
; n godunov g_lim g_noncons g_lim_mix

!p.thick=3

plot_oo,[1e-3,2e-1],[1e-3,2e-1], $
  xrange=[1e-3,2e-1],yrange=[1e-3,2e-1],linestyle=2,xstyle=1,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Be/Xe advection test in 1D"
oplot,4/wlog(*,0),wlog(*,1),psym=-1,thick=3
oplot,4/wlog(*,0),wlog(*,2),psym=-2,thick=3
oplot,4/wlog(*,0),wlog(*,3),psym=-4,thick=3
oplot,4/wlog(*,0),wlog(*,4),psym=-5,thick=3

xyouts,0.002,0.002,'1st order slope'
oplot,[0.0015],[0.16],psym=1 & xyouts,0.002,0.16,'Godunov'
oplot,[0.0015],[0.08],psym=2 & xyouts,0.002,0.08,'+ #LIMITER'
oplot,[0.0015],[0.04],psym=4 & xyouts,0.002,0.04,'+ #NONCONS'
oplot,[0.0015],[0.02],psym=5 & xyouts,0.002,0.02,'+ #MIXED'

close_device,/pdf

exit

