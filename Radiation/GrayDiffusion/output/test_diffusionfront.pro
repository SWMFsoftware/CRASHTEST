physics='hd11'

; 1. plot results

resdir='test_diffusionfront_results/'

filename = resdir+'test_diffusionfront/GM/cut*.outs'
npict = 11
.r getpict

!p.charsize=2
!p.charthick=1
set_device, resdir + 'Tmat.eps', /eps, /land
func='tkev'
plot,x,w(*,1)*1000.0, $
     xrange=[0.,0.008],yrange=[0.,100.],$
     linestyle=0,thick=3, $
     xtitle='x (cm)', $
     ytitle='material temperature (eV)', $
     title="Diffusion front test in 1D"
close_device,/pdf

set_device, resdir + 'Trad.eps', /eps, /land
func='trkev'
plot,x,w(*,2)*1000.0, $
     xrange=[0.,0.008],yrange=[0.,100.],$
     linestyle=0,thick=3, $
     xtitle='x (cm)', $
     ytitle='radiation temperature (eV)', $
     title="Diffusion front test in 1D"
close_device,/pdf

exit
