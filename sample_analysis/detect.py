# Autor: Horberlan Brito

import numpy as np  
import cv2
import math
import matplotlib.pyplot as plt
from PIL import Image


path = '/home/root/stack1/sample_analysis/e1in.jpg'
img = cv2.imread(path)
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
plt.imshow(gray, cmap='gray'),plt.title('ORIGINAL')


blur = cv2.GaussianBlur(gray, (11,11),0)
plt.imshow(blur, cmap='gray')


canny = cv2.Canny(blur, 1,100, 1)
plt.imshow(canny, cmap='gray')


dilated = cv2.dilate(canny, (1,1), iterations = 2) #intencidade da
plt.imshow(dilated, cmap='gray')


(cnt, heirarchy) = cv2.findContours(dilated.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
contorno = cv2.cvtColor(img, cv2.COLOR_BGR2RGB) #"COLOR_BGR2RGB" Devolve a cor normal a imagem. 

## If contorno is numpy, use this line to save image
cv2.drawContours(contorno,cnt, -1, (1,300,1),2) #Cor do contorno

## take numpy array and save as jpeg
plt.imshow(contorno),plt.title('Realizando a Contagem de Células')



## save an image somewhere onto ur harddrive
print(f'Living cells present in the analysis≅: {len(cnt)}')
