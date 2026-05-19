import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: rootId
    width: 300
    height: 400
    visible: true

    // Current time properties
    property int currentHour: 0
    property int currentMinute: 0

    // Timer to update every minute
    Timer {
        id: clockTimer
        interval: 60000       // every 60 seconds
        repeat: true
        running: true
        triggeredOnStart: true   // fires immediately on start
        onTriggered: {
            var now = new Date()
            currentHour = now.getHours()
            currentMinute = now.getMinutes()
            electricityPricePlanDial.requestPaint()  // redraw the canvas
        }
    }

    //Background
    Rectangle{
        id: headerBackgroundId
        anchors.fill: parent
        color: "transparent"
        // border.color: "black"
        // border.width: 1
    }

    function degToRad(deg) {
        return deg * Math.PI / 180
    }

    Column{
        anchors.fill: parent
        anchors.margins: 12
        spacing: 6
        Label{
            text: "Electricity Price Plan"; font.pixelSize: 18; font.bold: false; color: "lightblue"
            leftPadding: 5
        }

        //Dial
        Item{
            width: parent.width
            height: parent.height - 80
            anchors.horizontalCenter: parent.horizontalCenter

            Canvas{ // create a drawable surface (drawing paper or blank board)
                id: electricityPricePlanDial
                // anchors.fill: parent
                anchors.centerIn: parent
                width: 300
                height: 300
                onPaint: {
                    var ctx = getContext("2d") //gets the drawing tool (painter brush or pen)(ctx = context)

                    ctx.reset() //clears previous drawing STATE (old drawings/settings may remain)
                    var cx = width / 2 //center coordinates (center of dial)
                    var cy = height / 2
                    // var radius = 100 //(makes big or small circles)
                    var outerRadius = 100

                    //Background circle
                    ctx.beginPath()
                    ctx.arc(cx, cy, outerRadius-1, 0, Math.PI * 2)
                    ctx.lineWidth = 5
                    ctx.strokeStyle = "transparent"
                    ctx.stroke()

                    //Green arc
                    ctx.beginPath() //creates a new shape/
                    var greenLineWidth = 25
                    ctx.lineWidth = greenLineWidth
                    var greenRadius = outerRadius - greenLineWidth / 2
                    ctx.arc(cx, cy, greenRadius, degToRad(194), degToRad(15), false) //ctx.arc(centerX, centerY,radius, startAngle,endAngle, bool anticlockwise) //By default clockwise 0 radian ->right side, pi->left side
                    var green_gradient = ctx.createRadialGradient(cx, cy, greenRadius-40, cx, cy, greenRadius) //x0,y0,r0 (inner circle radius),x1,y1,r1(outer circle radius) (Inner circle to outer circle)
                    green_gradient.addColorStop(0, "green") //0-start of gradient
                    green_gradient.addColorStop(1, "yellowgreen") //1-end of gradient
                    ctx.strokeStyle = green_gradient //border style
                    ctx.stroke() //draws the shape

                    //1st Blue arc
                    ctx.beginPath()
                    var blueLineWidth = 15
                    var blueRadius = outerRadius - blueLineWidth / 2
                    ctx.arc(cx, cy, blueRadius, degToRad(16), degToRad(76), false)
                    ctx.lineWidth = blueLineWidth
                    var blue_gradient = ctx.createRadialGradient(cx, cy, blueRadius-40, cx, cy, blueRadius)
                    blue_gradient.addColorStop(0, "blue")
                    blue_gradient.addColorStop(1, "#5080b0")
                    ctx.strokeStyle = blue_gradient
                    ctx.stroke()

                    //Red arc
                    ctx.beginPath()
                    var redLineWidth = 5
                    var redRadius = outerRadius - redLineWidth / 2
                    ctx.arc(cx, cy, redRadius, degToRad(77), degToRad(164), false)
                    ctx.lineWidth = redLineWidth
                    var red_gradient = ctx.createRadialGradient(cx, cy, redRadius-5, cx, cy, redRadius)
                    red_gradient.addColorStop(0, "red")
                    red_gradient.addColorStop(1, "#c03030")
                    ctx.strokeStyle = red_gradient
                    ctx.stroke()

                    //2nd Blue arc
                    ctx.beginPath()
                    ctx.arc(cx, cy, blueRadius, degToRad(165), degToRad(193), false)
                    ctx.lineWidth = blueLineWidth
                    blue_gradient.addColorStop(0, "blue")
                    blue_gradient.addColorStop(1, "#5080b0")
                    ctx.strokeStyle = blue_gradient
                    ctx.stroke()

                    // Numbers Draw
                    var textRadius = outerRadius + 15
                    for (var i = 1; i <= 24; i++) {
                        var angle = degToRad(i * 360 / 24 - 90) // -90 shifts start point to top instead of by deafult right
                        var tx = cx + Math.cos(angle) * textRadius //text positions
                        var ty = cy + Math.sin(angle) * textRadius

                        var label
                        var font = "10px arial"
                        var color = "white"
                        var offsetX = -5
                        var offsetY = +5

                        // Converting 13-23 into 1-11
                        if (i > 12) label = i - 12
                        else label = i

                        // Midnight and Noon Labels
                        if (i === 24) {
                            label = "Midnight"
                            font = "bold 12px arial"
                            color = "yellowgreen"
                            offsetX = -25
                            offsetY = -5
                        }
                        else if (i === 12) {
                            label = "Noon"
                            font = "bold 12px arial"
                            color = "yellowgreen"
                            offsetX = -15
                        }

                        // Highlighting important hrs
                        else if (i === 7 || i === 11 || i === 17 || i === 19) {
                            font = "bold 18px arial"
                            color = "yellowgreen"
                        }

                        //Rotated Numbers
                        ctx.save() //save current canvas state
                        ctx.translate(tx, ty) //move canvas origin to text position

                        // Apply text style
                        ctx.font = font
                        ctx.fillStyle = color
                        ctx.textAlign = "center"
                        ctx.textBaseline = "middle"
                        if (label === "Noon") {
                            ctx.fillText(label, 0, 10) //offsets appplying
                        }
                        else if (label === "Midnight") {
                            ctx.fillText(label, 0, -10)  //offsets appplying
                        }
                        else {
                            ctx.rotate(angle + Math.PI / 2)// Rotate all numbers according to angle //+90 makes text face outward nicely
                            ctx.fillText(label, 0, 0)
                        }
                        ctx.restore()
                    }

                    // Arrows
                    //Scheduled
                    var scheduledArrowAngle = degToRad(220) //connect to signal
                    var scheduledArrowRadius = outerRadius - 30
                    // Calculate arrow position
                    var ax = cx + Math.cos(scheduledArrowAngle) * scheduledArrowRadius
                    var ay = cy + Math.sin(scheduledArrowAngle) * scheduledArrowRadius
                    ctx.save()

                    // Move origin to arrow position
                    ctx.translate(ax, ay)
                    ctx.rotate(scheduledArrowAngle + Math.PI / 2)

                    ctx.strokeStyle = "white"
                    ctx.lineWidth = 1

                    ctx.beginPath()
                    ctx.moveTo(10, 0) //to move brush to a new coordinate
                    ctx.lineTo(10, 0); ctx.lineTo(20, 10); ctx.lineTo(10, 5); ctx.lineTo(0, 10)
                    ctx.fillStyle = "white"
                    ctx.fill()
                    ctx.stroke()
                    ctx.closePath()
                    ctx.restore()

                    //Current
                        // var arrowAngle = degToRad(300) //connect to signal
                    // Convert current time to dial angle
                    // Dial: 0h = top (-90 deg), 24h = full circle
                    // Each hour = 360/24 = 15 degrees
                    var totalMinutes = currentHour * 60 + currentMinute
                    var arrowAngle = degToRad((totalMinutes / (24 * 60)) * 360 - 90)
                    var arrowRadius = outerRadius - 30
                    // Calculate arrow position
                    var bx = cx + Math.cos(arrowAngle) * arrowRadius
                    var by = cy + Math.sin(arrowAngle) * arrowRadius
                    ctx.save()

                    // Move origin to arrow position
                    ctx.translate(bx, by)
                    ctx.rotate(arrowAngle + Math.PI / 2)

                    ctx.strokeStyle = "#5080b0"
                    ctx.lineWidth = 1

                    ctx.beginPath()
                    ctx.moveTo(10, 0) //to move brush to a new coordinate
                    ctx.lineTo(10, 0); ctx.lineTo(20, 10); ctx.lineTo(10, 5); ctx.lineTo(0, 10)
                    ctx.fillStyle = "#5080b0"
                    ctx.fill()
                    ctx.stroke()
                    ctx.closePath()
                    ctx.restore()
                }
            }
        }

        //Legend- Scheduled, Current Time
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0
            Row{
                spacing: 4
                leftPadding: 30
                Canvas{
                    width: 20
                    height: 10
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.reset()
                        ctx.strokeStyle = "white"
                        ctx.lineWidth = 1

                        ctx.beginPath()
                        ctx.moveTo(10, 0) //to move brush to a new coordinate
                        ctx.lineTo(10, 0); ctx.lineTo(20, 10); ctx.lineTo(10, 5); ctx.lineTo(0, 10)
                        ctx.closePath() //closes path
                        ctx.fillStyle = "white"
                        ctx.fill()
                        ctx.stroke() //render the drawing (//draws the shape)
                    }
                }
                Label { text: "Scheduled"; color: "white"; font.pixelSize: 12;}
            }
            Row{
                spacing: 4
                leftPadding: 30
                Canvas{
                    width: 20
                    height: 10
                    onPaint: {
                        var ctx = getContext("2d")

                        ctx.strokeStyle = "#5080b0"
                        ctx.lineWidth = 1

                        ctx.beginPath()
                        ctx.moveTo(10, 0) //to move brush to a new coordinate
                        ctx.lineTo(10, 0); ctx.lineTo(20, 10); ctx.lineTo(10, 5); ctx.lineTo(0, 10)
                        ctx.closePath()
                        ctx.fillStyle = "#5080b0"
                        ctx.fill()
                        ctx.stroke() //render the drawing
                    }
                }
                Label { text: "Current Time"; color: "#5080b0"; font.pixelSize: 12;}
            }
        }

        // Colour legend — Off/Mid/On-peak
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12
            topPadding: 2
            // leftPadding: 3

            Row {
                spacing: 4
                Rectangle { width: 15; height: 12; radius: 1;
                    anchors.verticalCenter: parent.verticalCenter
                    gradient: Gradient{
                        GradientStop{position: 0; color: "greenyellow"}
                        GradientStop{position: 1; color: "yellowgreen"}
                    }
                }
                Text { text: "Off-peak"; color: "yellowgreen"; font.pixelSize: 12;
                    anchors.verticalCenter: parent.verticalCenter }
            }
            Row {
                spacing: 4
                Rectangle { width: 15; height: 12; radius: 1;
                    anchors.verticalCenter: parent.verticalCenter
                    gradient: Gradient{
                        GradientStop{position: 0; color: "#5080b0"}
                        GradientStop{position: 1; color: "#0F4C75"}
                    }
                }
                Text { text: "Mid-peak"; color: "#5080b0"; font.pixelSize: 12;
                    anchors.verticalCenter: parent.verticalCenter }
            }
            Row {
                spacing: 4
                Rectangle { width: 15; height: 12; radius: 1;
                    anchors.verticalCenter: parent.verticalCenter
                    gradient: Gradient{
                        GradientStop{position: 0; color: "#c03030"}
                        GradientStop{position: 1; color: "red"}
                    }
                }
                Text { text: "On-peak"; color: "#c03030"; font.pixelSize: 12;
                    anchors.verticalCenter: parent.verticalCenter }
            }
        }
    }
}
