; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various resolutions
resdir='test_gaussiansemi_cyl_results/'

!p.charsize=2
!p.charthick=1

filename = resdir + '2/GM/z*.outs'
func=' bx bxexact'
plotmode='contbar contbar'
velvector=20
transform='n'
bottomline=1
plottitle="bx bxexact"
multiplot=[2,1,0]
set_device, resdir+'bx.eps', /eps, /land
loadct,26
dpict=2
.r animate
close_device,/pdf


; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'Gaussian test for semi-implicit resistivity'
printf,99,'n error'

; read the last snapshot 
npict=100

filename=resdir+'2/GM/z*.outs'
.r getpict
printf,99,2,(total(abs(w(*,*,0) - w(*,*,1)))) / total(abs(w(*,*,1)))

filename=resdir+'4/GM/z*.outs'
.r getpict
printf,99,4,(total(abs(w(*,*,0) - w(*,*,1)))) / total(abs(w(*,*,1)))

filename=resdir+'8/GM/z*.outs'
.r getpict
printf,99,8,(total(abs(w(*,*,0) - w(*,*,1)))) / total(abs(w(*,*,1)))

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-1,1],yrange=[1e-3,1e-1],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='relative L1 error', $
        title="Gaussian test for semi-implicit resistivity"
oplot,[1e-1,1],[1e-3,1e-1],linestyle=2,thick=3
xyouts,0.4,0.01,'2nd order slope',charsize=2,charthick=1
close_device,/pdf

exit
