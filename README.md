# Tuned Radio Frequency AM Receiver

This implementation in its simplest form does not include active amplifier and that is why can be used without external power supply. 

Parallel LC tank and detector stage in proposed configuration were often used in early radio receivers called crystal radio. In the circuit discussed here, crystal has been replaced with germanium diode. Half-wave rectifier has been also replaced with full rectifier. 

Experiments were made with use of more comon Shotkeys diodes, but were not successful (not possible to detect any signals). There was no noticable difference in volume of demodulated signal when half-wave rectifier was replaced with full-wave version. 

Attempt to use simple coil without a tap was made, but was not successful. Impedance of detector stage in such simple configuration seemed to attenuate LC circuit making reception not possible, that is why coil with tapping has been used in working design. 

Electronic circuit has been originally described by Andrzej Dabrowski OE1KDA in Swiat Radio [1] and Issue 54 of Library of Polish HAM [2].

Design of the coil is critical for entire circuit to work. This element has been made using 0.35mm emalia coated wire. Windings were made on paper tube put on ferrite rod from old radio receiver. Position of the coil can be adjusted by sliding to both sides of the rod allowing for limited resonance frequency adjustment. Tuning is made by the ear for strongest acusting signal. Coild winding configuration: 50 windings - 5cm long tap - 100 windings. All windings are made in the same direction. Parasitic capacitance of the coil allowed to put LC tank into resonance closed to target 225kHz frequency without connecting any capacitor. To bring resonance frequency closer to 225kHz, the 47pF ceramic capacitor was put parallel to the coil. Decreasing this capacitor to smaller value did not increase signal level at detector output, capacitor increase led to decrease in volume, which suggest that selected capacitance value is optimal for this particular design.

Mechanical mounting of the coil can be difficult. The most elegant would be to 3D print required moutning brackets. In this case simpler wooden mounts were used purely due to lack 3D printer access. See pictures below for details of coil mounting method:

>COIL MOUNTING PICTURE<

Value of LC tank elements can be calculated from the following formula:

                                                      $fr = 1/[2*PI*SQRT(L*(Cparacetic+C))]$

where fr = 225kHz
      L = (measured between ends of two sections - see picture below)
      C = 47pF (chosed by experimentation as described above)

Solving for Cparacitic gives us:

                                                            $fr*2*PI*SQRT(L*(Cparacetic+C))=1$
                                                              $L*(Cparacetic+C)=1/(fr*2*PI)^2$
                                                            $Cparacitic = 1/[L*(fr*2*PI)^2] - C$

Cparacitic (value of paracitic capacitance introduced in the coil) equals to ... pF.

Simulated characteristic of LC tank can be seen below:

>LC + DETECTOR FREQ RESP PICTURES<

Tap on the coil does not impact resonance frequency, however level of magnetic coupling shall be taken into account when calculating inductance value of the coil i.e. total inductance is higher then the sum of inductances of each section of the coil measured separately.

It shall be noted that in case of my design parasitic capacitance of the coil was very high and cannot be neglected in overall calculation of capacitor value (space existing between windings introduce unwanted capacitance).

Special thanks  to SP5... for great explanation of theory behind LC design [3] and time taken to anwser my emails.

Impedance value of LC tank at and around resonance frequency is very high (hundrats of kiloohms). This works well with random wire antennas since their impedance is in the range of 3kohm and above. It is not possible however to directly stimulate such LC circuit with NanoVNA or other test equipment with low output impedance (typically 50ohm) and expect to see circuit impedance peak at fr=225kHz... 

Impedance of detector stage is affected by the type of airphones used. In this simple design use of modern 32ohm headphones is not possible (detector stage would have too small impedance attenduating LC circuit). Instead high impedance earphone must be used (4kohm impedance).

Quality of earthing strongly impacts detector signal output level that is why good connection to earth is mandatory to receive acceptable volume heart in airphone.

To increase signal output and allow for use of 32ohm modern headphones simple 2 transistor amplifier has been added. Voltage amplification of this stage is in the range of 60 (see simulation result below):

>TRAN SIMULATION PICTURES<

Acustic signal at the output of the detector stage is biased towards higher frequencies. To correct for it low-pass filter is introduced together with volume control. Filtering introduces attenuation and it shall not be used in configuration with high impedance earphones.

>ACUSTIC SIGNAL PICTURE<

To further increase amplification LM386 based power amp can be used.

# Resources
[1] Swiat Radio 4/2014, Building Simplest Radio, http://www.swiatradio.com.pl/virtual/
[2] Library of Polish Radio Amateur, Issue 54: Simple Amateur Receivers, Part I, https://bpk.pzk.org.pl/
[3] Parallel Tuning Circuit by Marcin Swietlinski SP5NJW, https://sem.pl/sp5jnw/technika/technika.html