# Tonotopy is not preserved in a descending stage of auditory cortex

## Dataset Overview:

Previous studies based on layer specificity suggest that ascending signals from the thalamus to the sensory neocortex preserve spatially organized information, but it remains unknown whether sensory information descending from sensory neocortex to the thalamus also maintains such spatial organization pattern. By focusing on projection specificity, we mapped the tone response properties of two groups of cortical neurons in the primary auditory cortex (A1), based on the relationship between their specific connections to other regions and their function in ascending (thalamocortical recipient, TR neurons) or descending (corticothalamic, CT neurons) auditory information. A clear tonotopic gradient was observed among TR neurons, but not CT neurons. Additionally, CT neurons exhibited markedly higher heterogeneity in their frequency tuning and had broader bandwidth than TR neurons. These results reveal that the information flow descending from A1 to the thalamus via CT neurons is not arrange tonotopically, suggesting that the descending information flow possibly contributes to higher-order feedback processing of diverse auditory inputs.

## Description of the data

This repository contains the processed data used in Gu and Liang (2025, eLife). Data were analyzed using custom-written software in LabVIEW 2012 (National Instruments), Igor Pro 5.0 (Wavemetrics), Image 1.51 (NIH), Prism 8.4 (GraphPad) and MATLAB 2014a (MathWorks). To compare data between groups, we used the nonparametric Wilcoxon rank sum test (unpaired), and Wilcoxon signed-rank test (paired) to determine statistical significance (P < 0.05) between them. In the text, summarized data are presented as the median\25th–75th percentiles. In the figures, the data presented in the box-and-whisker plot indicate the median (center line), 25th and 75th percentiles (Q1 and Q3), i.e., IQR (box), Q1-1.5 × IQR and Q3 + 1.5 × IQR (whiskers), and all other data with error bars are presented as the mean ± s.e.m.

## Files and variables

### File: data_Gu_and_Liang.xlsx

This file contains all the raw processed data used to generate the figures in Gu and Liang (2025, eLife). The file includes sheets corresponding to specific figure panels and supplementary figures. The sheets are organized as follows:

Note: Two sheets (Figure 2J and Figure 2L) are currently being prepared and will be added to the file once the corresponding data are exported from the analysis.

---

#### Sheet: "Figure 2G"

**Description:** This sheet contains the median best frequency (BF) values for thalamocortical recipient (TR) neurons, organized by imaging distance along the tonotopic axis. Each row represents one focal plane (field of view) from two-photon calcium imaging. The data are binned by distance ranges from the pial surface (0–200 μm) to the L6/white matter border (800–1000 μm), corresponding to the low-frequency to high-frequency representation along the tonotopic gradient in A1. This sheet corresponds to Figure 2G in the article.

**N values:** N = 23 focal planes, from 5 mice.

**Variables**

- Distance range (μm): Spatial bins along the tonotopic axis, ranging from 0–200 μm (near pial surface, low-frequency representation) to 800–1000 μm (near L6/white matter border, high-frequency representation), in 200 μm increments
- Median BF (kHz): Median best frequency value (in kHz) of TR neurons recorded within each distance range bin; each row represents one focal plane

---

#### Sheet: "Figure 2H"

**Description:** This sheet contains the median best frequency (BF) values for corticothalamic (CT) neurons, organized by imaging distance along the tonotopic axis, analogous to Panel G but for CT neurons. Each row represents one focal plane. This sheet corresponds to Figure 2H in the article.

**N values:** N = 40 focal planes, from 10 mice.

**Variables**

- Distance range (μm): Spatial bins along the tonotopic axis, ranging from 0–200 μm to 800–1000 μm, in 200 μm increments
- Median BF (kHz): Median best frequency value (in kHz) of CT neurons recorded within each distance range bin; each row represents one focal plane

---

#### Sheet: "Figure 2J"

**Description:** This sheet contains the best frequency (BF) values for individual thalamocortical recipient (TR) neurons plotted against their relative spatial position along the caudal-to-rostral axis of the primary auditory cortex (A1). Each row represents one individually recorded TR neuron, with its best frequency (the sound frequency to which the neuron responds most strongly) and its spatial coordinate along the caudal-to-rostral axis (measured in micrometers from the caudal boundary of A1). This sheet corresponds to Figure 2J in the article, which shows a scatter plot demonstrating a significant positive correlation between BF and caudal-to-rostral position (R = 0.518, P < 0.001), indicating that TR neurons preserve tonotopic organization along this axis. N = 481 neurons from 5 mice.

**NOTE: This sheet is currently missing from the data_Gu_and_Liang.xlsx file and needs to be exported from the analysis data.**

**Variables**

- Neuron identifier: Unique ID for each recorded TR neuron (e.g., "TR_neuron_001", "TR_neuron_002", etc.)
- Mouse identifier: Unique ID for the experimental mouse from which the neuron was recorded
- Best Frequency (kHz): The sound frequency (in kHz) to which the neuron responds most strongly; measured from the frequency response area (FRA) obtained via two-photon calcium imaging
- Distance from caudal to rostral (μm): Spatial position of the neuron along the caudal-to-rostral axis of A1, measured in micrometers from the caudal boundary; ranges approximately from 0 to 1000 μm across the imaged area
- Field of view identifier: Identifier for the imaging field of view (FOV) from which the neuron was recorded

---

#### Sheet: "Figure 2L"

**Description:** This sheet contains the best frequency (BF) values for individual corticothalamic (CT) neurons plotted against their relative spatial position along the caudal-to-rostral axis of A1, analogous to Panel J but for CT neurons. Each row represents one individually recorded CT neuron (labeled via retrograde tracing with CVS-GCaMP6s from the MGB, restricted to A1 layer 6), with its best frequency and spatial coordinate. This sheet corresponds to Figure 2L in the article, which shows that unlike TR neurons, CT neurons do not exhibit a significant tonotopic gradient along the caudal-to-rostral axis (R = 0.079, P = 0.084), suggesting that the descending information flow from A1 to the thalamus does not preserve tonotopic organization. N = 491 neurons from 10 mice.

**NOTE: This sheet is currently missing from the data_Gu_and_Liang.xlsx file and needs to be exported from the analysis data.**

**Variables**

- Neuron identifier: Unique ID for each recorded CT neuron (e.g., "CT_neuron_001", "CT_neuron_002", etc.)
- Mouse identifier: Unique ID for the experimental mouse from which the neuron was recorded
- Best Frequency (kHz): The sound frequency (in kHz) to which the neuron responds most strongly; measured from the frequency response area (FRA) obtained via two-photon calcium imaging
- Distance from caudal to rostral (μm): Spatial position of the neuron along the caudal-to-rostral axis of A1, measured in micrometers from the caudal boundary; ranges approximately from 0 to 1000 μm across the imaged area
- Field of view identifier: Identifier for the imaging field of view (FOV) from which the neuron was recorded

---

#### Sheet: "Figure 2M"

**Description:** This sheet contains the best frequency distribution histograms from all recorded neurons in the dataset, including both TR neurons and L6 CT neurons. The data are presented as frequency bins with corresponding neuron counts and fractions. This sheet corresponds to Figure 2M in the article.

**N values:** TR: N = 481 neurons; CT: N = 491 neurons.

**Variables**

- Neuron type: Classification of neurons as either "TR neurons" (thalamocortical recipient) or "L6 CT neurons" (corticothalamic neurons projecting to the thalamus, originating from layer 6)
- Best Frequency (kHz): The sound frequency (in kHz) to which a neuron responds most strongly; values correspond to the tested frequency stimuli range
- Number of neurons: Count of neurons exhibiting a given best frequency
- Fraction of neurons: Proportion of neurons (ranging from 0 to 1) with a given best frequency relative to the total number of neurons in that group

---

#### Sheet: "Figure 2N"

**Description:** This sheet contains the best frequency distribution histograms for neurons identified in the low-frequency (LF) area by wide-field imaging, including both TR neurons and L6 CT neurons. This sheet corresponds to Figure 2N in the article.

**N values:** TR: N = 116 neurons; CT: N = 98 neurons.

**Variables**

- Neuron type: Classification as "TR neurons (LF area)" or "L6 CT neurons (LF area)", indicating neurons located in the wide-field imaging-defined low-frequency region of A1
- Best Frequency (kHz): The sound frequency (in kHz) to which a neuron responds most strongly
- Number of neurons: Count of neurons exhibiting a given best frequency
- Fraction of neurons: Proportion of neurons (ranging from 0 to 1) with a given best frequency relative to the total in that subgroup

---

#### Sheet: "Figure 2O"

**Description:** This sheet contains the best frequency distribution histograms for neurons identified in the high-frequency (HF) area by wide-field imaging, including both TR neurons and L6 CT neurons. This sheet corresponds to Figure 2O in the article.

**N values:** TR: N = 91 neurons; CT: N = 90 neurons.

**Variables**

- Neuron type: Classification as "TR neurons (HF area)" or "L6 CT neurons (HF area)", indicating neurons located in the wide-field imaging-defined high-frequency region of A1
- Best Frequency (kHz): The sound frequency (in kHz) to which a neuron responds most strongly
- Number of neurons: Count of neurons exhibiting a given best frequency
- Fraction of neurons: Proportion of neurons (ranging from 0 to 1) with a given best frequency relative to the total in that subgroup

---

#### Sheet: "Figure 3C"

**Description:** This sheet contains the field-level (200 μm) interquartile range (IQR) of best frequencies, comparing TR neurons versus CT neurons. Each row represents one focal plane. This sheet corresponds to Figure 3C in the article.

**N values:** N = 23 focal planes from 5 mice for TR; N = 40 focal planes from 10 mice for CT.

**Variables**

- Neuron type: Classification as "TR" (thalamocortical recipient neurons) or "CT" (corticothalamic neurons)
- Field IQR (Octave): Interquartile range of best frequencies across neurons within a 200 μm field of view, measured in octaves; a larger IQR indicates greater heterogeneity in frequency tuning at the field scale; each row represents one focal plane

---

#### Sheet: "Figure 3D"

**Description:** This sheet contains the field-level (200 μm) IQR of best frequencies for TR and CT neurons separated by wide-field imaging-defined LF and HF areas. Each row represents one focal plane. This sheet corresponds to Figure 3D in the article.

**N values:** LF area: N = 4 focal planes from 3 mice for TR; N = 9 focal planes from 5 mice for CT. HF area: N = 5 focal planes from 5 mice for TR; N = 11 focal planes from 10 mice for CT.

**Variables**

- Neuron type and area: Four groups — "TR neurons (LF area)", "TR neurons (HF area)", "L6 CT neurons (LF area)", "L6 CT neurons (HF area)" — indicating neuron type combined with the wide-field imaging-defined frequency area (low-frequency or high-frequency) of A1
- Field IQR (Octave): Interquartile range of best frequencies within a 200 μm field of view, in octaves; each row represents one focal plane

---

#### Sheet: "Figure 3G"

**Description:** This sheet contains the local-level (25 μm radius) IQR of best frequencies for TR and CT neurons separated by LF and HF areas. Each row represents one local analysis region. This sheet corresponds to Figure 3G in the article.

**N values:** LF area: N = 34 local planes for TR; N = 20 local planes for CT. HF area: N = 23 local planes for TR; N = 16 local planes for CT.

**Variables**

- Neuron type and area: Four groups — "TR neurons (LF area)", "TR neurons (HF area)", "L6 CT neurons (LF area)", "L6 CT neurons (HF area)"
- Local IQR (Octave): Interquartile range of best frequencies within a 25 μm radius local region, in octaves; measures frequency tuning diversity at a finer spatial scale; each row represents one local plane

---

#### Sheet: "Figure 3H"

**Description:** This sheet contains the local (25 μm radius) IQR of best frequencies for TR neurons, plotted against distance along the tonotopic axis. Each row represents one local analysis region binned by distance. This sheet corresponds to Figure 3H in the article.

**N values:** Data derived from TR neurons (see Figure 3G for sample sizes).

**Variables**

- Distance range (μm): Spatial bins along the tonotopic axis, ranging from 0–200 μm to 800–1000 μm, in 200 μm increments
- Local IQR (Octave): Interquartile range of best frequencies within a 25 μm radius local region, in octaves; each row represents one local plane at the corresponding distance

---

#### Sheet: "Figure 3I"

**Description:** This sheet contains the minimum frequency difference (Δ Frequency) between nearest-neighboring neurons for TR and CT neurons in LF and HF areas. Each row represents one pair of adjacent neurons. This sheet corresponds to Figure 3I in the article.

**N values:** LF area: N = 116 paired neurons for TR; N = 87 paired neurons for CT. HF area: N = 91 paired neurons for TR; N = 78 paired neurons for CT.

**Variables**

- Neuron type and area: Four groups — "TR neurons (LF area)", "TR neurons (HF area)", "L6 CT neurons (LF area)", "L6 CT neurons (HF area)"
- Δ Frequency (Octave): Minimum frequency difference between nearest-neighboring neurons, calculated as the smallest best frequency difference between any pair of adjacent neurons; measured in octaves; reflects local frequency variability; each row represents one neuron pair

---

#### Sheet: "Figure 3J"

**Description:** This sheet contains the minimum frequency difference (Δ Frequency) between nearest-neighboring TR neurons, plotted against distance along the tonotopic axis. Each row represents one neuron pair binned by distance. This sheet corresponds to Figure 3J in the article.

**N values:** Data derived from TR neurons (see Figure 3I for sample sizes).

**Variables**

- Distance range (μm): Spatial bins along the tonotopic axis, ranging from 0–200 μm to 800–1000 μm, in 200 μm increments
- Δ Frequency (Octave): Minimum frequency difference between nearest-neighboring neurons, in octaves; each row represents one neuron pair at the corresponding distance

---

#### Sheet: "Figure 4C"

**Description:** This sheet contains the fraction of neurons with different frequency response area (FRA) shapes (V-shaped, I-shaped, O-shaped) in TR versus CT neurons. Each row represents one focal plane. This sheet corresponds to Figure 4C in the article.

**Variables**

- FRA shape type: Classification of the frequency response area shape — "V shape" (v-shaped, narrowband tuning with a clear frequency peak), "I shape" (inhibitory, broadly tuned with suppression at off-frequency tones), or "O shape" (onset, transient response that fires only at stimulus onset)
- Neuron type: "TR" (thalamocortical recipient) or "CT" (corticothalamic)
- Fraction of neurons: Proportion (ranging from 0 to 1) of neurons in a given focal plane exhibiting a particular FRA shape in each neuron type group

---

#### Sheet: "Figure 4D"

**Description:** This sheet contains the half-peak bandwidth measurements for V-shaped TR and CT neurons. Each row represents one individual neuron. This sheet corresponds to Figure 4D in the article.

**N values:** N = 190 neurons from 5 mice for TR; N = 249 neurons from 10 mice for CT.

**Variables**

- Neuron type: "TR neurons" (thalamocortical recipient) or "CT neurons" (corticothalamic); data include only V-shaped neurons
- Half-peak bandwidth (Octave): Bandwidth of the frequency response area measured at half of the maximum response amplitude, expressed in octaves; narrower bandwidth indicates sharper frequency selectivity; each row represents one neuron

---

#### Sheet: "Figure 4E"

**Description:** This sheet contains the quality factor (Q value) measurements for V-shaped TR and CT neurons. Each row represents one individual neuron. This sheet corresponds to Figure 4E in the article.

**N values:** N = 190 neurons from 5 mice for TR; N = 249 neurons from 10 mice for CT.

**Variables**

- Neuron type: "TR neurons" or "CT neurons"; data include only V-shaped neurons
- Q value: Quality factor calculated as BF / half-bandwidth, where a higher Q value indicates sharper/more selective frequency tuning; each row represents one neuron

---

#### Sheet: "Figure 4F"

**Description:** This sheet contains the Q value measurements for V-shaped TR and CT neurons separated by LF and HF areas. Each row represents one individual neuron. This sheet corresponds to Figure 4F in the article.

**N values:** LF area: N = 56 neurons for TR; N = 49 neurons for CT. HF area: N = 37 neurons for TR; N = 41 neurons for CT.

**Variables**

- Neuron type and area: Four groups — "TR neurons (LF area)", "TR neurons (HF area)", "L6 CT neurons (LF area)", "L6 CT neurons (HF area)" — data include only V-shaped neurons
- Q value: Quality factor calculated as BF / half-bandwidth; each row represents one neuron

---

#### Sheet: "Figure 4G"

**Description:** This sheet contains the maximum bandwidth (BWmax) measurements for V-shaped, I-shaped, and O-shaped neurons in TR and CT. Each row represents one individual neuron. This sheet corresponds to Figure 4G in the article.

**N values:** V shape: N = 190 neurons for TR, N = 249 neurons for CT; I shape: N = 174 neurons for TR, N = 112 neurons for CT; O shape: N = 117 neurons for TR, N = 130 neurons for CT.

**Variables**

- FRA shape type: "V shape", "I shape", or "O shape" — classification of the frequency response area shape
- Neuron type: "TR neurons" or "CT neurons"
- BWmax (Octave): Maximum bandwidth across all tested sound intensities for a given neuron, representing the broadest frequency tuning observed; measured in octaves; each row represents one neuron

---

#### Sheet: "Figure 4I"

**Description:** This sheet contains the maximum bandwidth (BWmax) measurements for all TR and CT neurons. Each row represents one individual neuron. This sheet corresponds to Figure 4I in the article.

**N values:** N = 481 neurons from 5 mice for TR; N = 491 neurons from 10 mice for CT.

**Variables**

- Neuron type: "TR neurons" or "CT neurons"
- BWmax (Octave): Maximum bandwidth across all tested sound intensities, in octaves; each row represents one neuron

---

#### Sheet: "Figure 4J"

**Description:** This sheet contains the maximum bandwidth (BWmax) measurements for TR and CT neurons separated by LF and HF areas. Each row represents one individual neuron. This sheet corresponds to Figure 4J in the article.

**N values:** LF area: N = 116 neurons for TR; N = 98 neurons for CT. HF area: N = 91 neurons for TR; N = 90 neurons for CT.

**Variables**

- Neuron type and area: Four groups — "TR neurons (LF area)", "TR neurons (HF area)", "L6 CT neurons (LF area)", "L6 CT neurons (HF area)"
- BWmax (Octave): Maximum bandwidth across all tested sound intensities, in octaves; each row represents one neuron

---

#### Sheet: "Figure 4L"

**Description:** This sheet contains the fraction of non-monotonic neurons in TR versus CT neurons. Each row represents one focal plane. This sheet corresponds to Figure 4L in the article.

**N values:** N = 23 focal planes from 5 mice for TR; N = 40 focal planes from 10 mice for CT.

**Variables**

- Neuron type: "TR neurons" or "CT neurons"
- Fraction of non-mon neurons: Proportion (ranging from 0 to 1) of neurons in a given focal plane that exhibit non-monotonic intensity response properties (i.e., response peaks at a preferred intensity and then declines at higher intensities); each row represents one focal plane

---

#### Sheet: "Figure 4M"

**Description:** This sheet contains the fraction of non-monotonic neurons in TR and CT neurons separated by LF and HF areas. Each row represents one focal plane. This sheet corresponds to Figure 4M in the article.

**N values:** LF area: N = 4 focal planes from 3 mice for TR; N = 9 focal planes from 5 mice for CT. HF area: N = 5 focal planes from 5 mice for TR; N = 11 focal planes from 10 mice for CT.

**Variables**

- Neuron type and area: Four groups — "TR neurons (LF area)", "TR neurons (HF area)", "L6 CT neurons (LF area)", "L6 CT neurons (HF area)"
- Fraction of non-mon neurons: Proportion (ranging from 0 to 1) of non-monotonic neurons in a given focal plane; each row represents one focal plane

---

#### Sheet: "Figure 4N"

**Description:** This sheet contains the monotonicity index (MI) values for both non-monotonic and monotonic neurons in TR and CT. Each row represents one individual neuron. This sheet corresponds to Figure 4N in the article.

**N values:** Non-mon: N = 107 neurons for TR, N = 128 neurons for CT; Mon: N = 374 neurons for TR, N = 363 neurons for CT.

**Variables**

- Response type: "non-mon" (non-monotonic neurons, response peaks at an optimal intensity then decreases) or "mon" (monotonic neurons, response amplitude increases or decreases monotonically with sound intensity)
- Neuron type: "TR neurons" or "CT neurons"
- MI (Monotonicity Index): Quantitative measure of the monotonicity of a neuron's intensity response function, where MI = 1 indicates no intensity tuning (response increases monotonically with intensity) and MI near 0 indicates strong intensity tuning (response peaks at an optimal intensity then decreases); each row represents one neuron

---

#### Sheet: "Figure 4O"

**Description:** This sheet contains the best frequency (BF) values for monotonic and non-monotonic neurons in TR and CT. Each row represents one individual neuron. This sheet corresponds to Figure 4O in the article.

**N values:** TR: N = 107 neurons for non-mon, N = 374 neurons for mon; CT: N = 128 neurons for non-mon, N = 363 neurons for mon.

**Variables**

- Response type: "non-mon" (non-monotonic) or "mon" (monotonic)
- Neuron type: "TR neurons" or "CT neurons"
- Best Frequency (kHz): The sound frequency (in kHz) to which a neuron responds most strongly; each row represents one neuron

---

#### Sheet: "Figure 4P"

**Description:** This sheet contains the maximum bandwidth (BWmax) values for monotonic and non-monotonic neurons in TR and CT. Each row represents one individual neuron. This sheet corresponds to Figure 4P in the article.

**N values:** TR: N = 107 neurons for non-mon, N = 374 neurons for mon; CT: N = 128 neurons for non-mon, N = 363 neurons for mon.

**Variables**

- Response type: "non-mon" (non-monotonic) or "mon" (monotonic)
- Neuron type: "TR neurons" or "CT neurons"
- BWmax (Octave): Maximum bandwidth across all tested sound intensities, in octaves; each row represents one neuron

---

#### Sheet: "S Figure 1"

**Description:** This sheet contains data validating the expression of the genetically encoded calcium indicator GCaMP6s in the auditory cortex. It reports the fraction of active neurons and the fraction of reliable neurons at two time points (day 7 and day 13 post-infection) across multiple mice and focal planes. This sheet corresponds to Supplementary Figure 1 in the article.

**Variables**

- Mouse identifier: Unique ID for each experimental mouse (e.g., "Mouse 1", "Mouse 2", etc.)
- Focal plane identifier: Unique ID for each two-photon imaging focal plane within a mouse (e.g., "focal plane (a)", "focal plane (b)", etc.)
- Fraction of active neurons (day 7): Proportion (ranging from 0 to 1) of GCaMP6s-expressing neurons that showed calcium responses at day 7 post-infection
- Fraction of active neurons (day 13): Proportion of GCaMP6s-expressing neurons that showed calcium responses at day 13 post-infection
- Fraction of reliable neurons (day 7): Proportion (ranging from 0 to 1) of GCaMP6s-expressing neurons that showed reliable (repeatable across trials) calcium responses at day 7
- Fraction of reliable neurons (day 13): Proportion of GCaMP6s-expressing neurons that showed reliable calcium responses at day 13

---

#### Sheet: "S Figure 2"

**Description:** This sheet contains summary statistics of neuron classification counts and fractions for TR and CT neurons, categorizing them as irregular, silent, or tuned. This sheet corresponds to Supplementary Figure 2 in the article.

**Variables**

- Neuron type: "TR neurons" or "CT neurons"
- irregular neurons: Count of neurons classified as irregular (not fitting standard tuning categories)
- silent neurons: Count of neurons that did not respond to any stimulus tested
- tuned neurons: Count of neurons classified as tone-tuned (showing selective responses to specific frequencies)
- total: Total number of neurons recorded in each group
- Fraction of irregular neurons: Proportion of irregular neurons relative to the total
- Fraction of silent neurons: Proportion of silent neurons relative to the total
- Fraction of tuned neurons: Proportion of tuned neurons relative to the total

---

### Code/software

The code to run this analysis is available on GitHub: https://github.com/xieyangshuying/Tonotopy
