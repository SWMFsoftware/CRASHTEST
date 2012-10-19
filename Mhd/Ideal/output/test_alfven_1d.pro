; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various schemes and resolutions

resdir='test_alfven_1d_results/'

firstpict=21
npictmax=1
func='uy uz by bz'
!p.charsize=1.4
!p.thick=3
bottomline='"              n ="+snx'

filename = resdir+'ORDER2_??/GM/*.outs'
set_device,resdir+'order2.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'ORDER4_??/GM/*.outs'
set_device,resdir+'order4.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'ORDER5_??/GM/*.outs'
set_device,resdir+'order5.eps',/eps, /land
.r animate
close_device,/pdf

; 2. calculate errors and save them into a file

openw,99,resdir+'error.dat'
printf,99,'Alfven wave test in 1D'
printf,99,'n order2 order4 order5'

; array of errors for a given resolution
errors = fltarr(3,3)

; compare uy, uz, by, bz only
iws=[2,3,4,5]

; read at most 3 files at a time
filename=resdir+'ORDER2_??/GM/1d*.outs'

; read the initial states
npict=1
.r getpict
wref0=w0 & wref1=w1 & wref2 = w2
; read final states
npict=21
.r getpict
errors(0,*) = [rel_error(w0,wref0,iws), $
               rel_error(w1,wref1,iws), $
               rel_error(w2,wref2,iws)]

filename=resdir+'ORDER4_??/GM/1d*.outs'
; read the initial states
npict=1
.r getpict
wref0=w0 & wref1=w1 & wref2 = w2
; read final states
npict=21
.r getpict
errors(1,*) = [rel_error(w0,wref0,iws), $
               rel_error(w1,wref1,iws), $
               rel_error(w2,wref2,iws)]

filename=resdir+'ORDER5_??/GM/1d*.outs'
; read the initial states
npict=1
.r getpict
wref0=w0 & wref1=w1 & wref2 = w2
; read final states
npict=21
.r getpict
errors(2,*) = [rel_error(w0,wref0,iws), $
               rel_error(w1,wref1,iws), $
               rel_error(w2,wref2,iws)]


printf,99,24,errors(*,0),format='(i3,4f13.10)'
printf,99,48,errors(*,1),format='(i3,4f13.10)'
printf,99,96,errors(*,2),format='(i3,4f13.10)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1
!p.thick=3

set_device,resdir+'error.eps',/eps, /land
logfilename=resdir+'error.dat'
.r getlog

; error.dat header: 'n godunov g_noncons linde l_noncons'

plot_oo,[0.01,0.1],[3e-6,3e-2], $
  xrange=[0.005,0.1],yrange=[1e-7,1e-1],linestyle=2,xstyle=1,ystyle=1, $
  xtitle='Grid resolution / wave length', $
  ytitle='Relative error', $
  title="Alfven wave test in 1D"

oplot,[0.01,0.1],[1e-3,1e-1],linestyle=1

oplot,[0.01,0.1],[1e-7,1e-2],linestyle=3

oplot,1./wlog(*,0),wlog(*,1),psym=-4
oplot,1./wlog(*,0),wlog(*,2),psym=-5
oplot,1./wlog(*,0),wlog(*,3),psym=-1

oplot,[0.0055,0.006],[1e-3,1e-3],linestyle=1 & xyouts,0.0062,1e-3,'2nd order slope'
oplot,[0.0057],[3e-3],psym=4 & xyouts,0.0062,3e-3,'2nd order scheme'

oplot,[0.0055,0.006],[1e-4,1e-4],linestyle=2 & xyouts,0.0062,1e-4,'4th order slope'
oplot,[0.0057],[3e-4],psym=5 & xyouts,0.0062,3e-4,'4th order scheme'

oplot,[0.0055,0.006],[1e-5,1e-5],linestyle=3 & xyouts,0.0062,1e-5,'5th order slope'
oplot,[0.0057],[3e-5],psym=6 & xyouts,0.0062,3e-5,'5th order scheme'

close_device,/pdf

exit
