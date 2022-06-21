# FDENET: a feature-division ensemble framework for gene regulatory network inference

## Description

The method, FDENET, was created and tested using  MATLAB®  2016b. Please refer to our manuscript termed “FDENET: a feature-division ensemble framework for gene regulatory network inference” for more detailed information about this algorithm.

## The describe of the files

main.m is the running script of FDENET.

moduleOne.m - moduleFour.m are four modules used in FDENET.

pluggableBlockOne.m - pluggableBlockFour.m are pluggable blocks of each module for finding the ambiguous relations.

getDataSet.m is a function for getting the specific dataset in DREAM3 or DREAM4 challenges.

getGlodNet.m is a function for getting the corresponding standard network of the current dataset.

getPRIR.m is a function for finding the potentially redundant indirect relations in three-node closing loops.

getConfidenceInterval.m calculates the confidence interval at 95.5% confidence level for all genes.

getBalanceConcentration.m calculates the balance concentration of all genes under a specific network.

buildOrUpdate.m is a function for buiding or updating a network according to the existed information and alpha1. The parameter "updateFlag" controls whether the function builds the network or updates the network.

instructExperiment.m is a function of simulating the guiding process of biochemical experiments and receiving the feedback.

updateAndUpload.m is a function for uploading the information to the global register and updatting the network.

separate.m is a function that identifies a relation whether or not an ambiguous relation according to conditional mutual information (CMI).

cmi.m is a function for calculating the CMI.  This code is derived from a paper termed "[Inferring gene regulatory networks from gene expression data by path consistency algorithm based on conditional mutual information](https://www.researchgate.net/publication/220262053_Inferring_gene_regulatory_networks_from_gene_expression_data_by_path_consistency_algorithm_based_on_conditional_mutual_information)" by Zhang et al., 2012. 

## The describe of the folders

The folder "data10 " contains datasets of 10-gene networks in DREAM3.

The folder "data50 " contains datasets of 50-gene networks in DREAM3.

The folder "data100 " contains datasets of 100-gene networks in DREAM3.

The folder "gold" contains the standard networks of all datasets in DREAM3.

The folder "DREAM4_InSilico_Size10" contains datasets of 10-gene networks in DREAM4.

The folder "DREAM4_InSilico_Size100" contains datasets of 100-gene networks in DREAM4.

The folder "DREAM4_InSilicoNetworks_GoldStandard" contains the standard networks of all datasets in DREAM4.

The folder "detailed_information" contains  the detailed information about DREAM3 and DREAM4 challenges.

## Datasets

You can also find the entire dataset of DREAM3 in [here](https://dreamchallenges.org/dream-3-in-silico-network-challenge/) and the entire dataset of DREAM4 in [here](https://dreamchallenges.org/dream-4-in-silico-network-challenge/).

## FDENET

You can run the "main.m" to get the results of FDENET.

### Getting the result of one dataset

By setting the DS and the while loop, you can get the result of FDENET on dataset No.9.

```matlab
DS = 9; 
while DS == 9 % get the result of No.9 dataset
	......
end
```

### Getting the results of multiple dataset

You can get the results of FDENET of No.1-No.20 datasets by following changes.

```matlab
DS = 1;
while DS <= 20 % get the result of No.1 to No.20 datasets
	......
end
```

### Getting the result of FDENET without introducing extra experimental information 

To get the result of FDENET without introducing extra experimental information, you should comment out these codes in the following files:

moduleOne.m

```matlab
[numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
numOfEXP = numOfEXP + numOfECM;
numOfUFEXP = numOfUFEXP + size(LVRIR, 1);
numOfULEXP = numOfULEXP + size(LVDR, 1);
```

moduleTwo.m

```matlab
[numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
workspaceOfModuleFour = LVRIR;
numOfEXP = numOfEXP + numOfECM;
numOfUFEXP = numOfUFEXP + size(LVRIR, 1);
numOfULEXP = numOfULEXP + size(LVDR, 1);
```

moduleThree.m

```matlab
[numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
numOfEXP = numOfEXP + numOfECM;
numOfUFEXP = numOfUFEXP + size(LVDR, 1);
numOfULEXP = numOfULEXP + size(LVRIR, 1);
```

moduleFour.m

```matlab
[numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
numOfEXP = numOfEXP + numOfECM;
numOfUFEXP = numOfUFEXP + size(LVDR, 1);
numOfULEXP = numOfULEXP + size(LVRIR, 1);
```

updateAndUpload.m

```matlab
GVRIR = [GVRIR; LVRIR];
GVDR = [GVDR; LVDR];
GVRIR = unique(GVRIR, 'rows');
GVDR = unique(GVDR, 'rows');
```

and you should add these codes in the following files:

moduleOne.m

```matlab
%[numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
%numOfEXP = numOfEXP + numOfECM;
%numOfUFEXP = numOfUFEXP + size(LVRIR, 1);
%numOfULEXP = numOfULEXP + size(LVDR, 1);
LVRIR = ARS;
LVDR = [];
```

moduleTwo.m

```matlab
%[numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
%workspaceOfModuleFour = LVRIR;
%numOfEXP = numOfEXP + numOfECM;
%numOfUFEXP = numOfUFEXP + size(LVRIR, 1);
%numOfULEXP = numOfULEXP + size(LVDR, 1);
LVRIR = ARS;
LVDR = [];
workspaceOfModuleFour = LVRIR;
```

moduleThree.m

```matlab
%[numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
%numOfEXP = numOfEXP + numOfECM;
%numOfUFEXP = numOfUFEXP + size(LVDR, 1);
%numOfULEXP = numOfULEXP + size(LVRIR, 1);
LVRIR = [];
LVDR = ARS;
```

moduleFour.m

```matlab
%[numOfECM, LVRIR, LVDR] = instructExperiment(ARS);
%numOfEXP = numOfEXP + numOfECM;
%numOfUFEXP = numOfUFEXP + size(LVDR, 1);
%numOfULEXP = numOfULEXP + size(LVRIR, 1);
LVRIR = [];
LVDR = ARS;
```

### Getting the results of FDENET with different sequences of modules

By running the mainInDifferentOrder.m, you can get the results of FDENET with different sequences of modules.

### Result

After the Main program runs, you can get the statistical results from the "result" variable in the workspace.
