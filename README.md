# flanker_oscillation_script
Scripts for conducting various analysis after fullhead oscillation calculation, using the lib_basic library   
The input files have signal for each frequency, time point and channel for each condition. One file per subject.
<table>

<tr>
<th>File</th>
<th>Description</th>
<th>Image Example</th>
</tr>
  
<tr>
<td>run_flanker_export_components.m</td>
<td>1. Topomap for each condition and selected time intervals: plot signal across time on the full-head map for each condition and difference of pairs of conditions, 
for each frequency.<br > 2. Export signal of a particular channel cluster, frequency, and time.</td>
<td>img1.png</td>
</tr>

<tr>
<td>run_flanker_fullhead_correlation</td>
<td>Run full-head correlation with behavioral measures and plot the topomaps for the correlation results, for each condition, frequency, and selected time interval. </td>
<td>img2.png</td>
</tr>

<tr>
<td>run_flanker_plot_oscillation</td>
<td>Time-frequency plot for each condition: For a given channel location, make the time-frequency plot for each condiiton.</td>
<td>img3.png</td>
</tr>
</table>
* img1.png  
<img src = "https://github.com/sindhri/flanker_oscillation_script/blob/main/git_img/img1.png" width = "900">
* img2.png  
<img src = "https://github.com/sindhri/flanker_oscillation_script/blob/main/git_img/img2.png" width = "900">
* img3.png  
<img src = "https://github.com/sindhri/flanker_oscillation_script/blob/main/git_img/img3.png" width = "900">
