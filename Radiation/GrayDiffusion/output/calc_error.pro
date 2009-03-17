function calc_error,w,wref
  temp   =w(*,0)
  tempref=wref(*,0)
  tempc  =coarsen(tempref, n_elements(tempref)/n_elements(temp))
  return,total(abs(tempc-temp))/total(tempc)
end
