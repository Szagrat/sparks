function Resistor() {
    this.colorMap[-1] = 'gold';
    this.colorMap[-2] = 'silver';
}
Resistor.prototype =
{
    nominalValue : 0.0, //resistance value specified by band colors;
    realValue : 0.0, //real resistance value in Ohms
    tolerance : 0.0, //tolerance value
    
    minValue : 0.1,
    maxValue : 999500,
    
    colorMap : { 0 : 'black', 1 : 'brown', 2 : 'red', 3 : 'orange',
        4 : 'yellow', 5 : 'green', 6 : 'blue', 7 : 'violet', 8 : 'grey',
        9 : 'white' },
        
    toleranceColorMap : { 0.01 : 'brown', 0.02 : 'red', 5e-3 : 'green',
        2.5e-3 : 'blue', 1e-3 : 'violet', 5e-4 : 'gray', 5e-2 : 'gold',
        0.1 : 'silver', 0.2 : 'none' },
    //toleranceValues : [ 0.01, 0.02, 5e-3, 2.5e-3, 1e-3, 5e-4, 5e-2,
    //                    0.1, 0.2],
    toleranceValues : [ 0.01, 0.02, 5e-2, 0.1 ],
    
    show : function() {
        sendCommand('show_resistor');
    },
    
    randomize : function() {
        var colors = [];
        
        var band1 = this.randInt(1, 9);
        colors[0] = this.colorMap[band1];
        
        var band2 = this.randInt(0, 9);
        colors[1] = this.colorMap[band2];
        
        var base = band1 * 10 +  band2; // 10..99
        
        // Multiplier: 10^-2..10^9
        var pwr;
        if (base > 19) {
            pwr = this.randInt(-1, 4);
        }
        else {
            pwr = this.randInt(-1, 5);
        }
        
        colors[2] = this.colorMap[pwr];
        this.nominalValue = base * Math.pow(10, pwr);
        
        var ix = this.randInt(0, 3);
        this.tolerance = this.toleranceValues[ix];
        
        colors[3] = this.toleranceColorMap[this.tolerance];
        
        this.realValue = this.getRealValue(this.nominalValue, this.tolerance);
        
        console.log('sending colors=' + colors.join('|'));
        sendCommand('set_resistor_label', colors);
    },
    
    getRealValue : function(nominalValue, tolerance) {
        var chance = Math.random();
        if (chance > 0.8) {
            var chance2 = Math.random();
            if (chance2 < 0.5) {
                return nominalValue + nominalValue * (tolerance + Math.random() * tolerance);
            }
            else {
                return nominalValue - nominalValue * (tolerance + Math.random() * tolerance);
            }
        }

        // Multiply 0.9 just to be comfortably within tolerance
        var realTolerance = tolerance * 0.9;
        return nominalValue * this.randFloat(1 - realTolerance, 1 + realTolerance);
    },
    
    randInt : function(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    },
    
    randFloat : function(min, max) {
        return this.randPseudoGaussian(3) * (max - min) + min;
    },
    
    randPseudoGaussian : function(n) {
        var r = 0.0;
        for (var i = 0; i < n; ++i) {
            r += Math.random();
        }
        return r / n;
    }
};