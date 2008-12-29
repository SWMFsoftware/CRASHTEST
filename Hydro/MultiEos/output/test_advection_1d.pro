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
set_device,resdir+'godunov.eps',/eps
.r animate
close_device
spawn,'cd '+resdir+'; convert godunov.eps godunov.pdf'

filename = resdir+'Godunov_*_LIMIT/GM/*.outs'
set_device,resdir+'godunov_limit.eps',/eps
.r animate
close_device
spawn,'cd '+resdir+'; convert godunov_limit.eps godunov_limit.pdf'

filename = resdir+'Godunov_*_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'godunov_limit_lookup.eps',/eps
.r animate
close_device
spawn,'cd '+resdir+';convert godunov_limit_lookup.eps godunov_limit_lookup.pdf'

filename = resdir+'Godunov_*_NONCONS/GM/*.outs'
set_device,resdir+'godunov_noncons.eps',/eps
.r animate
close_device
spawn,'cd '+resdir+'; convert godunov_noncons.eps godunov_noncons.pdf'

filename = resdir+'Godunov_*_LIMIT_MIXED/GM/*.outs'
set_device,resdir+'godunov_limit_mixed.eps',/eps
.r animate
close_device
spawn,'cd '+resdir+'; convert godunov_limit_mixed.eps godunov_limit_mixed.pdf'

filename = resdir+'Godunov_*_LIMIT_MIXED_LOOKUP/GM/*.outs'
set_device,resdir+'godunov_limit_mixed_lookup.eps',/eps
.r animate
close_device
spawn,'cd '+resdir+ $
      '; convert godunov_limit_mixed_lookup.eps godunov_limit_mixed_lookup.pdf'

; 2. calculate errors and save them into a file

openw,99,resdir+'error.dat'
printf,99,'Advection test in 1D'
printf,99,'n godunov g_lim g_noncons g_lim_look g_lim_mix g_lim_mix_look ' $
  +          ' linde l_lim l_noncons l_lim_look l_lim_mix l_lim_mix_look'

; array of errors for a given resolution
errors = fltarr(12)

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
close_device

; read the last state for comparison
npict=10

; read at most 3 files at a time
filename=resdir+'Godunov_40_/GM/c*.outs ' $
  +      resdir+'Godunov_40_LIMIT/GM/c*.outs ' $
  +      resdir+'Godunov_40_NONCONS/GM/c*.outs'
.r getpict
errors(0)=calc_error(w0,wref)
errors(1)=calc_error(w1,wref)
errors(2)=calc_error(w2,wref)

filename=resdir+'Godunov_40_LIMIT_*/GM/c*.outs'
.r getpict
errors(3)=calc_error(w0,wref)
errors(4)=calc_error(w1,wref)
errors(5)=calc_error(w2,wref)

filename=resdir+'Linde_40_/GM/c*.outs ' $
  +      resdir+'Linde_40_LIMIT/GM/c*.outs ' $
  +      resdir+'Linde_40_NONCONS/GM/c*.outs'
.r getpict
errors(6)=calc_error(w0,wref)
errors(7)=calc_error(w1,wref)
errors(8)=calc_error(w2,wref)

filename=resdir+'Linde_40_LIMIT_*/GM/c*.outs'
.r getpict
errors(9)=calc_error(w0,wref)
errors(10)=calc_error(w1,wref)
errors(11)=calc_error(w2,wref)

printf,99,40,errors,format='(i3,12f7.4)'

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

; read at most 3 files at a time
filename=resdir+'Godunov_80_/GM/c*.outs ' $
  +      resdir+'Godunov_80_LIMIT/GM/c*.outs ' $
  +      resdir+'Godunov_80_NONCONS/GM/c*.outs'
.r getpict
errors(0)=calc_error(w0,wref)
errors(1)=calc_error(w1,wref)
errors(2)=calc_error(w2,wref)

filename=resdir+'Godunov_80_LIMIT_*/GM/c*.outs'
.r getpict
errors(3)=calc_error(w0,wref)
errors(4)=calc_error(w1,wref)
errors(5)=calc_error(w2,wref)

filename=resdir+'Linde_80_/GM/c*.outs ' $
  +      resdir+'Linde_80_LIMIT/GM/c*.outs ' $
  +      resdir+'Linde_80_NONCONS/GM/c*.outs'
.r getpict
errors(6)=calc_error(w0,wref)
errors(7)=calc_error(w1,wref)
errors(8)=calc_error(w2,wref)

filename=resdir+'Linde_80_LIMIT_*/GM/c*.outs'
.r getpict
errors(9) =calc_error(w0,wref)
errors(10)=calc_error(w1,wref)
errors(11)=calc_error(w2,wref)

printf,99,80,errors,format='(i3,12f7.4)'

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

; read at most 3 files at a time
filename=resdir+'Godunov_160_/GM/c*.outs ' $
  +      resdir+'Godunov_160_LIMIT/GM/c*.outs ' $
  +      resdir+'Godunov_160_NONCONS/GM/c*.outs'
.r getpict
errors(0)=calc_error(w0,wref)
errors(1)=calc_error(w1,wref)
errors(2)=calc_error(w2,wref)

filename=resdir+'Godunov_160_LIMIT_*/GM/c*.outs'
.r getpict
errors(3)=calc_error(w0,wref)
errors(4)=calc_error(w1,wref)
errors(5)=calc_error(w2,wref)

filename=resdir+'Linde_160_/GM/c*.outs ' $
  +      resdir+'Linde_160_LIMIT/GM/c*.outs ' $
  +      resdir+'Linde_160_NONCONS/GM/c*.outs'
.r getpict
errors(6)=calc_error(w0,wref)
errors(7)=calc_error(w1,wref)
errors(8)=calc_error(w2,wref)

filename=resdir+'Linde_160_LIMIT_*/GM/c*.outs'
.r getpict
errors(9)=calc_error(w0,wref)
errors(10)=calc_error(w1,wref)
errors(11)=calc_error(w2,wref)

printf,99,160,errors,format='(i3,12f7.4)'

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
  +      resdir+'Godunov_320_NONCONS/GM/c*.outs'
.r getpict
errors(0)=calc_error(w0,wref)
errors(1)=calc_error(w1,wref)
errors(2)=calc_error(w2,wref)

filename=resdir+'Godunov_320_LIMIT_*/GM/c*.outs'
.r getpict
errors(3)=calc_error(w0,wref)
errors(4)=calc_error(w1,wref)
errors(5)=calc_error(w2,wref)

filename=resdir+'Linde_320_/GM/c*.outs ' $
  +      resdir+'Linde_320_LIMIT/GM/c*.outs ' $
  +      resdir+'Linde_320_NONCONS/GM/c*.outs'
.r getpict
errors(6)=calc_error(w0,wref)
errors(7)=calc_error(w1,wref)
errors(8)=calc_error(w2,wref)

filename=resdir+'Linde_320_LIMIT_*/GM/c*.outs'
.r getpict
errors(9)=calc_error(w0,wref)
errors(10)=calc_error(w1,wref)
errors(11)=calc_error(w2,wref)

printf,99,320,errors,format='(i3,12f7.4)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device,resdir+'error.eps',/eps
logfilename=resdir+'error.dat'
.r getlog

; The Godunov part of the header of error.dat:
; n godunov g_lim g_noncons g_lim_look g_lim_mix g_lim_mix_look

plot_oo,[1e-3,1e-1],[1e-3,1e-1], $
  xrange=[1e-3,1e-1],yrange=[2e-3,2e-1],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Be/Xe advection test in 1D"
oplot,4/wlog(*,0),wlog(*,1),psym=-1,thick=3
oplot,4/wlog(*,0),wlog(*,2),psym=-2,thick=3
oplot,4/wlog(*,0),wlog(*,3),psym=-4,thick=3
oplot,4/wlog(*,0),wlog(*,5),psym=-5,thick=3
oplot,4/wlog(*,0),wlog(*,6),psym=-6,thick=3

oplot,[0.0012,0.0017],[0.005,0.005],linestyle=2
xyouts,0.002,0.005,'1st order slope'
oplot,[0.0015],[0.16],psym=1 & xyouts,0.002,0.16,'Godunov'
oplot,[0.0015],[0.08],psym=2 & xyouts,0.002,0.08,'+ #LIMITER'
oplot,[0.0015],[0.04],psym=4 & xyouts,0.002,0.04,'+ #NONCONS'
oplot,[0.0015],[0.02],psym=5 & xyouts,0.002,0.02,'+ #MIXED'
oplot,[0.0015],[0.01],psym=6 & xyouts,0.002,0.01,'+ #MIXED + #LOOKUP'

close_device
spawn,'cd '+resdir+'; ps2pdf error.eps'

exit

