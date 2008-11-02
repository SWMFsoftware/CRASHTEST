function calc_error,w,wref
  rho   =w(*,0)
  rhoref=wref(*,0)
  rhoc  =coarsen(rhoref, n_elements(rhoref)/n_elements(rho))
  return,total(abs(rhoc-rho))/total(rhoc)
end
