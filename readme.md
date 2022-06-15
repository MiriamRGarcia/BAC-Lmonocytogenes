
Here we provide the scripts with the model and data (provided by Marta L. Cabo IIM-CSIC) used 
to simulate time-kill curves of *L. monocytogenes* with benzalkonium chloride the most common quaternary ammonium compound.

The model explains and predicts the interplay between disinfectant and pathogen at 
different initial microbial densities (inocula) and dose concentrations. 


In order to run these scripts, users will need:

- a Matlab R2015 (or later) installation, under Windows or Linux operating systems
- the AMIGO2 toolbox available at: https://sites.google.com/site/amigo2toolbox/download (Eva Balsa-Canto IIM-CSIC)
- Originallly the code was tested in Matlab2016b and AMIGO2019


Users need to make sure that the above AMIGO2 toolbox is fully functional before attempting to run the scripts. 
Please refer to the AMIGO2 documentation.


INSTRUCTIONS

1. Open matlab and go to the folder where the file MAIN is
2. Run BAC_Ecoli_main and add the AMIGO path when asked
	*  If it does not work, you probably need to configurate AMIGO2 in matlab to use c++. See https://sites.google.com/site/amigo2toolbox for details
	* Alternatively, 
		* edit Kinetics files (Kinetics_calibration & Kinetics_validtion')  and change line      inputs.model.input_model_type='charmodelC'; by inputs.model.input_model_type='charmodelM';
		* To assure the optimum is achieved, increase optimization time (inputs.nlpsol.eSS.maxtime).
        
