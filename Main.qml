import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Components

Window {
    width: 900
    height: 480
    visible: true
    title: qsTr("Smart Washing Machine")
    color: "#1a2a3a"

    /* Background Gradient Style
    Rectangle{
        id: backgroundId
        anchors.fill: parent
        gradient: Gradient{
            orientation: Gradient.Vertical
            GradientStop {position: 0.0; color: "#3282B8"}
            // GradientStop {position: 0.3; color: "#0F4C75"}
            GradientStop {position: 0.5; color: "#0F4C75"}
            GradientStop {position: 0.7; color: "#1B262C"}
            GradientStop {position: 1.0; color: "#1B262C"}
        }
        border.color: "black"
        border.width: 1
    }
    */

    GridLayout{
        anchors.fill: parent
        rows: 2
        columns: 5
        columnSpacing: 0
        rowSpacing: 0
        //Top Header Row
        HeaderBar{
            id: headerBarId
            Layout.fillWidth: parent
            Layout.fillHeight: parent
            Layout.columnSpan: 5
        }

        //Main content

        //Electricity Price Plane
        ElectricityPricePlan{
            Layout.fillWidth: parent
            Layout.fillHeight: parent
        }

        //Vertical Line
        Rectangle {
            id: verticalLineMainContent1
            Layout.preferredWidth: 1 // Thickness of the line
            Layout.fillHeight: true
            Layout.topMargin: 5
            Layout.bottomMargin: 5
            color: "steelblue"
            opacity: 0.5
        }


        // //Schedule Options
        ScheduleOptions{
            id: scheduleOptionsId
            Layout.fillWidth: parent
            Layout.fillHeight: parent

            onScheduleHourChanged: function(selectedHour){
                console.log("Schedule Hour Changed to: "+ selectedHour)
            }
            onScheduleMinuteChanged: function(selectedMinute){
                console.log("Schedule Minute Changed to: "+ selectedMinute)
            }
        }

        //Vertical Line
        Rectangle {
            id: verticalLineMainContent2
            Layout.preferredWidth: 1 // Thickness of the line
            Layout.fillHeight: true
            Layout.topMargin: 5
            Layout.bottomMargin: 5
            color: "steelblue"
            Layout.alignment: Qt.AlignVCenter
            // gradient: Gradient{
            //     orientation: Gradient.Vertical
            //     GradientStop {position: 0.0; color: "#1B262C"}
            //     GradientStop {position: 0.5; color: "#0F4C75"}
            //     GradientStop {position: 1.0; color: "#3282B8"}
            // }
            opacity: 0.5
        }

        // //Wash Starts
        WashStarts{
            id: washStartsId
            Layout.fillWidth: parent
            Layout.fillHeight: parent

            onConfirmScheduleWashButtonClicked: function(){
                console.log("Confirm Schedule Button Clicked")
                console.log("Scheduled Time is: ", scheduleOptionsId.selectedHour + ":" +
                            scheduleOptionsId.selectedMinute)

                // Display Scheduled Time in WashStarts Panel if selected option is "Manual Time" in Radio B
                if(scheduleOptionsId.selectedMode === "Manual Time"){
                    washStartsId.setTime = scheduleOptionsId.selectedHour + ":" +
                            scheduleOptionsId.selectedMinute
                }

                //Display wash time = Scheduled Time - Current Time
                headerBarId.washTime = 30
            }

            onBackButtonClicked: function(){
                console.log("Back Button Clicked")
                messageDialog.open()
            }
            Dialog {
                id: messageDialog
                title: "Warning!"
                anchors.centerIn: parent
                modal: true
                standardButtons: Dialog.Ok | Dialog.Cancel
                Label {
                    text: "Resetting Wash Schedule"
                    anchors.centerIn: parent
                }
                onAccepted: { //Resetting Washing Machine Scheduled Timings
                    //Set Display Time back to current time
                    washStartsId.setTime = "00:00"
                    //Set Tumbler Schedule Time to 00:00
                    scheduleOptionsId.resetTumblers() //calling function
                    //Reset Radio Buttons check
                    scheduleOptionsId.selectedMode = "Manual Time"

                    //Reset Savings, Wash Time and Cost to 0
                    scheduleOptionsId.savings = 0
                    headerBarId.estimatedCost = 0
                    headerBarId.washTime = 0
                }
                onRejected: {
                    console.log("Resetting Wash Schedule Canceled")
                }
            }
        }
    }


}
