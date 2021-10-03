### 2.3.1 Absorption

Only intravenous data was available for model building.

### 2.3.2 Distribution

Sun et al. ([Sun 1993](#5-references)) reported that albumin and immunoglobulin A are the dominant binding protein of vancomycin, and that vancomycin does not bind to Alpha-1 acid glycoprotein (AAG). As in PK-Sim there is only option to bind to albumin or AAG, vancomycin binding is built-in as bound to albumin only in the PBPK model. The fraction unbound (fu) of Vancomycin is built-in as 0.67 as reported by Radke et al. ([Radke 2017](#5-references)).

After testing the available organ-plasma partition coefficient and cell permeability calculation methods built in PK-Sim, observed clinical data was best described by choosing the partition coefficient calculation method by Schmitt, and cell permeability calculation method by Charge dependent Schmidt . Specific organ permeability normalized to surface area was automatically calculated by PK-Sim.

### 2.3.3 Metabolism and Elimination

A previous PBPK model for vancomycin using PK-Sim was reported by Radke et al. ([Radke 2017](#5-references)) , with the dose fraction excreted unchanged into urine in adults being 90% with 10% hepatic elimination.  Zhou et al. ([Zhou 2016](#5-references)) also published a PBPK model for vancomycin introducing an unknown hepatic clearance process being roughly 20% of total elimination. Our final vancomycin model was rebuilt that applies only GFR mediated clearance that adequately described the pharmacokinetics in adults. No further improvement of vancomycin pharmacokinetics could be determined after introducing hepatic clearance.

