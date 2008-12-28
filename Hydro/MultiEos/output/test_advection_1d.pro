; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

; use local procedure to write out resolution only
.r putbottom 

resdir='test_advection_1d_results/'

firstpict=6
npictmax=1
func='p ux'
!p.charsize=1.6

filename = resdir+'Linde_*_/GM/*.outs'
plottitle='p (Linde);ux (Linde)'
set_device,resdir+'Linde.eps',/eps
.r animate
close_device
spawn,'cd '+resdir+'; convert Linde.eps Linde.pdf'

filename = resdir+'Godunov_*_/GM/*.outs'
plottitle='p (Godunov);ux (Godunov)'
set_device,resdir+'Godunov.eps',/eps
.r animate
close_device
spawn,'cd '+resdir+'; convert Godunov.eps Godunov.pdf'

; 2. calculate errors and save it into a file
; order is Godunov, Linde, Rusanov (alphabetical) for sake of simplicity

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
; the left state is advected up to 3/4 of the domain
for i=1,29 do w(i,*)=w(0,*)
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
; the left state is advected up to 3/4 of the domain
for i=1,59 do w(i,*)=w(0,*)
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
; the left state is advected up to 3/4 of the domain
for i=1,119 do w(i,*)=w(0,*)
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

close,99
exit

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device,resdir+'error.eps',/eps
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

close_device
spawn,'cd '+resdir+'; ps2pdf error.eps'

exit
