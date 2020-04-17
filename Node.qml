import QtQuick 2.5
import QtQuick.Controls 1.4

Item{
    id:root
    width: 30
    height: 30
    property string title: "Node"
    Rectangle{
        id:nodeDraw
        color: "#424242"
        //implicitHeight: 24
        //implicitWidth: 24
        //anchors.fill: parent
        height : 24
        width: 24
        radius: 15
        border.color: "#090909"
        border.width: 2
        x:3
        y:3
        ParallelAnimation{
            id: widen
            PropertyAnimation{
                id: widenScale
                target: nodeDraw
                easing.type: Easing.OutElastic
                properties: "width,height"
                to:30
                duration: 350
            }
            PropertyAnimation{
                id: setXWiden
                target: nodeDraw
                easing.type: Easing.OutElastic
                property: "x"
                to:0
                duration: 350
            }
            PropertyAnimation{
                id: setYWiden
                target: nodeDraw
                easing.type: Easing.OutElastic
                property: "y"
                to:0
                duration: 350
            }
        }
        ParallelAnimation{
            id: shrink
            PropertyAnimation{
                id: shrinkScale
                target: nodeDraw
                easing.type: Easing.OutElastic
                properties: "width,height"
                to:24
                duration: 350
            }
            PropertyAnimation{
                id: setXShrink
                target: nodeDraw
                easing.type: Easing.OutElastic
                property: "x"
                to:3
                duration: 350
            }
            PropertyAnimation{
                id: setYShrink
                target: nodeDraw
                easing.type: Easing.OutElastic
                property: "y"
                to:3
                duration: 350
            }
        }
    }
    Label{
        id:label
        text:title
        font.family: "Century Gothic"
        font.pointSize: 10
        font.bold: true
        color: "#bdbdbd"
        anchors.left:nodeDraw.right
    }
    //Drag.active: mouseArea.drag.active
    MouseArea {
        id:mouseArea
        anchors.fill: parent
        drag.target: root
        hoverEnabled: true
        onEntered: {
            shrink.stop()
            widen.start()
            nodeDraw.border.width=3
            nodeDraw.border.color="#43A047"
        }
        onClicked: {
            nodeDraw.border.width=3
            nodeDraw.border.color="#43A047"
        }
        onExited: {
            widen.stop()
            shrink.start()
            nodeDraw.border.width=2
            nodeDraw.border.color="#090909"
        }
    }
}
