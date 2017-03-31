// This constructor function will be used to create starships
/**
 * @param {*} r - Registry Number
 * @param {*} n - Name
 * @param {*} p - Max Power Available
 */
var Shipyard = function(r, n, p) {
    // "Hidden" variables - "closures"
    var maxPower = p;
    var currentPower = 0;
    // Return an object with certain properties
    return {
        // Get-Only access to the power status
        getCurrentPower: function() { return currentPower; },
        launch: function() { currentPower = maxPower; },
        registry: r,
        name: n,
        status: 'green',
        shields: 0,
        takeDamage: function(amount) {
            if(amount > this.shields) {
                this.shields = this.shields - amount;
                currentPower = currentPower + this.shields;
                this.shields = 0;
            } else {
                this.shields = this.shields - amount;
            }
         },
        alert: function(statusChange) {
            if(statusChange === 'green') {
                // Transfer power from shields to the general ship power
                currentPower = currentPower + this.shields; 
                // Set shields to zero
                this.shields = 0;
                // All is well
            } else if(statusChange === 'yellow') {
                // Proceed with caution
                this.shields = currentPower / 4;
                currentPower -= this.shields;
            } else if(statusChange === 'red') {
                // Who's shooting at us?!
                this.shields = currentPower / 2;
                currentPower -= this.shields;
            }
        }
    }
}

var fleet = []; // Create an empty array of objects
var shipRef = new Shipyard('NCC-1701', 'Enterprise', 3000);
// add this ship to the fleet
fleet.push(shipRef);

// add directly to the array as I call the constructor
fleet.push(new Shipyard('NCC-1672', 'USS Exeter', 3000));

