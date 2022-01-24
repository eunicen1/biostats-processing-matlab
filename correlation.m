% correlation computation
id = "A36HR6Y"; % repeat for other five selected patients
fX = readtable("COVID-19-Wearables\"+id+"_steps.csv");
fY = readtable("COVID-19-Wearables\"+id+"_hr.csv");
fZ = readtable("COVID-19-Wearables\"+id+"_sleep.csv");

%correlation between steps and heart rate
X_XY = ismember(fX.datetime, fY.datetime);
Y_XY = ismember(fY.datetime, fX.datetime);
rXY = corrcoef(fX(X_XY,1:3).steps, fY(Y_XY,1:3).heartrate);

%correlation between steps and sleep
X_XZ = ismember(fX.datetime, fZ.datetime);
Z_XZ = ismember(fZ.datetime, fX.datetime);
rXZ = corrcoef(fX(X_XZ,1:3).steps, fZ(Z_XZ,1:3).stage_duration);

%correlation between heart rate and sleep
Y_YZ = ismember(fY.datetime, fZ.datetime);
Z_YZ = ismember(fZ.datetime, fY.datetime);
rYZ = corrcoef(fY(Y_YZ,1:3).heartrate, fZ(Z_YZ,1:3).stage_duration);
