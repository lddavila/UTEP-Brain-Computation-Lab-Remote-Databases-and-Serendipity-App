sigmoidShift = log(abs(newTable.B));
sigmoidSteepness = log(abs(newTable.C));
labels = newTable.D;
shiftVsSteepness = [sigmoidShift,sigmoidSteepness];
labels = [labels,labels];
createThePlot(shiftVsSteepness,labels,4,"Shift","Steepness", "Travel Pixel")