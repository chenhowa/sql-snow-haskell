var esprima = require('esprima');

if(process.argv[2]) {
    esprima.parseScript(process.argv[2])
}
