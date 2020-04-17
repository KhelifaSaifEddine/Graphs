import QtQuick 2.0

Canvas {
    property int x_pnt_1: 0
    property int y_pnt_1: 0
    property int x_pnt_2: 0
    property int y_pnt_2: 0
    property var ctx: null
    onPaint:{
        ctx=getContext("2d")
        ctx.lineWidth=2
        ctx.strokeStyle = "black"
        ctx.beginPath()
        ctx.moveTo(x_pnt_1,y_pnt_1)
        ctx.lineTo(x_pnt_2,y_pnt_2)
        ctx.stroke()
    }
}
