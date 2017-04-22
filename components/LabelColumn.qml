import QtQuick 2.0

Column {
    id: root

    property alias model: repeater.model
    property int fontPixelSize: showDecimal ? 12 : 20
    property bool showDecimal
    property Component ruler: Rectangle {
        width: 15
        height: 1
        color: "gray"
    }
    Repeater {
        id: repeater

        Label {
            property real value: modelData
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            height: model.index > 0 ? value - repeater.itemAt(model.index - 1).value : value
            onImplicitWidthChanged: if (implicitWidth > root.width) root.width = implicitWidth
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            text: showDecimal ? height.toFixed(1) : height.toString()
            font.pixelSize: fontPixelSize
            Loader {
                property int index: model.index

                y: -1
                anchors.bottom: parent.bottom
                anchors.right: parent.left
                anchors.rightMargin: 3
                sourceComponent: ruler
            }
        }
    }
}
