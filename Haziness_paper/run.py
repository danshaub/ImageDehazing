# -*- coding: utf-8 -*-
"""
Created on Thu Apr 15 17:02:28 2021

@author: André Vitor
"""

import numpy as np
import cv2 as cv
import glob
from functions import *
import pandas as pd


if __name__ == "__main__":
    # N = int(input("Select number of iterations: "))
    # s = int(input("Select the size of the patches: "))

    N = 10**3
    s = 2
    
    
    
    files =  glob.glob('..\Datasets\Images\D-HAZY-MID\hazy\*')
    # files =  glob.glob('Images\*')
    if len(files) == 0:
        print("""
    The program couldn't identify the folder.
    Please check if the name of the folder is 'Images'.
    And it is not empty.
              """)
              
    files.sort()
    
    values = []
    for file in files:
        file2 = file.split("\\")[-1]
        print(f'Calculating for {file2}')
        file = cv.imread(file,0)
        # cv.imwrite('{file2}_cv_.jpg', file)
        x, y = haziness_mean_std(file, N, s)
        values.append([file2, round(x,4),round(y,4)])
    # print(values)
    
    print('Done')
    DF = pd.DataFrame(values)
    header = ["Name","Value","Std"]
    DF.to_csv("dataDHZ.csv",index=False)



