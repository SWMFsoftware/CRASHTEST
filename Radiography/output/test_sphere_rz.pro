; 1. plot results, 2. calculate errors, 3. plot errors

resdir='test_sphere_rz_results/'
; 1. plot results for various solvers and resolutions
filename=resdir+'??/GM/los_var_1*.out'
func='sphere10 {sphere10}-(4./3.)*(100-2e4/(1+2e4/(x^2+y^2))>0)^1.5 ' $
  +       '{usersphere10}-(4./3.)*(100-2e4/(1+2e4/(x^2+y^2))>0)^1.5'
plotmode='contbar
bottomline=0
set_device, resdir + 'sphere.eps', /eps
loadct,39
.r animate
close_device,/pdf

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'LOS integral of a sphere in RZ geometry'
printf,99,'n errorsphere10 errorusersphere10'

; read all 3 resolutions at once
filename=resdir+'??/GM/los_var_1*.out'
.r getpict

; reference solution
ref = (4./3.)*(100-2e4/(1+2e4/(x(*,*,0)^2+x(*,*,1)^2))>0)^1.5
n   = n_elements(ref)

; print out deviation
printf, 99, 20, total(abs(w0(*,*,1)-ref))/n, total(abs(w0(*,*,2)-ref))/n
printf, 99, 40, total(abs(w1(*,*,1)-ref))/n, total(abs(w1(*,*,2)-ref))/n
printf, 99, 80, total(abs(w2(*,*,1)-ref))/n, total(abs(w2(*,*,2)-ref))/n

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),psym=-4,$
  xrange=[1e-2,1e-1],yrange=[1e-3,1e1],$
  charsize=2,thick=3, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="LOS image of a sphere in RZ geometry"

oplot,1/wlog(*,0),wlog(*,2),psym=-5,thick=3

oplot,[1e-2,1e-1],[1e-3,1e-1],linestyle=2,thick=3
xyouts,0.015,0.002,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

exit
