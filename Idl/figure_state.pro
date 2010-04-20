; create figure for gray or multigroup run without electron physics
filename = 'z*.outs'
npict=1000
.r getpict
loadct,39
transform='n'
!p.charsize=1.7
!p.font=0
!x.range=[0,2300]
func='level dx ux tekev tekev rho uy trkev p'
multiplot=[2,4,1]
plotmode='contbar contover contbar contbarlog contbarlog contbarlog contbar contbarlog contbarlog'
plottitle='Level Set;Level Set;X Velocity [km/s];log Electron Temp. [keV];log Ion Temp. [keV];log Density [g/cm!U3!N];Y Velocity [km/s];log Radiation Temp. [keV];log Pressure [GPa]'
bottomline = "'time = ' + string(time*1e9, format='(f4.1)')+' ns'"
set_device,'multigroup.eps',/pdf
.r plotfunc
close_device
