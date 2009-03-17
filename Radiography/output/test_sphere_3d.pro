; 1. plot results, 2. calculate errors, 3. plot errors

resdir='test_sphere_3d_results/'
; 1. plot results for various solvers and resolutions
filename=resdir+'??/GM/los*.out'
func='sphere10 {sphere10}-(4./3.)*(100-2e4/(1+2e4/(x^2+y^2))>0)^1.5
plotmode='contbar
bottomline=0
set_device, resdir + 'sphere.eps', /eps
loadct,39
.r animate
close_device
spawn,'cd '+resdir+'; convert sphere.eps sphere.pdf'

; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'LOS integral of a sphere in 3D'
printf,99,'n error'

; read all 3 resolutions at once
filename=resdir+'??/GM/los*.out'
.r getpict

; reference solution
ref = (4./3.)*(100-2e4/(1+2e4/(x(*,*,0)^2+x(*,*,1)^2))>0)^1.5

; print out deviation
printf,99,20,total(abs(w0(*,*,1)-ref))/n_elements(ref)
printf,99,40,total(abs(w1(*,*,1)-ref))/n_elements(ref)
printf,99,80,total(abs(w2(*,*,1)-ref))/n_elements(ref)

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-2,1e-1],yrange=[1e-3,1e-1],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="LOS image of a sphere in 3D"
oplot,[1e-2,1e-1],[1e-3,1e-1],linestyle=2,thick=3
xyouts,0.015,0.002,'2nd order slope',charsize=2,charthick=1
close_device
spawn,'cd '+resdir+'; ps2pdf error.eps'

exit
