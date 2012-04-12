Qt.include("../PXApp.js");

var removeRowFromModel = function (row, model, controller, callback) {

    var i = 0, current_row;

    for (i; i < model.count; i++) {

        current_row = model.get(i);

        if (current_row.rowTextKey == row.identifier()) {
            model.remove(i);
            callback(row, model, controller);
        }
    }
};
