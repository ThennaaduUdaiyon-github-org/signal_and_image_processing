function [u,mask,input] = create_image_and_mask(img_clean, img_mask)
  % Function to apply mask onto the clean image
  
  input = im2double(img_clean); 
  
  % import the mask of the inpainting domain
  % mask = 1 intact part
  % mask = 0 missing domain
  mask  = double( mat2gray( im2double(img_mask) ) == 1 ); 

  if size(mask,3)==1 && size(input,3)>1
      mask = repmat(mask,[1,1,size(input,3)]);
  end

  % Create the image with the missing domain:
  noise = rand(size(input));
  u = mask.*input + (1-mask).*noise; 

endfunction

