# DIU
Code used to produce figures in manuscripts "Delay-Induced Uncertainty in a Paradigmatic Glucose-Insulin Model" (published in Chaos) and "Delay-Induced Uncertainty in the Glucose-Insulin System: Pathogenecity for Obesity and Type-2 Diabeetes Mellitus" (submitted) is found in this repository.

#Ultradian.m contains code encoding the full Ultradian glucose-insulin model.  It must be called using ode23 in other MATLAB scripts.

#EUltradian1.m contains code that produces the figures seen Figure 3 of the Chaos manuscript.

#EUltradianLya.m contains code that produces the figures seen in Figures 4--6 of the Chaos manuscript.

#EUltradian2.m contains code that produces the figures seen in Figure 7 of Chaos manuscript.  Note:  to compute Lyapounoff exponents, you will need to modify code in EUltradianLya.m

#EUltradianLya2.m contains code that produces the figures seen in Figure 8 of the Chaos manuscript.

#EUltradianLya3.m contains code that produces the figures seen in Figure 2 of the submitted manuscript.  Note:  to obtain the Lyapounoff exponents as a function of different paramters, you will have to alter the code to loop through the parameter of your interest.
