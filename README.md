# Application-to-image-compression
Application allows user to compress and decompress images. (GUI in Polish)

                  !!!  CAUTION  !!!
THE APPLICATION CONVERTS THE RGB IMAGE TO GRAYSCALE IMAGE.

The application allows using discrete wavelet transform (DWT) or discrete cosine transform (DCT).
The application contains a graphical user interface (GUI) divided into two sections. First one is responsible for image compression, and the second one for its decompression.
In the first section, the user can choose compression parameters such as:
- which transform will be used in compression (DWT or DCT);
- size of blocks into which the image will be divided when compressed using DCT;
- one of the two individual compression methods;
- output data format (MATLAB int8 or int16);
- compression ratio;
- decomposition level when compressed using DWT;
- wavelet used for DWT compression.

Compressed image is saved as ".mat" file. To it's decompression, second section must be used. 
The second section is responsible for decompression and enables comparison with the original image. 
After loading the original image and comparing, the following parameters are displayed:
- mean square error;
- entropy;
- peak signal-to-noise ratio.

User can view the decompressed image and the original image for visual comparison.
