import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Dialogs 1.2
import QtQml.Models 2.2
import QtQuick.Window 2.2
import "./../common/platformutils.js" as PlatformUtils
import "."

TreeView {
    id: root
    alternatingRowColors: false
    headerVisible: false
    focus: true
    horizontalScrollBarPolicy: Qt.ScrollBarAsNeeded
    verticalScrollBarPolicy: Qt.ScrollBarAsNeeded

    TableViewColumn {
        title: "item"
        role: "icon"
        width: 25
        delegate: Item {

            Image {
                anchors.centerIn: parent
                sourceSize.width: 25
                sourceSize.height: 25
                source: styleData.value
                cache: true
                asynchronous: true
            }
        }
    }

    TableViewColumn {
        id: itemColumn
        title: "item"
        role: "name"
        width: root.width - 50
    }

    itemDelegate: FocusScope {
        id: itemRoot

        Item {
            id: wrapper
            objectName: "rdm_tree_view_item"
            height: PlatformUtils.isOSXRetina(Screen) ? 20 : 30
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10            

            property bool itemEnabled: connectionsManager? connectionsManager.getItemData(styleData.index, "state") : true

            Text {
                objectName: "rdm_tree_view_item_text"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                //elide: styleData.elideMode
                text: wrapper.itemEnabled ? styleData.value : styleData.value + qsTr(" (Removed)")
                color: wrapper.itemEnabled ? "black": "#ccc"
                anchors.leftMargin: {
                    if (connectionsManager) {
                        var itemDepth = connectionsManager.getItemData(styleData.index, "depth")
                        return itemDepth * 10 + 15
                    } else {
                        return 35
                    }
                }
            }

            Timer {
                id: selectionTimer
                interval: 1000;
                running: styleData.index && styleData.selected && wrapper.itemEnabled
                repeat: true
                triggeredOnStart: true
                onTriggered: wrapper.itemEnabled = connectionsManager.getItemData(styleData.index, "state")
            }

            Loader {
                id: menuLoader
                anchors {right: wrapper.right; top: wrapper.top; bottom: wrapper.bottom; }
                anchors.rightMargin: 20
                height: parent.height
                visible: styleData.selected && wrapper.itemEnabled
                asynchronous: true

                source: {
                    if (!styleData.selected
                            || !connectionsManager
                            || !styleData.index)
                        return ""

                    var type = connectionsManager.getItemData(styleData.index, "type")

                    if (type != undefined) {
                        return "./menu/" + type + ".qml"
                    } else {
                        return ""
                    }
                }

                onLoaded: {
                    wrapper.forceActiveFocus()                    
                }
            }

            MouseArea {
                anchors.fill: parent

                acceptedButtons: Qt.RightButton | Qt.MiddleButton

                onClicked: {
                    console.log("Catch event to item")

                    if(mouse.button == Qt.RightButton) {
                        mouse.accepted = true
                        connectionTreeSelectionModel.setCurrentIndex(styleData.index, 1)
                        connectionsManager.sendEvent(styleData.index, "right-click")
                        return
                    }

                    if (mouse.button == Qt.MiddleButton) {
                        mouse.accepted = true
                        connectionsManager.sendEvent(styleData.index, "mid-click")
                        return
                    }
                }
            }

            focus: true
            Keys.forwardTo: menuLoader.item ? [menuLoader.item] : []

        }
    }

    selectionMode: SelectionMode.SingleSelection

    selection: ItemSelectionModel {
        id: connectionTreeSelectionModel
        model: connectionsManager
    }

    model: connectionsManager

    rowDelegate: Rectangle {
        height: PlatformUtils.isOSXRetina(Screen) ? 25 : 30
        color: styleData.selected ? "#e2e2e2" : "white"
    }

    onClicked: {
        if (!connectionsManager)
            return

        connectionsManager.sendEvent(index, "click")
    }

    onExpanded: connectionsManager.setExpanded(index)
    onCollapsed: connectionsManager.setCollapsed(index)

    Connections {
        target: connectionsManager;
        onExpand: {
            if (!root.isExpanded(index)) {
                root.expand(index)
            }
        }
    }
}
