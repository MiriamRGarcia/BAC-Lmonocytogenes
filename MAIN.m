
clear all
close all
clc

amigo_path=input('write amigo path (example: foo/AMIGO2R2019 ) :','s')
run([amigo_path,'./AMIGO_Startup.m']);

% Re-estimate model?
reply = input('Do you want to calibrate again the kinetic model and overwrite saved data? \n for yes write y\n for NO write n \n','s');
if reply=='y'
    disp('Note that this calibration starts from the optimum and uses a local solver')
    disp(' for changing this edit the file Kinetics_calibration')
    pause(2)
    Kinetics_calibration
    save('Kinetics_calibration_Data')
end

% Re-simlate model?
reply2 = input('Do you want to simulate again the kinetic validation and overwrite saved data? \n for yes write y\n for NO write n \n','s');
if reply2=='y'
    disp('Simulation of all experiments (file Kinetics_validation) will start shortly')
    pause(1)
    Kinetics_validation
    save('Kinetics_validation_Data')
end

% Plot results?
reply3 = input('Do you want to plot again results and save figures? \n for yes write y\n for NO write n \n','s');
if reply3=='y'
    Plot_results
end

