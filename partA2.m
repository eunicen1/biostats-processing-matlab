projectdir = 'COVID-19-Wearables';
dinfo = dir(fullfile(projectdir));
dinfo([dinfo.isdir]) = [];   
nfiles = length(dinfo);

% Make Table
sz = [nfiles 12];
out = fopen('statistics.txt', 'w');
names = ["Patient", "Vital", "Mean", "Median", "Mode", "Geometric Mean", ...
    "Range", "Standard Deviation", "Coefficient of Variance", "Q3", "Q1", "IQR"];
fprintf(out, '%s %s %s %s %s %s %s %s %s %s %s %s\n', names);
fclose(out);

for j = 1 : nfiles
  out = fopen('statistics.txt', 'a');
  filename = fullfile(projectdir, dinfo(j).name);
  f1 = readmatrix(filename);

  % Obtain Patient Name and Vital Type (Steps, HR, etc.)
  category = split(filename, "_");
  temp = split(category{1,1}, "\");
  category{1,1} = temp{2,1};
  temp = split(category{2,1}, ".");
  category{2,1} = temp{1,1};
  
  % Obtain Measures of Central Tendency
  men = mean(f1(:,3));
  med = quantile(f1(:,3), 0.5);
  mod = mode(f1(:,3));
  gem = geomean(f1(:,3)); 
  
  % Obtain Measures of Dispersion
  rge = max(f1(:,3))-min(f1(:,3));
  sdv = std(f1(:,3));
  cov = 100 * sdv/men;
  Q3 = quantile(f1(:,3), 0.75);
  Q1 = quantile(f1(:,3), 0.25);
  IQR = Q3-Q1;  
  toAppend = [string(category{1,1}), string(category{2,1}), double(men), double(med),...
              double(mod), double(gem), double(rge), double(sdv), double(cov),... 
              double(Q3), double(Q1), double(IQR)];
  fprintf(out, '%s %s %f %f %f %f %f %f %f %f %f %f\n', toAppend);
  fclose(out);
end
