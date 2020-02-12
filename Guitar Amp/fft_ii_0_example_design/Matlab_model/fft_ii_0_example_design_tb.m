
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% file : fft_ii_0_example_design_tb.m

%

% Description : The following Matlab testbench excercises the Altera FFT Model fft_ii_0_example_design_model.m

% generated by Altera's FFT Megacore and outputs results to text files.

%

% Copyright Altera

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read transform sizes from source text file

fidnps = fopen('../test_data/fft_ii_0_example_design_blksize_report.txt','r');

fidinv = fopen('../test_data/fft_ii_0_example_design_inverse_report.txt','r');

% Note: fft_ii_0_example_design_blksize_report.txt is generated when the HDL simulation is run, so if it does

% not exist then flag an error

if fidnps == -1 

  msgbox('Error: fft_ii_0_example_design_blksize_report does not exist, run the HDL simulation first.', 'fft_ii_0_example_design_blksize_report.txt missing', 'error');

elseif fidinv == -1 

  msgbox('Error: fft_ii_0_example_design_inverse_report does not exist, run the HDL simulation first.', 'fft_ii_0_example_design_inverse_report.txt missing', 'error');

else

  % Read input complex vector, and transform sizes from source text files 

  fidr = fopen('../test_data/fft_ii_0_example_design_real_input.txt','r');                                            

  fidi = fopen('../test_data/fft_ii_0_example_design_imag_input.txt','r');


  xreali=fscanf(fidr,'%d');                                                      

  ximagi=fscanf(fidi,'%d');


  nps=fscanf(fidnps,'%d');

  inverse=fscanf(fidinv,'%d'); 

  fclose(fidi);                                                                  

  fclose(fidr);   

  fclose(fidnps); 

  % Create input complex row vector from source text files 

  x = xreali' + j*ximagi';

  [y] = fft_ii_0_example_design_model(x,nps,inverse); 

  fidro = fopen('fft_ii_0_example_design_real_output_c_model.txt','w');                                  

  fidio = fopen('fft_ii_0_example_design_imag_output_c_model.txt','w');



    fprintf(fidro,'%d\n',real(y));                                                 

    fprintf(fidio,'%d\n',imag(y));



  fclose(fidro);                                                                 

  fclose(fidio);

end



