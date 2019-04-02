# DNA HyperNetwork

Sourcecode for the paper entitled to "Enzymatic Weight Update Algorithm for DNA-Based Molecular Learning."

  - Tested Matlab Test Version: R2018b
  - Tested Device Specification: Intel Core i7-8700K, 32GB Memory, GTX 1080 GPU, Windows 10

# Required Library
Please include the **lib directory** and also the **all of the below directories** in the lib folder.
  - ERRORBARXY, MNIST_Two-layer Perceptron, shadedErrorBar, HN

# Required Toolbox
Please install below toolbox from Matlab, the toolboxes will be provided when it is missing. **Follow the instructions given from the matlab command window**.
  - Communications Toolbox 7.0, Control Systems Toolbox 10.5, curve Fitting Toolbox 3.5.8, Data Acqusition Toolbox 3.14, Deep Learning Toolbox 12.0, DSP System Toolbox 9.7, Image Processing Toolbox 10.3, Instrument Control Toolbox 3.14, Optimization Toolbox 8.2, Signal Processing Toolbox 8.1, Statistics and Machine Learning Toolbox 11.4, Symbolic Math Toolbox 8.2

# MNIST DATASET
Data is in the **data** directory! When running the script, please correct the directory to yours.

# Results
To reprlicate each result, change direction to the exact folder and run each script.
* Ex: folder/script.m

### 2 class MNIST classification 5 iteration
* DNA_HN(proposed): iteration_5/iter_class2_DNA_HN_1000.m
* Perceptron: iteration_5/iter_class2_pt_1000.m
* Neural Network: iteration_5/iter_class2_NN_1000.m

### 10 class MNIST classification 5 iteration
* DNA_HN(proposed): iteration_5/iter_class10_DNA_HN_1000.m
* Perceptron: iteration_5/iter_class10_pt_1000.m
* Neural Network :iteration_5/iter_class10_NN_1000.m


### 2 class MNIST classification until convergence
* DNA_HN(proposed): iteration_converge/conv_class2_DNA_HN.m
* Perceptron: iteration_converge/conv_class2_pt.m
* Neural Network: iteration_converge/conv_class2_NN.m


### 10 class MNIST classification until convergence
* DNA_HN(proposed): iteration_converge/conv_class10_DNA_HN.m
* Perceptron: iteration_converge/conv_class10_pt.m
* Neural Network: iteration_converge/conv_class10_NN.m


#### You can find all the figures of the results in the figure_5 and figure_converge folders. 
#### Also the scripts will show you the results from each model with different parameter settings.

