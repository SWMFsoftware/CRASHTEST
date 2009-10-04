function calc_error_lightfront,x,w
  nx = n_elements(x)
  wref=dblarr(nx,2)
  for ix=0,nx-1 do begin
     if x(ix) le 0.5 then begin
        wref(ix,0)=1
        wref(ix,1)=0
     endif else begin
        wref(ix,0)=0
        wref(ix,1)=1
     endelse
  endfor
  return,total(abs(w(*,0)-wref(*,0))*w(*,2)) + $
         total(abs(w(*,1)-wref(*,1))*w(*,2))
end
