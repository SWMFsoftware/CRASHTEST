; create a movie for gray or multigroup full system runs
;window,xsize=640,ysize=388
window,xsize=960,ysize=582
filename = 'z=0_var_1_*.outs'
npict=1
transform='n'
.r getpict

loadct,39
!p.charsize=1.7
!p.font=0
!x.range=[0,2300]

; check for electron pressure
if fix(total(wnames eq 'pe')) then $
  func='level dx ux tekev tikev rho uy trkev {p}+{pe}' $
else $
  func='level dx ux tekev tekev rho uy trkev p'

;autorange='y y y n n y y n y'
;temin = 1e-4
;temax = 1.
;fmin=[1., 1., 1., temin, temin, 1., 1., temin, 1.]
;fmax=[1., 1., 1., temax, temax, 1., 1., temax, 1.]

multiplot=[2,4,1]
plotmode='contbar contover contbar contbarlog contbarlog contbarlog contbar contbarlog contbarlog'
plottitle='Material and AMR levels; ;X Velocity [km/s];log Electron Temp. [keV];log Ion Temp. [keV];log Density [g/cm!U3!N];Y Velocity [km/s];log Radiation Temp. [keV];log Pressure [GPa]'
bottomline = "'time = ' + string(time*1e9, format='(f4.1)')+' ns'"
spawn, 'rm -rf Movie'
savemovie='png'
firstpict=1
npictmax=1000
.r animate

