import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

import "./formatters/formatters.js" as Formatters

ColumnLayout
{
    id: root

    property bool enabled
    property string textColor
    property string backgroundColor
    property bool showFormatters: true
    property string fieldLabel: qsTr("Value:")    
    property bool isEdited: false
    property var value    

    function validate(callback) {
        loadRawValue(function (error, raw) {
            if (error) {                
                notification.showError(error)
                return callback(false);
            }

            var valid = raw.length > 0

            if (valid) {
                hideValidationError()
            } else {
                showValidationError("Enter value")
            }

            return callback(valid)
        });
    }

    function loadRawValue(callback) {
       var formatter = formatterSelector.model[formatterSelector.currentIndex]

        formatter.instance.getRaw(textArea.text, function (error, raw) {
            root.value = raw
            return callback(error, raw)
        })
    }

    function loadFormattedValue(val) {

        if (val) {
            root.value = val
        }

        if (!root.value) {
            console.log("Empty value. Skipping formatting stage");
            return;
        }

        var isBin = binaryUtils.isBinaryString(root.value)

        binaryFlag.visible = false        

        if (isBin) binaryFlag.visible = true        

        var formatter = formatterSelector.model[formatterSelector.currentIndex]

        uiBlocker.visible = true                

        formatter.instance.getFormatted(root.value, function (error, formatted, isReadOnly, format) {

            if (error || !formatted) {
                uiBlocker.visible = false
                formatterSelector.currentIndex = 0 // Reset formatter to plain text
                notification.showError(error || qsTr("Unknown formatter error (Empty response)"))
                return
            }

            if (format === "json") {
                // 1 is JSON
                return formatterSelector.model[1].instance.getFormatted(formatted, function (formattedJson, r, f) {

                    textArea.text = formattedJson
                    textArea.readOnly = isReadOnly
                    textArea.textFormat = TextEdit.PlainText
                    root.isEdited = false
                    uiBlocker.visible = false
                })
            } else {               
                textArea.text = formatted
                textArea.readOnly = isReadOnly
                root.isEdited = false

                if (format === "html")
                    textArea.textFormat = TextEdit.RichText
                else
                    textArea.textFormat = TextEdit.PlainText
            }

            uiBlocker.visible = false
        })
    }

    function reset() {
        textArea.text = ""
        root.value = ""
        root.isEdited = false
        hideValidationError()
    }

    function showValidationError(msg) {
        validationError.text = msg
        validationError.visible = true
    }

    function hideValidationError() {
        validationError.visible = false
    }

    RowLayout{
        visible: showFormatters
        Layout.fillWidth: true

        Text { text: root.fieldLabel }
        TextEdit { text: qsTr("size: ") + binaryUtils.humanSize(binaryUtils.binaryStringLength(value)); readOnly: true; color: "#ccc"  }
        Text { id: binaryFlag; text: qsTr("[Binary]"); visible: false; color: "green"; }        
        Item { Layout.fillWidth: true }
        Text { text: qsTr("View as:") }

        ComboBox {
            id: formatterSelector
            width: 200
            model: Formatters.buildFormattersModel()
            textRole: "name"
            objectName: "rdm_value_editor_formatter_combobox"

            onCurrentIndexChanged: {
                Formatters.defaultFormatterIndex = currentIndex
                loadFormattedValue()
            }
            Component.onCompleted: {
                currentIndex = Formatters.defaultFormatterIndex;
            }
        }       
    }

    TextArea {
        id: textArea
        enabled: root.enabled
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 100
        objectName: "rdm_key_multiline_text_field"

        style: TextAreaStyle {
            renderType: Text.QtRendering
        }

        font { family: monospacedFont.name; pointSize: 12 }
        wrapMode: TextEdit.WrapAnywhere

        onTextChanged: root.isEdited = true
    }


    Text {
        id: validationError
        color: "red"
        visible: false
    }

    Rectangle {
        id: uiBlocker
        visible: false
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.1)

        Item {
            anchors.fill: parent
            BusyIndicator { anchors.centerIn: parent; running: true }
        }

        MouseArea { anchors.fill: parent }
    }
}
