; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

; use local procedure to write out resolution only
.r putbottom 

resdir='test_wave_amr_results/'

firstpict=16
npictmax=1
func='rho ux uy p'
!p.charsize=1.4
!p.thick=3

filename = resdir+'Linde_100_/GM/z*.outs'
set_device,resdir+'linde_amr.eps',/epe, /land
plotmode='contbargrid'
multiplot=-4
transform='n'
.r animate
close_device,/pdf
multiplot=0

filename = resdir+'Godunov_*0_/GM/c*.outs'
set_device,resdir+'godunov.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*0_NONCONS/GM/c*.outs'
set_device,resdir+'godunov_noncons.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_/GM/c*.outs'
set_device,resdir+'linde.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_NONCONS/GM/c*.outs'
set_device,resdir+'linde_noncons.eps',/epe, /land
.r animate
close_device,/pdf

; 2. calculate errors and save them into a file

filename='test_wave_1d_ref.out'
.r getpict
wref = w

; rotate velocity vector by atan(0.5)
wref(*,2) =  wref(*,1)/sqrt(5d0)
wref(*,1) = 2*wref(*,1)/sqrt(5d0)

openw,99,resdir+'error.dat'
printf,99,'Wave test with 2D AMR'
printf,99,'n godunov g_noncons linde l_noncons'

; array of errors for a given resolution
errors = fltarr(4,3)

; read the last state for comparison
npict=16

; compare density, velocity and pressure only (velocity error dominates)
iws=[0,1,2,4]

; read at most 3 files at a time
; coarsen files so that staircases in the coarse regions disappear.
filename=resdir+'Godunov_???_/GM/c*.outs'
.r getpict
w0 = coarsen(w0,[2,1]) & w1 = coarsen(w1,[2,1]) & w2 = coarsen(w2,[2,1])
errors(0,*) = [rel_error(w0,wref,iws), $
               rel_error(w1,wref,iws), $
               rel_error(w2,wref,iws)]

filename=resdir+'Godunov_???_NONCONS/GM/c*.outs'
.r getpict
w0 = coarsen(w0,[2,1]) & w1 = coarsen(w1,[2,1]) & w2 = coarsen(w2,[2,1])
errors(1,*) = [rel_error(w0,wref,iws), $
               rel_error(w1,wref,iws), $
               rel_error(w2,wref,iws)]

filename=resdir+'Linde_???_/GM/c*.outs'
.r getpict
w0 = coarsen(w0,[2,1]) & w1 = coarsen(w1,[2,1]) & w2 = coarsen(w2,[2,1])
errors(2,*) = [rel_error(w0,wref,iws), $
               rel_error(w1,wref,iws), $
               rel_error(w2,wref,iws)]

filename=resdir+'Linde_???_NONCONS/GM/c*.outs'
.r getpict
w0 = coarsen(w0,[2,1]) & w1 = coarsen(w1,[2,1]) & w2 = coarsen(w2,[2,1])
errors(3,*) = [rel_error(w0,wref,iws), $
               rel_error(w1,wref,iws), $
               rel_error(w2,wref,iws)]

printf,99,100,errors(*,0),format='(i3,4f9.6)'
printf,99,200,errors(*,1),format='(i3,4f9.6)'
printf,99,400,errors(*,2),format='(i3,4f9.6)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1
!p.thick=3

set_device,resdir+'error.eps',/epe, /land
logfilename=resdir+'error.dat'
.r getlog

; error.dat header: 'n godunov g_noncons linde l_noncons'

plot_oo,[1e-2,1e-1],[1e-4,1e-2], $
  xrange=[1e-3,1e-1],yrange=[1e-4,5e-2],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Sound wave test with 2D AMR"
oplot,4/wlog(*,0),wlog(*,1),psym=-1
oplot,4/wlog(*,0),wlog(*,2),psym=-2
oplot,4/wlog(*,0),wlog(*,3),psym=-4
oplot,4/wlog(*,0),wlog(*,4),psym=-5

oplot,[0.0002,0.0017],[0.0005,0.0005],linestyle=2
xyouts,0.002,0.0005,'2nd order slope'
oplot,[0.0015],[0.016],psym=4 & xyouts,0.002,0.016,'Linde conserv.'
oplot,[0.0015],[0.008],psym=1 & xyouts,0.002,0.008,'Godunov conserv.'
oplot,[0.0015],[0.004],psym=5 & xyouts,0.002,0.004,'Linde noncons.'
oplot,[0.0015],[0.002],psym=2 & xyouts,0.002,0.002,'Godunov noncons.'

close_device,/pdf

exit
