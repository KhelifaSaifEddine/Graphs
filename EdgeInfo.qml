import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: root
    property alias subWidth: backGrnd.width
    property alias subHeight: backGrnd.height
    property alias node_title_1: node_1.text
    property alias node_title_2: node_2.text
    property alias subColor: backGrnd.color
    signal clicked
    Rectangle{
        id:backGrnd
        color: "#323232"
        width: 140
        height: 40
        radius: 4
        Text {
            id: node_1
            text: qsTr("N1")
            color: "#fafafa"
            width:parent.width/3
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 4
        }
        Text{
            id: node_2
            text: qsTr("N2")
            color: "#fafafa"
            width:parent.width/3
            anchors.left: node_1.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 4
        }
        Button{
            id:button
            text: " X "
            width: 35
            anchors.left: node_2.right
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                root.clicked()
            }
        }
    }

}
