// Macro to measure Area, Intensity, Perimeter, and Shape of directory of images

run("Clear Results"); // clear the results table of any previous measurements

// The next line prevents ImageJ from showing the processing steps during 
// processing of a large number of images, speeding up the macro
setBatchMode(true); 

// Show the user a dialog to select a directory of images
inputDirectory = getDirectory("Choose a Directory of Images");

// Get the list of files from that directory
// NOTE: if there are non-image files in this directory, it may cause the macro to crash
fileList = getFileList(inputDirectory);

for (i = 0; i < fileList.length; i++)
{
    processImage(fileList[i]);
}

setBatchMode(false); // Now disable BatchMode since we are finished
updateResults();  // Update the results table so it shows the filenames

// Show a dialog to allow user to save the results file
outputFile = File.openDialog("Save results file");
// Save the results data
saveAs("results",outputFile);

function processImage(imageFile)
{
    // Store the number of results before executing the commands,
    // so we can add the filename just to the new results
    prevNumResults = nResults;  
    
    open(imageFile);
    // Get the filename from the title of the image that's open for adding to the results table
    // We do this instead of using the imageFile parameter so that the
    // directory path is not included on the table
    filename = getTitle();
    
getHistogram(values, counts, 256);
//setResult("Value", i, values[i]);
imageNum = i+1;
Table.setColumn("Count for image "+imageNum, counts);
    


    // Now loop through each of the new results, and add the filename to the "Filename" column
    for (row = prevNumResults; row < nResults; row++)
    {
        setResult("Filename", row, filename);
    }

    close("*");  // Closes all images
}