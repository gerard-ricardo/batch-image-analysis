# batch-image-analysis
Run a basic batch classification using ImageJ (skeleton protocol)

Crop and downsize

1.	Convert all images to Photoshop file using PS batch
2.	Use crop tool to manually crop all images
3.	Use quick select tool to highlight specific area
a.	use Shift+Cnt + I to invert selection
b.	Backspace > Enter to remove selection
c.	Ctrl+S >W to save and close
d.	Batch convert all images to jpeg using File>Scripts>Image Processor in Photoshop


Creating the model on the HPC

1.	Use FileZilla to move images into HPC space
2.	Create a ‘Training’ folder containing at least 8 images across the spectrum of responses
3.	In ImageJ, create images to stack and create Weka model. Note order of classes. Save classifier.
run("Images to Stack", "method=[Copy (center)] name=Stack title=[] use");
run("Trainable Weka Segmentation");
4.	Create a folder called ‘Labels’. Restart ImageJ, load the Batch Class macro in the language Beanshell, run, and set the directories as prompted with the Output directory 'Labels' folder . The classification will run in the background.
5.	Once completed, restart ImageJ and load the Batch Histogram macro in the language IJ1 macro and run. Save file as .csv
6.	Use Fillezilla to download the csv onto your computer. 












