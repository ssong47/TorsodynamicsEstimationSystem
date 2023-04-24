# Torso-dynamics Estimation System (TES) Validation Study
![image](https://user-images.githubusercontent.com/124326162/231533976-3ac0bd7c-ab6b-4f61-a123-1c5fe60e05c2.png)
This repository contains data processing code from a validation study of the Torso-dynamics Estimation System (TES).
<br> **Corresponding paper**: [Design and Validation of a Torso-Dynamics Estimation System (TES) for Hands-Free Physical Human-Robot Interaction](https://doi.org/10.36227/techrxiv.22336843.v1)

*Abstract* — We  designed  and  validated  two  interfaces  for physical human-robot interaction that utilize torso motions for hands-free navigation control of riding or remote mobile robots. The Torso-dynamics Estimation System (TES), which consisted of   an   instrumented   seat   (Force   Sensing   Seat, FSS)  and  a wearable   sensor   (inertial   measurement   unit,   IMU),   was developed to quantify the translational and rotational motions of the  torso,  respectively.  The  FSS  was  constructed  from  six uniaxial  loadcells  to  output  3D  resultant  forces  and  torques, which were used to compute the translational movement of the 2D center of pressure (COP) under the seated user. Two versions of  the  FSS  (Gen  1.0  and  2.0)  with different  loadcell  layouts, materials,   and   manufacturing   methods   were   developed   to showcase the versatility of the FSS design and construction. Both FSS   versions   utilized   low-cost   components   and   a   simple calibration protocol to correct for dimensional inaccuracies. The IMU, attached on the user’s upper chest, used a proprietary algorithm to compute the 3D torso angles without relying heavily on  magnetometers  to  minimize  errors  from  electromagnetic noises. A validation study was performed on eight test subjects (six  able-bodied  users  and  two  manual  wheelchair  users  with reduced  torso  range  of motion)  to  validate  TES  estimations  by comparing them to data collected on a research-grade force plate and   motion   capture   system.   TES   readings   displayed   high accuracy (average RMSE of 3D forces, 3D torques, 2D COP, and torso  angles  were  well  less  than  maximum  limits  of  5N,  5Nm, 10mm, and 6 ̊, respectively).



## Table of Contents
1. [Introduction](#introduction)
2. [Directory Structure and Required Files](#directory-structure-and-required-files)
3. [Using the Code](#using-the-code)
4. [Code File Descriptions](#code-file-descriptions)
5. [Contact Information](#contact-information)
6. [License](#license)

## Introduction
The code files in this repository are used to process data was collected during a validation study of our Torso-Dynamics Estimation System (TES). The TES consisted of a Force Sensing Seat (FSS) and an inertial measurement unit (IMU) that measured the kinetics and kinematics of the test subject's torso motions. The FSS estimated the 3D forces, 3D moments, and 2D COPs while the IMU estimated the 3D torso angles. To validate the TES, the FSS and IMU estimates were compared to gold standard research equipment (AMTI force plate and Qualisys motion capture system, respectively).

The data from this study can be found in this [IEEE DataPort](https://ieee-dataport.org/documents/validation-study-torso-dynamics-estimation-system-tes-hands-free-physical-human-robot). You can use this data with the code in this repository as an example of how to process the validation study data.

**NOTE:** There were two generations of the FSS, FSS Gen 1.0 and FSS Gen 2.0. This repository contains data processing code from the validation study of each FSS generation. So, some of the code files correspond with only one of the FSS generations. Any code files with "Gen1" or "Gen2" in the name are for processing data from only that FSS generation. All other files are supporting functions that are used to process data from both FSS generations.

### Models of Equipment Used for Data Collection
- **Load cells (used in FSS)**
  - *FSS Gen 1.0:* DYMH-103, Calt, China (x6)
  - *FSS Gen 2.0:* CZL301C, Hualanhai, China (x6)
- **IMU:** VN-100, VectorNav, USA
- **Force plates**
  - *For FSS Gen 1.0 study:* BP600900-1K, AMTI, USA
  - *For FSS Gen 2.0 study:* OR6-7-2000, AMTI, USA
- **Motion capture cameras (x6):** Oqus 500, Qualisys, Sweden

### Software Used for Data Collection
- MATLAB R2022b with signal toolbox
- Qualisys Track Manager
- CoolTerm

### Note on Units
The following units were used for the validation study data:
- **3D Forces:** Newtons (N)
- **3D Moments:** Newton-meters (Nm)
- **2D Center of Pressures (COPs):** millimeters (mm)
- **3D Torso Angles:** degrees

## Directory Structure and Required Files
### Directory structure
Before downloading the data files and data processing code, you need to set up your directory to match the directories used in the code. Following this directory structure will make it easier to update your directories in the code. Specifically, directories will need to be updated in the following code files:
- Gen1_aggregate_data_processing.m
- Gen2_aggregate_data_processing.m
- MAIN_data_process_Gen1study.m
- MAIN_data_process_Gen2study.m

In each of these files, there are also comments explaining the directory structure to use.

### The directory structure is as follows:

**Main folder:** *TES Design Validation Study* <br>

**Subfolders:**
- *TES Data Processing Code*
- *FSS Gen 1.0 Data*
- *FSS Gen 2.0 Data*
- *FSS Gen 1.0 Figures*
- *FSS Gen 2.0 Figures*

### The required files for each folder are as follows:
- *TES Data Processing Code:* MATLAB code files for processing the data (from this repository)
- *FSS Gen 1.0 Data:* Data from FSS Gen 1.0, IMU, AMTI force plate, and Qualisys motion capture
- *FSS Gen 2.0 Data:* Data from FSS Gen 2.0, IMU, AMTI force plate, and Qualisys motion capture
- *FSS Gen 1.0 Figures* and *FSS Gen 2.0 Figures:* Empty folders where generated figures will be saved <br>

### Data files
Due to the size of the data files, they were unable to be uploaded to this repository. Instead, they were uploaded to this [IEEE DataPort](https://ieee-dataport.org/documents/validation-study-torso-dynamics-estimation-system-tes-hands-free-physical-human-robot). In this DataPort, there are two zipped folders named *FSS Gen 1.0 Data* and *FSS Gen 2.0 Data*, which correspond to the folders in the directory structure described above. You will need to unzip the folders and then put them in the directory structure. For more information on the data that was collected, see the README file in the IEEE DataPort.

## Using the Code
Most of the MATLAB code files in this repository are supporting functions used in the main data processing scripts. As a result, you will only need to run the main data processing scripts, which are:
- MAIN_data_process_Gen1study.m
- MAIN_data_process_Gen2study.m
- Gen1_aggregate_data_processing.m
- Gen2_aggregate_data_processing.m
Use the following steps to run the MAIN and aggregate data processing scripts.

### 1) Running the MAIN Script
First, you will need to run the MAIN script (choose Gen 1 or Gen 2 depending on which FSS validation study you want to analyze) to do the initial processing of the data. For the MAIN script, there are several things that need to be changed before you run it:
  - You can change the test subject by changing the cell array *subjects* and change the trial number by changing the variable *i_trial*. 
  - You can also choose a few different options in the code by changing *raw_plot_status*, *plot_status*, and/or *save_status*. *raw_plot_status* lets you choose whether you want the script to generate plots of the raw data. Similarly, *plot_status* lets you choose whether the script will generate plots of the processed data. The value of *save_status* needs to be 1 in order to save the processed data files that are used in the aggregate data processing script. 
  - Lastly, the directories at the beginning of the code will need to be updated according to the directory structure mentioned in the previous section of this document. 

### 2) How to Choose Trials to Run in MAIN Script
The MAIN script needs to be run for each test subject and trial combination individually. Since there were some technical issues with the data collection, the best trials (trials with no technical errors) from each test subject were used in the data processing. The following tables give the best trial from each test subject in each FSS generation validation study, along with some demographic information. You only need to run the MAIN script for these test subject/trial combinations. Note that these best trials are also listed in comments in the MAIN code files.

**For FSS Gen 1.0:**<br>
| Test Subject | Best Trial | Subject Group | Sex | Height (m) | Mass (kg) | Age (yrs) |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| S1 | 4 | ABU | M | 1.80 | 73.70 | 29 | 
| S2 | 4 | ABU | M | 1.71 | 75.20 | 28 | 
| S3 | 4 | ABU | M | 1.70 | 58.00 | 27 | 
| S4 | 1 | ABU | M | 1.81 | 61.20 | 26 |  
| S5 | 1 | ABU | F | 1.60 | 46.50 | 26 | 
| S6 | 4 | ABU | F | 1.57 | 55.10 | 26 | 
| S7 | 3 | mWCU | F | 1.50 | 43.54 | 22 | 
| S8 | 3 | mWCU | M | 1.55 | 68.00 | 19 | 

**For FSS Gen 2.0:**<br>
| Test Subject | Best Trial | Subject Group | Sex | Height (m) | Mass (kg) | Age (yrs) |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| S1 | 1 | ABU | M | 1.80 | 73.70 | 29 | 
| S2 | 3 | ABU | M | 1.71 | 75.20 | 28 | 
| S3 | 3 | ABU | M | 1.70 | 58.00 | 27 | 
| S4 | 2 | ABU | M | 1.81 | 61.20 | 26 | 
| S5 | 1 | ABU | F | 1.60 | 46.50 | 26 | 
| S6 | 2 | ABU | F | 1.57 | 55.10 | 26 | 
| S7 | 1 | mWCU | F | 1.50 | 43.54 | 22 | 
| S8 | 3 | mWCU | M | 1.55 | 68.00 | 19 | 

### 3) Running the Aggregate Data Processing Script
Once the MAIN script has been run for all test subject/trial combinations, you can run the aggregate data processing script (choose Gen 1 or Gen 2 to match MAIN script that was run). The aggregate data processing script will use the files generated by the MAIN script, so make sure that the MAIN script has been run with all test subject/trial combinations before trying to run the aggregate data processing script. In the aggregate data processing script, the subjects are defined in the cell array *subjects* while the trials for each test subject are defined in the array *trials*. You **do not** need to change these since they are already populated with the correct test subject/trial combinations. However, you will still need to update the directories at the beginning of the code according to the directory structure described in the previous section.

## Code File Descriptions
All of the MATLAB code files are commented, but for quick reference, they are summarized below.

1. **[align_Ylabels.m](https://www.mathworks.com/matlabcentral/fileexchange/41701-y-labels-alignment-in-subplots):** Aligns the y-labels in each column of a subplots-based figure such that they all have the same x-coordinate value. The function works both with the default MATLAB subplot command and with the [subplot1](http://www.mathworks.com/matlabcentral/fileexchange/9694) function. 
2. **apply_butterworth_filter.m:** Removes noise from raw data by applying a Butterworth filter given the filter parameters a and b.
3. **compute_angle_two_v.m:** Computes the angle between two vectors u and v in 3D space (x, y, z).
4. **compute_COP.m:** Computes the center of pressure (COP) components from the force data (force data can be from AMTI or FSS).
5. **compute_mocap_angle.m:** Computes angles of the torso (yaw, pitch, roll) from motion capture data given the body frame (torso frame) and the world frame (motion capture system origin frame).
6. **compute_R_from_basis.m:** Computes final rotation matrix given the rotation matrix in body frame (torso frame) and rotation matrix in world frame (motion capture system origin frame).
7. **compute_rmse.m:** Computes RMSE given reference (gold standard: AMTI force plate or Qualisys motion capture) and estimate (FSS or IMU).
8. **compute_seat_angle.m:** Uses motion capture data (origin_pts, seat_pts) to calculate theta_x and theta_y, the FSS seat angles.
    - origin_pts = origin points of motion capture system (markers on Qualisys L-frame)
    - seat_pts = motion capture markers on corners of FSS seat
9. **filter_data.m:** Finds Butterworth filter parameters bHP and aHP given order of filter, cutoff frequency, sampling frequency, and filter type. Then, applies a Butterworth filter to the raw data using parameters bHP and aHP.
10. **Gen1_aggregate_data_processing.m:** Generates a table of averages and standard errors of the RMSE, max, and min for data of two test subject groups.
    - Data: F<sub>x</sub>, F<sub>y</sub>, F<sub>z</sub>, M<sub>x</sub>, M<sub>y</sub>, M<sub>z</sub>, COP<sub>x</sub>, COP<sub>y</sub>, yaw, pitch, roll
    - Test subject groups: able-bodied users (ABUs) and manual wheelchair users (mWCUs) 
    - *NOTE:* This is for FSS Gen 1.0 ONLY! To get table for FSS Gen 2.0, use Gen2_aggregate_data_processing.m
11. **Gen1_get_offsets.m:** Since data collection was not synchronized, time offsets were found. The found offsets are used to align all data in the time axis.
    - *NOTE:* this function applies offsets for the Gen 1.0 FSS study. Use Gen2_get_offsets.m if analyzing data from the Gen 2.0 FSS study
12. **Gen2_aggregate_data_processing.m:** Generates a table of averages and standard errors of the RMSE, max, and min for data of two test subject groups.
    - Data: F<sub>x</sub>, F<sub>y</sub>, F<sub>z</sub>, M<sub>x</sub>, M<sub>y</sub>, M<sub>z</sub>, COP<sub>x</sub>, COP<sub>y</sub>, yaw, pitch, roll
    - Test subject groups: able-bodied users (ABUs) and manual wheelchair users (mWCUs) 
    - *NOTE:* This is for FSS Gen 2.0 ONLY! To get table for FSS Gen 1.0, use Gen1_aggregate_data_processing.m
13. **Gen2_get_offsets.m:** Since data collection was not synchronized, time offsets were found. The found offsets are used to align all data in the time axis.
    - *NOTE:* this function applies offsets for the Gen 2.0 FSS study. Use Gen1_get_offsets.m if analyzing data from the Gen 1.0 FSS study
14. **get_mocap_frames.m:** Calculates the frames of the torso, FSS seat, and motion capture system origin.
15. **MAIN_data_process_Gen1study.m:** Processes the FSS, QTM (Qualisys motion capture), VN IMU, and AMTI force plate data for the Gen 1.0 FSS design validation study. FSS load cells are used to calculate 3 forces, 3 moments, and 2 COP coordinates. FSS data are compared to the gold standard, AMTI force plate. VN IMU signals are used to calculate torso angles (yaw, pitch, roll). IMU data are compared to the gold standard, Qualisys motion capture.
    - *NOTE:* This is for FSS Gen 1.0 ONLY! To get master data and plots for FSS Gen 2.0, use MAIN_data_process_Gen2study.m
16. **MAIN_data_process_Gen2study.m:** Processes the FSS, QTM (Qualisys motion capture), VN IMU, and AMTI force plate data for the Gen 2.0 FSS design validation study. FSS load cells are used to calculate 3 forces, 3 moments, and 2 COP coordinates. FSS data are compared to the gold standard, AMTI force plate. VN IMU signals are used to calculate torso angles (yaw, pitch, roll). IMU data are compared to the gold standard, Qualisys motion capture.
    - *NOTE:* This is for FSS Gen 2.0 ONLY! To get master data and plots for FSS Gen 1.0, use MAIN_data_process_Gen1study.m
17. **process_imu_vn_data.m:** Computes torso angles (yaw, pitch, roll) from VN IMU data.
18. **process_mocap_data.m:** Uses motion capture data to calculate the motion capture torso angles, FSS seat x angle, and FSS seat y angle.

## Contact Information
For any questions regarding the study or the data processing code, please contact:
- Seung Yun (Leo) Song: ssong47@illinois.edu
- Nadja Marin: nadjam2@illinois.edu
- Dr. Elizabeth Hsiao-Wecksler: ethw@illinois.edu

## License
MIT License

Copyright (c) 2023 ssong47

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


