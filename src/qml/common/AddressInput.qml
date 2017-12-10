import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

RowLayout {

    property alias placeholderText: textField.placeholderText
    property alias host: textField.text
    property alias port: portField.value
    property alias style: textField.style

    TextField {
        id: textField
        Layout.fillWidth: true
    }

    Label { text: ":" }

    SpinBox {
        id: portField
        minimumValue: 1
        maximumValue: 10000000000
        value: 22
        decimals: 0
    }
}
