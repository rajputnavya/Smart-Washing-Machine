import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic //Basic Style is fully customisable
import QtQuick.Effects //for glow effect

Item {
    id: rootId
    width: 300
    height: 400
    visible: true

    property alias selectedMode: groupBoxId.selectedMode //radio button selection
    property string selectedHour: hourTumbler.selectedHour //to set display time in WashStarts panel
    property string selectedMinute: hourTumbler.selectedMinute
    property alias savings: savingNumberId.text

    signal scheduleHourChanged(string selectedHour)
    signal scheduleMinuteChanged(string selectedMinute)

    function resetTumblers(){ //to reset tumbler values to 00:00 after clicking back button
        hourTumbler.currentIndex = 0
        minTumbler.currentIndex = 0
    }

    //Background
    Rectangle{
        id: headerBackgroundId
        anchors.fill: parent
        color: "transparent"
        // border.color: "black"
        // border.width: 1
    }

    Column{
        anchors.fill: parent
        anchors.margins: 12
        spacing: 6

        Label{
            text: "Schedule Options"; font.pixelSize: 18; font.bold: false; color: "lightblue"
            leftPadding: 5
        }

        GroupBox{
            id: groupBoxId
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle{
                color: "transparent"
            }
            property string selectedMode: "Manual Time" //which radio button checked (default value-Manual)

            // selectedOption
            Column{
                id: columnId
                anchors.fill: parent
                anchors.margins: 5
                spacing: 6
                MRadioButton{
                    id: earliestOffPeakRadioButtonId
                    text: "Earliest Off-peak"
                    onCheckedChanged: {
                        if (checked) {
                            selectedMode = text
                            console.log("Earliest Off-peak button checked")
                        }
                    }
                }
                MRadioButton{
                    id: earliestMidPeakRadioButtonId
                    text: "Earliest Mid-peak"
                    onCheckedChanged: {
                        if (checked) {
                            selectedMode = text
                            console.log("Earliest Mid-peak button checked")
                        }
                    }
                }
                MRadioButton{
                    id: manualRadioButtonId
                    text: "Manual Time"
                    checked: true
                    onCheckedChanged: {
                        if (checked) {
                            selectedMode = text
                            console.log("Manual Time button checked")
                        }
                    }
                }
            }
        }
        Label{
            text: "Saving"; font.pixelSize: 18; font.bold: false; color: "lightblue"
            leftPadding: 5
        }
        Row{
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter
            Label{
                text: "$"; font.pixelSize: 25; font.bold: false; color: "white"; font.family: "Arial"
                anchors.verticalCenter: parent.verticalCenter
            }
            Label{
                id: savingNumberId
                text: "2.78"; font.pixelSize: 35; font.bold: false; color: "white"; font.family: "Arial"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Label{
            text: "Time"; font.pixelSize: 18; font.bold: false; color: "lightblue"
            leftPadding: 5
        }

        // Time Tumbler
        Item{
            height: 100
            width: hourTumbler.width * 2 + 50   // 2 tumblers width + spacing
            anchors.horizontalCenter: parent.horizontalCenter

            // CENTER SELECTION BAR //placed above row to make it behind the tumbler and not on top
            Rectangle {
                id: selectionBar
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                // width: parent.width + 20
                height: parent.height / 3 - 5 //covers the middle row
                radius: 5
                y: parent.height / 3  // center row starts at 1/3 height
                z: 10
                border.color: "lightblue"
                border.width: 1
                gradient: Gradient {
                    GradientStop {position: 0.0; color: "#6644AAFF"}
                    GradientStop {position: 0.5; color: "#AAFFFFFF"}
                    GradientStop {position: 1.0; color: "#6644AAFF"}
                }
                opacity: 0.5
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                //Hour Tumbler
                MTumbler{
                    id: hourTumbler
                    model: 24
                    onCurrentIndexChanged: {
                        //converting currentIndex int to string for "hh" time style
                        selectedHour = currentIndex.toString().padStart(2, "0")
                        // console.log("Selected Hour:" + currentIndex)
                        rootId.scheduleHourChanged(selectedHour) //emits signal

                    }
                }
                //Minutes Tumbler
                MTumbler{
                    id: minTumbler
                    model: 60
                    onCurrentIndexChanged: {
                        ////converting currentIndex int to string for "mm" time style
                        selectedMinute = currentIndex.toString().padStart(2, "0")
                        // console.log("Selected Minutes:" + currentIndex)
                        rootId.scheduleMinuteChanged(selectedMinute) //emits signal
                    }
                }
            }
        }
    }
}