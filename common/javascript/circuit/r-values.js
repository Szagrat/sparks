// Allowable resistance values

var r_values = {};

// For 1% tolerance (5-band)
r_values.r_values5band1pct = [
  1.00, 1.02, 1.05, 1.07, 1.10, 1.13, 1.15, 1.18, 1.21, 1.24, 1.27,
  1.30, 1.33, 1.37, 1.40, 1.43, 1.47, 1.50, 1.54, 1.58, 1.62, 1.65, 1.69,
  1.74, 1.78, 1.82, 1.87, 1.91, 1.96,
  2.00, 2.05, 2.10, 2.15, 2.21, 2.26, 2.32, 2.37, 2.43, 2.49, 2.55, 2.61, 2.67,
  2.74, 2.80, 2.87, 2.94, 3.01, 3.09, 3.16, 3.24, 3.32, 3.40, 3.48, 3.57, 3.65,
  3.74, 3.83, 3.92, 4.02, 4.12, 4.22, 4.32, 4.42, 4.53, 4.64, 4.75, 4.87, 4.99,
  5.11, 5.23, 5.36, 5.49, 5.62, 5.76, 5.90, 6.04, 6.19, 6.34, 6.49, 6.65, 6.81,
  6.98, 7.15, 7.32, 7.50, 7.68, 7.87, 8.06, 8.25, 8.45, 8.66, 8.87,
  9.09, 9.31, 9.53, 9.76, 10.0, 10.2, 10.5, 10.7, 11.0, 11.3, 11.5, 11.8,
  12.1, 12.4, 12.7, 13.0, 13.3, 13.7, 14.0, 14.3, 14.7,
  15.0, 15.4, 15.8, 16.2, 16.5, 16.9, 17.4, 17.8, 18.2, 18.7, 19.1, 19.6,
  20.0, 20.5, 21.0, 21.5, 22.1, 22.6, 23.2, 23.7, 24.3, 24.9, 25.5, 26.1, 26.7,
  27.4, 28.0, 28.7, 29.4, 30.1, 30.9, 31.6, 32.4, 33.2, 34.0, 34.8, 35.7, 36.5,
  37.4, 38.3, 39.2, 40.2, 41.2, 42.2, 43.2, 44.2, 45.3, 46.4, 47.5, 48.7, 49.9,
  51.1, 52.3, 53.6, 54.9, 56.2, 57.6, 59.0, 60.4, 61.9, 63.4, 64.9, 66.5,
  68.1, 69.8, 71.5, 73.2, 75.0, 76.8, 78.7, 80.6, 82.5, 84.5, 86.6, 88.7,
  90.9, 93.1, 95.3, 97.6, 100, 102, 105, 107, 110, 113, 115, 118, 121, 124,
  127, 130, 133, 137, 140, 143, 147, 150, 154, 158, 162, 165, 169,
  174, 178, 182, 187, 191, 196,
  200, 205, 210, 215, 221, 226, 232, 237, 243, 249, 255, 261, 267, 274, 280,
  287, 294, 301, 309, 316, 324, 332, 340, 348, 357, 365, 374, 383, 392,
  402, 412, 422, 432, 442, 453, 464, 475, 487, 499, 511, 523, 536, 549, 562,
  576, 590, 604, 619, 634, 649, 665, 681, 698, 715, 732, 750, 768, 787,
  806, 825, 845, 866, 887, 909, 931, 953, 976,
  1000, 1020, 1050, 1070, 1100, 1130, 1150, 1180, 1210, 1240, 1270,
  1300, 1330, 1370, 1400, 1430, 1470, 1500, 1540, 1580, 1620, 1650, 1690,
  1740, 1780, 1820, 1870, 1910, 1960, 2000, 2050, 2100, 2150, 2210, 2260,
  2320, 2370, 2430, 2490, 2550, 2610, 2670, 2740, 2800, 2870, 2940,
  3010, 3090, 3160, 3240, 3320, 3400, 3480, 3570, 3650, 3740, 3830, 3920,
  4020, 4120, 4220, 4320, 4420, 4530, 4640, 4750, 4870, 4990,
  5110, 5230, 5360, 5490, 5620, 5760, 5900,
  6040, 6190, 6340, 6490, 6650, 6810, 6980, 7150, 7320, 7500, 7680, 7870,
  8060, 8250, 8450, 8660, 8870, 9090, 9310, 9530, 9760,
  10000, 10200, 10500, 10700, 11000, 11300, 11500, 11800, 12100, 12400, 12700,
  13000, 13300, 13700, 14000, 14300, 14700, 15000, 15400, 15800,
  16200, 16500, 16900, 17400, 17800, 18200, 18700, 19100, 19600,
  20000, 20500, 21000, 21500, 22100, 22600, 23200, 23700, 24300, 24900,
  25500, 26100, 26700, 27400, 28000, 28700, 29400, 30100, 30900, 31600, 32400,
  33200, 34000, 34800, 35700, 36500, 37400, 38300, 39200, 40200, 41200, 42200,
  43200, 44200, 45300, 46400, 47500, 48700, 49900,
  51100, 52300, 53600, 54900, 56200, 57600, 59000, 60400, 61900, 63400, 64900,
  66500, 68100, 69800, 71500, 73200, 75000, 76800, 78700,
  80600, 82500, 84500, 86600, 88700, 90900, 93100, 95300, 97600,
  100e3, 102e3, 105e3, 107e3, 110e3, 113e3, 115e3, 118e3, 121e3, 124e3, 127e3,
  130e3, 133e3, 137e3, 140e3, 143e3, 147e3, 150e3, 154e3, 158e3,
  162e3, 165e3, 169e3, 174e3, 178e3, 182e3, 187e3, 191e3, 196e3,
  200e3, 205e3, 210e3, 215e3, 221e3, 226e3, 232e3, 237e3, 243e3, 249e3, 255e3,
  261e3, 267e3, 274e3, 280e3, 287e3, 294e3, 301e3, 309e3, 316e3, 324e3, 332e3,
  340e3, 348e3, 357e3, 365e3, 374e3, 383e3, 392e3, 402e3, 412e3, 422e3, 432e3,
  442e3, 453e3, 464e3, 475e3, 487e3, 499e3, 511e3, 523e3, 536e3, 549e3, 562e3,
  576e3, 590e3, 604e3, 619e3, 634e3, 649e3, 665e3, 681e3, 698e3,
  715e3, 732e3, 750e3, 768e3, 787e3, 806e3, 825e3, 845e3, 866e3, 887e3, 909e3,
  931e3, 953e3, 976e3,
  1.00e6, 1.02e6, 1.05e6, 1.07e6, 1.10e6, 1.13e6, 1.15e6, 1.18e6,
  1.21e6, 1.24e6, 1.27e6, 1.30e6, 1.33e6, 1.37e6, 1.40e6, 1.43e6, 1.47e6,
  1.50e6, 1.54e6, 1.58e6, 1.62e6, 1.65e6, 1.69e6, 1.74e6, 1.78e6,
  1.82e6, 1.87e6, 1.91e6, 1.96e6,
  2.00e6, 2.05e6, 2.10e6, 2.15e6, 2.21e6, 2.26e6, 2.32e6, 2.37e6,
  2.43e6, 2.49e6, 2.55e6, 2.61e6, 2.67e6, 2.74e6, 2.80e6, 2.87e6, 2.94e6,
  3.01e6, 3.09e6, 3.16e6, 3.24e6, 3.32e6, 3.40e6, 3.48e6, 3.57e6, 3.65e6,
  3.74e6, 3.83e6, 3.92e6,
  4.02e6, 4.12e6, 4.22e6, 4.32e6, 4.42e6, 4.53e6, 4.64e6, 4.75e6, 4.87e6,
  4.99e6, 5.11e6, 5.23e6, 5.36e6, 5.49e6, 5.62e6, 5.76e6, 5.90e6,
  6.04e6, 6.19e6, 6.34e6, 6.49e6, 6.65e6, 6.81e6, 6.98e6,
  7.15e6, 7.32e6, 7.50e6, 7.68e6, 7.87e6, 8.06e6, 8.25e6, 8.45e6, 8.66e6,
  8.87e6, 9.09e6, 9.31e6, 9.53e6, 9.76e6,
  10.0e6, 10.2e6, 10.5e6, 10.7e6, 11.0e6, 11.3e6, 11.5e6, 11.8e6,
  12.1e6, 12.4e6, 12.7e6, 13.0e6, 13.3e6, 13.7e6, 14.0e6, 14.3e6, 14.7e6,
  15.0e6, 15.4e6, 15.8e6, 16.2e6, 16.5e6, 16.9e6, 17.4e6, 17.8e6,
  18.2e6, 18.7e6, 19.1e6, 19.6e6, 20.0e6, 20.5e6, 21.0e6, 21.5e6,
  22.1e6, 22.6e6, 23.2e6, 23.7e6, 24.3e6, 24.9e6, 25.5e6, 26.1e6, 26.7e6,
  27.4e6, 28.0e6, 28.7e6, 29.4e6, 30.1e6, 30.9e6, 31.6e6, 32.4e6, 33.2e6,
  34.0e6, 34.8e6, 35.7e6, 36.5e6, 37.4e6, 38.3e6, 39.2e6,
  40.2e6, 41.2e6, 42.2e6, 43.2e6, 44.2e6, 45.3e6, 46.4e6, 47.5e6, 48.7e6,
  49.9e6, 51.1e6, 52.3e6, 53.6e6, 54.9e6, 56.2e6, 57.6e6, 59.0e6,
  60.4e6, 61.9e6, 63.4e6, 64.9e6, 66.5e6, 68.1e6, 69.8e6, 71.5e6, 73.2e6,
  75.0e6, 76.8e6, 78.7e6, 80.6e6, 82.5e6, 84.5e6, 86.6e6, 88.7e6,
  90.9e6, 93.1e6, 95.3e6, 97.6e6,
  100e6, 102e6, 105e6, 107e6, 110e6, 113e6, 115e6, 118e6, 121e6, 124e6, 127e6,
  130e6, 133e6, 137e6, 140e6, 143e6, 147e6, 150e6, 154e6, 158e6,
  162e6, 165e6, 169e6, 174e6, 178e6, 182e6, 187e6, 191e6, 196e6, 200e6
];

// For 2% tolerance (5-band)
r_values.r_values5band2pct = [
  1.00, 1.05, 1.10, 1.15, 1.21, 1.27, 1.33, 1.40,
  1.47, 1.54, 1.62, 1.69, 1.78, 1.87, 1.96,
  2.05, 2.15, 2.26, 2.37, 2.49, 2.61, 2.74, 2.87,
  3.01, 3.16, 3.32, 3.48, 3.65, 3.83, 4.02, 4.22, 4.42, 4.64, 4.87,
  5.11, 5.36, 5.62, 5.90, 6.19, 6.49, 6.81, 7.15, 7.50, 7.87,
  8.25, 8.66, 9.09, 9.53, 10.0, 10.5, 11.0, 11.5, 12.1, 12.7, 13.3, 14.0, 14.7,
  15.4, 16.2, 16.9, 17.8, 18.7, 19.6, 20.5, 21.5, 22.6, 23.7, 24.9, 26.1, 27.4,
  28.7, 30.1, 31.6, 33.2, 34.8, 36.5, 38.3, 40.2, 42.2, 44.2, 46.4, 48.7,
  51.1, 53.6, 56.2, 59.0, 61.9, 64.9, 68.1, 71.5, 75.0, 78.7, 82.5, 86.6,
  90.9, 95.3, 100, 105, 110, 115, 121, 127, 133, 140, 147, 154, 162, 169, 178,
  187, 196, 205, 215, 226, 237, 249, 261, 274, 287, 301, 316, 332, 348, 365,
  383, 402, 422, 442, 464, 487, 511, 536, 562, 590, 619, 649, 681,
  715, 750, 787, 825, 866, 909, 953, 1000, 1050, 1100, 1150, 1210, 1270, 1330,
  1400, 1470, 1540, 1620, 1690, 1780, 1870, 1960, 2050, 2150, 2260, 2370, 2490,
  2610, 2740, 2870, 3010, 3160, 3320, 3480, 3650, 3830,
  4020, 4220, 4420, 4640, 4870, 5110, 5360, 5620, 5900, 6190, 6490, 6810,
  7150, 7500, 7870, 8250, 8660, 9090, 9530, 10000, 10500, 11000, 11500,
  12100, 12700, 13300, 14000, 14700, 15400, 16200, 16900, 17800, 18700, 19600,
  20500, 21500, 22600, 23700, 24900, 26100, 27400, 28700, 30100, 31600, 33200,
  34800, 36500, 38300, 40200, 42200, 44200, 46400, 48700,
  51100, 53600, 56200, 59000, 61900, 64900, 68100, 71500, 75000, 78700,
  82500, 86600, 90900, 95300, 100e3, 105e3, 110e3, 115e3, 121e3, 127e3, 133e3,
  140e3, 147e3, 154e3, 162e3, 169e3, 178e3, 187e3, 196e3,
  205e3, 215e3, 226e3, 237e3, 249e3, 261e3, 274e3, 287e3,
  301e3, 316e3, 332e3, 348e3, 365e3, 383e3, 402e3, 422e3, 442e3, 464e3, 487e3,
  511e3, 536e3, 562e3, 590e3, 619e3, 649e3, 681e3, 715e3, 750e3, 787e3,
  825e3, 866e3, 909e3, 953e3, 1e6, 1.05e6, 1.1e6, 1.15e6, 1.21e6, 1.27e6,
  1.33e6, 1.40e6, 1.47e6, 1.54e6, 1.62e6, 1.69e6, 1.78e6, 1.87e6, 1.96e6,
  2.05e6, 2.15e6, 2.26e6, 2.37e6, 2.49e6, 2.61e6, 2.74e6, 2.87e6,
  3.01e6, 3.16e6, 3.32e6, 3.48e6, 3.65e6, 3.83e6,
  4.02e6, 4.22e6, 4.42e6, 4.64e6, 4.87e6, 5.11e6, 5.36e6, 5.62e6, 5.90e6,
  6.19e6, 6.49e6, 6.81e6, 7.15e6, 7.50e6, 7.87e6, 8.25e6, 8.66e6,
  9.09e6, 9.53e6, 10.0e6, 10.5e6, 11.0e6, 11.5e6, 12.1e6, 12.7e6, 13.3e6,
  14.0e6, 14.7e6, 15.4e6, 16.2e6, 16.9e6, 17.8e6, 18.7e6, 19.6e6, 20.5e6, 21.5e6,
  22.6e6, 23.7e6, 24.9e6, 26.1e6, 27.4e6, 28.7e6,
  30.1e6, 31.6e6, 33.2e6, 34.8e6, 36.5e6, 38.3e6,
  40.2e6, 42.2e6, 44.2e6, 46.4e6, 48.7e6, 51.1e6, 53.6e6, 56.2e6, 59.0e6,
  61.9e6, 64.9e6, 68.1e6, 71.5e6, 75e6, 78.7e6, 82.5e6, 86.6e6,
  90.9e6, 95.3e6,
  100e6, 105e6, 110e6, 115e6, 121e6, 127e6, 133e6, 140e6, 147e6, 154e6,
  162e6, 169e6, 178e6, 187e6, 196e6
];

// For 5% tolerance (4-band)
r_values.r_values4band5pct = [
    1.0, 1.1, 1.2, 1.3, 1.5, 1.6, 1.8, 2.0, 2.2, 2.4, 2.7, 3.0, 3.3, 3.6, 3.9,
    4.3, 4.7, 5.1, 5.6, 6.2, 6.8, 7.5, 8.2, 9.1,
    10, 11, 12, 13, 15, 16, 18, 20, 22, 24, 27, 30, 33, 36, 39,
    43, 47, 51, 56, 62, 68, 75, 82, 91, 
    100, 110, 120, 130, 150, 160, 180, 200, 220, 240, 270, 300, 330, 360, 390,
    430, 470, 510, 560, 620, 680, 750, 820, 910, 
    1.0e3, 1.1e3, 1.2e3, 1.3e3, 1.5e3, 1.6e3, 1.8e3, 2.0e3, 2.2e3, 2.4e3, 2.7e3,
    3.0e3, 3.3e3, 3.6e3, 3.9e3, 4.3e3, 4.7e3, 5.1e3, 5.6e3, 6.2e3, 6.8e3, 7.5e3,
    8.2e3, 9.1e3,
    10e3, 11e3, 12e3, 13e3, 15e3, 16e3, 18e3, 20e3, 22e3, 24e3, 27e3, 30e3,
    33e3, 36e3, 39e3, 43e3, 47e3, 51e3, 56e3, 62e3, 68e3, 75e3, 82e3, 91e3,
    100e3, 110e3, 120e3, 130e3, 150e3, 160e3, 180e3, 200e3, 220e3, 240e3, 270e3,
    300e3, 330e3, 360e3, 390e3, 430e3, 470e3, 510e3, 560e3, 620e3, 680e3, 750e3,
    820e3, 910e3,
    1.0e6, 1.1e6, 1.2e6, 1.3e6, 1.5e6, 1.6e6, 1.8e6, 2.0e6, 2.2e6, 2.4e6, 2.7e6,
    3.0e6, 3.3e6, 3.6e6, 3.9e6, 4.3e6, 4.7e6, 5.1e6, 5.6e6, 6.2e6, 6.8e6, 7.5e6,
    8.2e6, 9.1e6, 10e6, 11e6, 12e6, 13e6, 15e6, 16e6, 18e6, 20e6, 22e6, 24e6,
    27e6, 30e6, 33e6, 36e6, 39e6, 43e6, 47e6, 51e6, 56e6, 62e6, 68e6, 75e6,
    82e6, 91e6 
];

// For 10% tolerance (4-band)
r_values.r_values4band10pct = [
    1.0, 1.2, 1.5, 1.8, 2.2, 2.7, 3.3, 3.9, 4.7, 5.6, 6.8, 8.2,
    10, 12, 15, 18, 22, 27, 33, 39, 47, 56, 68, 82, 
    100, 120, 150, 180, 220, 270, 330, 390, 470, 560, 680, 820, 
    1.0e3, 1.2e3, 1.5e3, 1.8e3, 2.2e3, 2.7e3, 3.3e3, 3.9e3, 4.7e3, 5.6e3,
    6.8e3, 8.2e3,
    10e3, 12e3, 15e3, 18e3, 22e3, 27e3, 33e3, 39e3, 47e3, 56e3, 68e3, 82e3,
    100e3, 120e3, 150e3, 180e3, 220e3, 270e3, 330e3, 390e3, 470e3, 560e3, 680e3,
    820e3,
    1.0e6, 1.2e6, 1.5e6, 1.8e6, 2.2e6, 2.7e6, 3.3e6, 3.9e6, 4.7e6, 5.6e6, 6.8e6,
    8.2e6,
    10e6, 12e6, 15e6, 18e6, 22e6, 27e6, 33e6, 39e6, 47e6, 56e6, 68e6, 82e6
];
