import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

ApplicationWindow {
    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("Basic Graph Editor")
    visibility : Window.Maximized
    SplitView{
        id:split
        anchors.fill: parent
        Rectangle{
            id:option
            color:"#494949"
            Layout.maximumWidth: 400
            Layout.minimumWidth: 180
            width:200
            //anchors.top: parent.top
            //anchors.bottom: parent.bottom
            //anchors.left: parent.left
            TabView{
                id:tabView
                anchors.fill: parent
                Tab{
                    title:"Graph Editor"
                    Rectangle{
                        id:grEdiRect
                        color: "#494949"
                        Label{
                            id:nodeTitle
                            text:"Node Edit"
                            font.bold: true
                            font.family: "Liberation Mono"
                            font.pointSize: 12
                            color: "#070707"
                            anchors.top:parent.top
                            anchors.topMargin: 12
                        }

                        TextField{
                            id:nameOfNode
                            text: "node_4"
                            x:(parent.width-width)/2
                            anchors.top:nodeTitle.bottom
                            anchors.topMargin: 12
                        }
                        Button{
                            id:addNodeBut
                            text : "Add Node"
                            width: nameOfNode.width
                            anchors.horizontalCenter: nameOfNode.horizontalCenter
                            anchors.top : nameOfNode.bottom
                            anchors.topMargin: 12
                            onClicked: {
                                //console.log("index : "+graph.nodes.indexOf(nameOfNode.text));
                                var i,exists=false;
                                if(graph.nodes.length>0){
                                    for(i=0;i<graph.nodes.length;i++){//make it while()
                                        if(nameOfNode.text===graph.nodes[i].title){
                                            warning.visible=true;
                                            exists=true;
                                        }
                                    }
                                }
                                if(!exists){
                                    warning.visible=false
                                    var component = Qt.createComponent("Node.qml");
                                    var nodeX = component.createObject(graph,{"x":500,"y":500,"title":nameOfNode.text});
                                    if(nodeX===null){
                                        console.log("nodeX not created");
                                    }else{
                                        graph.nodes.push(nodeX);
                                        node1.addItem(nodeX.title).triggered.connect(function(){
                                            node1Button.text=nodeX.title
                                            node1Button.changed=true
                                        })
                                        node2.addItem(nodeX.title).triggered.connect(function(){
                                            node2Button.text=nodeX.title
                                            node2Button.changed=true
                                        })
                                    }
                                }
                            }
                        }
                        Label{
                            id:warning
                            color: "#FF0000"
                            text:"already exists ! kill urself !"
                            visible: false
                            anchors.horizontalCenter: addNodeBut.horizontalCenter
                            anchors.top : addNodeBut.bottom
                            anchors.topMargin: 12
                        }
                        //============================Edge Editor=========================
                        Label{
                            id:edgeEdit
                            text:"Edge Edit"
                            font.bold: true
                            font.family: "Liberation Mono"
                            font.pointSize: 12
                            color: "#070707"
                            anchors.top:warning.bottom
                            anchors.topMargin: 12
                        }
                        EdgeInfo{
                            id:edge1_2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top:edgeEdit.bottom
                            anchors.margins: 4
                            node_title_1: {graph.nodes[0].title}
                            node_title_2: {graph.nodes[1].title}
                            width:140
                            height: 40
                            onClicked: {
                                var i=0,found=false;
                                while(i<edges.edgesArr.length && found==false){
                                    console.log("Searching")
                                    if((edges.edgesArr[i].node_1==node_title_1 && edges.edgesArr[i].node_2==node_title_2) || (edges.edgesArr[i].node_2==node_title_1 && edges.edgesArr[i].node_1==node_title_2)){
                                        found=true
                                        console.log("Found")
                                    }else{
                                        i++
                                    }
                                }
                                console.log("Out of while")
                                if(found){
                                    console.log(edges.edgesArr[i].node_1+" + "+edges.edgesArr[i].node_2)
                                    edges.edgesArr[i].destroy()
                                    edges.edgesArr.splice(i,1)
                                    this.destroy()
                                }else{
                                    console.log("Not Found")
                                }
                            }
                        }
                        EdgeInfo{
                            id:edge1_3
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top:edge1_2.bottom
                            anchors.margins: 4
                            node_title_1: {graph.nodes[0].title}
                            node_title_2: {graph.nodes[2].title}
                            width:140
                            height: 40
                        }
                        property var lastItem:null
                        Component.onCompleted: {
                            lastItem=edge1_3
                        }
                        Item{
                            id:edgeAdder
                            anchors.top:edge1_3.bottom
                            anchors.topMargin: 4
                            Button{
                                id: node1Button
                                property string defText: "Node 1"
                                property bool changed: false
                                text: defText
                                x:grEdiRect.width/4-width/2
                                menu : Menu{
                                    id:node1
                                    MenuItem{
                                        text:"node_1"
                                        onTriggered: {
                                            node1Button.text=text
                                            node1Button.changed=true
                                        }
                                    }
                                    MenuItem{
                                        text:"node_2"
                                        onTriggered: {
                                            node1Button.text=text
                                            node1Button.changed=true
                                        }
                                    }
                                    MenuItem{
                                        text:"node_3"
                                        onTriggered: {
                                            node1Button.text=text
                                            node1Button.changed=true
                                        }
                                    }
                                }
                            }
                            Button{
                                id: node2Button
                                property string defText: "Node 2"
                                property bool changed: false
                                text: defText
                                anchors.top:node1Button.top
                                anchors.left: node1Button.right
                                menu : Menu{
                                    id:node2
                                    MenuItem{
                                        text:"node_1"
                                        onTriggered: {
                                            node2Button.text=text
                                            node2Button.changed=true
                                        }
                                    }
                                    MenuItem{
                                        text:"node_2"
                                        onTriggered: {
                                            node2Button.text=text
                                            node2Button.changed=true
                                        }
                                    }
                                    MenuItem{
                                        text:"node_3"
                                        onTriggered: {
                                            node2Button.text=text
                                            node2Button.changed=true
                                        }
                                    }
                                }
                            }
                            Button{
                                id:addEdgeBut
                                anchors.top:node2Button.top
                                anchors.left: node2Button.right
                                text: "+"
                                width: 35
                                onClicked: {
                                    var exists=false
                                    var i=0
                                    if(node1Button.changed && node2Button.changed){
                                        if(edges.edgesArr.length){
                                            for(i=0;i<edges.edgesArr.length;i++){//make it while()
                                                if((edges.edgesArr[i].node_1===node1Button.text && edges.edgesArr[i].node_2===node2Button.text) || (edges.edgesArr[i].node_1===node2Button.text && edges.edgesArr[i].node_2===node1Button.text)){
                                                    exists=true
                                                    //TODO : make warning exist msg
                                                    console.log("Edge Exists")
                                                }
                                            }
                                            if(!exists){
                                                //getting the nodes
                                                var node1Get,node2Get
                                                i=0
                                                while(graph.nodes[i].title!==node1Button.text){
                                                    i++;
                                                }
                                                node1Get=graph.nodes[i]
                                                var y=0
                                                while(graph.nodes[y].title!==node2Button.text){
                                                    y++;
                                                }
                                                node2Get=graph.nodes[y]
                                                var component = Qt.createComponent("PathDraw.qml");
                                                var edgeX = component.createObject(edges,{"lineWidth":6,
                                                                                       "lineColor":"#000000",
                                                                                       "node_1":node1Button.text,
                                                                                       "node_2":node2Button.text,
                                                                                       "point1x":Qt.binding(function() {return graph.nodes[i].x+(graph.nodes[i].width/2)}),
                                                                                       "point1y":Qt.binding(function() {return graph.nodes[i].y+(graph.nodes[i].height/2)}),
                                                                                       "point2x":Qt.binding(function() {return graph.nodes[y].x+(graph.nodes[y].width/2)}),
                                                                                       "point2y":Qt.binding(function() {return graph.nodes[y].y+(graph.nodes[y].height/2)})
                                                                                   });
                                                if(edgeX===null){
                                                    console.log("edgeX not created");
                                                }else{
                                                    edges.edgesArr.push(edgeX);
                                                }
                                                component = Qt.createComponent("EdgeInfo.qml")
                                                var edgeInfoX = component.createObject(grEdiRect,{
                                                                                           "anchors.horizontalCenter": lastItem.horizontalCenter,
                                                                                           "anchors.top":lastItem.bottom,
                                                                                           "anchors.margins": 4,
                                                                                           "node_title_1":Qt.binding(function() {return graph.nodes[i].title}),
                                                                                           "node_title_2": Qt.binding(function() {return graph.nodes[y].title}),
                                                                                           "width":140,
                                                                                           "height": 40
                                                                                       })
                                                if(edgeInfoX===null){
                                                    console.log("Khra not created")
                                                }else{
                                                    edgeAdder.anchors.top=edgeInfoX.bottom
                                                    lastItem=edgeInfoX
                                                }
                                            }

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Tab{
                    title:"Graph Operations"
                }
            }
        }
        Rectangle{
            id: workSpace
            property string backGrnd: "#272727"
            /*anchors.left:option.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right:parent.right*/
            color: backGrnd
            //width: 1000
            /*Edge{
            id:edg_1_2
            anchors.fill:parent
            x_pnt_1: node_1.x+(node_1.width/2)
            y_pnt_1: node_1.y+(node_1.height/2)
            x_pnt_2: node_2.x+(node_2.width/2)
            y_pnt_2: node_2.y+(node_2.height/2)
        }
        Edge{
            id:edg_1_3
            anchors.fill:parent
            x_pnt_1: node_1.x+(node_1.width/2)
            y_pnt_1: node_1.y+(node_1.height/2)
            x_pnt_2: node_3.x+(node_3.width/2)
            y_pnt_2: node_3.y+(node_3.height/2)
        }*/
            Item{
                id:edges
                property var edgesArr: [nodes_1_to_2,nodes_1_to_3];
                PathDraw{
                    id:nodes_1_to_2
                    lineWidth: 6
                    lineColor: "#000000"
                    node_1:node_1.title
                    node_2:node_2.title
                    point1x: node_1.x+(node_1.width/2)
                    point1y: node_1.y+(node_1.height/2)
                    point2x: node_2.x+(node_2.width/2)
                    point2y: node_2.y+(node_2.height/2)
                    //dottedAnimation: true
                }
                PathDraw{
                    id:nodes_1_to_3
                    lineWidth: 6
                    lineColor: "#000000"
                    node_1:node_1.title
                    node_2:node_3.title
                    point1x: node_1.x+(node_1.width/2)
                    point1y: node_1.y+(node_1.height/2)
                    point2x: node_3.x+(node_3.width/2)
                    point2y: node_3.y+(node_3.height/2)
                    //dottedAnimation: true
                }
            }
            /*Canvas {
            anchors.fill:parent
            onPaint:{
                var ctx=getContext("2d")
                //ctx.lineWidth=1
                ctx.strokeStyle = "red"
                ctx.beginPath()
                ctx.moveTo(node_1.x,node_1.y)
                ctx.lineTo(node_2.x,node_2.y)
                ctx.stroke()
                }
            }*/
            Item{
                id:graph
                property var nodes:[node_1,node_2,node_3];
                Node{
                    id:node_1
                    x:200
                    y:200
                    title: "node_1"
                    onXChanged:{
                        if(x<=0){
                            x=0
                        }
                    }
                    /*if(x>=parent.width-30){
                    x=parent.width-30
                }
                edg_1_2.ctx.lineWidth=10
                edg_1_2.ctx.strokeStyle = workSpace.back
                edg_1_2.ctx.stroke()
                edg_1_2.requestPaint()
            }
            onYChanged: {
                if(y<=0){
                    y=0
                }
                if(y>=parent.height-30){
                    y=parent.height-30
                }
                edg_1_2.ctx.lineWidth=10
                edg_1_2.ctx.strokeStyle = workSpace.back
                edg_1_2.ctx.stroke()
                edg_1_2.requestPaint()
            }*/
                }
                Node{
                    id:node_2
                    x:400
                    y:400
                    title: "node_2"
                    onXChanged:{
                        if(x<=0){
                            x=0
                            console.log("they see me rolling, they hating !"+x)
                        }
                    }
                    /*if(x>=parent.width-30){
                    x=parent.width-30
                }
                edg_1_2.ctx.lineWidth=10
                edg_1_2.ctx.strokeStyle = workSpace.back
                edg_1_2.ctx.stroke()
                edg_1_2.requestPaint()
            }
            onYChanged: {
                if(y<=0){
                    y=0
                }
                if(y>=parent.height-30){
                    y=parent.height-30
                }
                edg_1_2.ctx.lineWidth=10
                edg_1_2.ctx.strokeStyle = workSpace.back
                edg_1_2.ctx.stroke()
                edg_1_2.requestPaint()
            }*/
                }
                Node{
                    id:node_3
                    x:600
                    y:200
                    title: "node_3"
                    onXChanged:{
                        if(x<=0){
                            x=0
                        }
                    }
                    /*if(x>=parent.width-30){
                    x=parent.width-30
                }
                edg_1_3.ctx.lineWidth=10
                edg_1_3.ctx.strokeStyle = workSpace.back
                edg_1_3.ctx.stroke()
                edg_1_3.requestPaint()
            }
            onYChanged: {
                if(y<=0){
                    y=0
                }
                if(y>=parent.height-30){
                    y=parent.height-30
                }
                edg_1_3.ctx.lineWidth=10
                edg_1_3.ctx.strokeStyle = workSpace.back
                edg_1_3.ctx.stroke()
                edg_1_3.requestPaint()
            }*/
                }
            }
        }
    }
}
