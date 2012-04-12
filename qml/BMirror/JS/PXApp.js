.pragma library

Qt.include("JSON2.js");

var hardCopy = function (obj) {

    return JSON.parse(JSON.stringify(obj));
}

var dump = function (obj) {

    var key, i = 1;

    if (typeof obj === "String") {

        console.log(obj);

    } else {

        for (key in obj) {

            console.log(i++ + ". '" + key + "' = '" + obj[key] + "'");
        }
    }
}

var removeFromArray = function (val, array) {

    var i = 0;

    for (i; i < array.length; i++) {

        if (array[i] === val) {

            array.splice(i, 1);
            return array;
        }
    }

    return false;
}
