clc;
clearvars;
%Declaration of fuzzy inference system
My_fis = mamfis("name","fuzzy_controller","Andmethod","prod","DefuzzificationMethod","centroid");
%adding  inputs
num_inputs =2;
My_fis = addInput(My_fis,[-1 1 ],'name' ,"error");
My_fis = addInput(My_fis,[-1 1 ],'name' ,"Rate of error");
%%adding  outputs
My_fis = addOutput(My_fis,[-1 1 ],'name' ,"op");
%% defining and adding memebership functions in generated fis
num_input_MFS =3;
input_mf_names =["negative";"zero";"positive"];
% paramaters of different membership functions for input
params_input_MF(:,:,1) = [-1000 -1 0; -1 0 1; 0 1 1000];
params_input_MF(:,:,2 ) = [-1000 -1 0; -1 0 1; 0 1 1000];
for i= 1:num_inputs
    for j= 1:num_input_MFS
        My_fis =addMF(My_fis,My_fis.Inputs(i).name,"trimf",params_input_MF(j,:,i),'name',input_mf_names(j));
    end
end
%% defining and adding membership functions to outputs of fis
op_mf1 = fismf("zmf",[-0.9 -0.75],'name',"neg_large");
op_mf2 = fismf("gaussmf",[0.2 -0.5],'name',"neg");
op_mf3 = fismf("gaussmf",[0.2 0],'name',"zero");
op_mf4 = fismf("gaussmf",[0.2 0.5],'name',"pos");
op_mf5 = fismf("smf",[0.75 0.9],'name',"pos_large");
My_fis.Outputs(1).MembershipFunctions = [op_mf1 op_mf2 op_mf3 op_mf4 op_mf5];

 %%
 plotmf(My_fis,'input',1);
