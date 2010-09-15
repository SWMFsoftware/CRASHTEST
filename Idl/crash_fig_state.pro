; create a figure for final state of a CRASH simulation
filename = 'z=0_var_1_*.outs'
npict=1000
transform = 'n'
.r getpict

loadct,39
transform='n'
!p.charsize=1.7
!p.font=0
!x.range=[0,2300]

func='level dx ux tekev tikev rho uy trkev {p}'

; check for electron pressure
if fix(total(wnames eq 'pe')) then $
  func = 'level dx ux tekev tikev rho uy trkev {p}+{pe}' $
else $
  func = 'level dx ux tekev tekev rho uy trkev p

multiplot=[2,4,1]
plotmode='contbar contover contbar contbarlog contbarlog contbarlog contbar contbarlog contbarlog'
plottitle='Material and AMR levels; ;X Velocity [km/s];log Electron Temp. [keV];log Ion Temp. [keV];log Density [g/cm!U3!N];Y Velocity [km/s];log Radiation Temp. [keV];log Pressure [GPa]'
bottomline = "'time = ' + string(time*1e9, format='(f4.1)')+' ns'"
set_device,'crash_final_state.eps',/eps
.r plotfunc
close_device,/pdf
