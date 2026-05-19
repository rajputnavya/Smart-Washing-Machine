import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: rootId
    width: 300
    height: 400
    visible: true

    property alias setTime: scheduledTimeId.text

    signal confirmScheduleWashButtonClicked
    signal backButtonClicked

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
        spacing: 18

        Label{
            text: "Wash Starts"; font.pixelSize: 18; font.bold: false; color: "lightblue"
            leftPadding: 5
        }

        //Day and Time
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 1
            Label{
                text: Qt.formatDate(new Date(), "ddd") + ", ";
                font.pixelSize: 30; font.bold: false; color: "white"; font.family: "Arial"
                anchors.bottom: parent.bottom
            }
            Label{
                id: scheduledTimeId
                text: Qt.formatTime(new Date(), "h:mm")
                font.pixelSize: 30;
                font.bold: false; color: "white"; font.family: "Arial"
                anchors.bottom: parent.bottom
            }
            Label{
                text: Qt.formatTime(new Date(), "AP")
                font.pixelSize: 20
                font.bold: false; color: "white"; font.family: "Arial"
                anchors.bottom: parent.bottom
            }
        }

        //Confirm Schedule Wash Button
        Rectangle{
            id: outerRectConfirmButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
            height: width
            radius: width / 2
            color: "yellowgreen"
            gradient: Gradient{
                GradientStop{position: 0; color: "greenyellow"}
                GradientStop{position: 0.5; color: "yellowgreen"}
                GradientStop{position: 1; color: "green"}
            }

            //Glow of outer rectangle
            layer.enabled: true
            layer.effect: MultiEffect{
                shadowEnabled: true
                shadowBlur: 0.1
                shadowColor: "white"
                // shadowOpacity: 0.35 //0- transpant; 1-opaque (default)
            }

            Button{
                id: confirmScheduleWashButton
                anchors.centerIn: parent
                width: outerRectConfirmButton.width - 25
                height: width

                // Scale transform for press animation
                transform: Scale {
                   id: buttonScale
                   origin.x: confirmScheduleWashButton.width / 2
                   origin.y: confirmScheduleWashButton.height / 2
                   xScale: 1.0
                   yScale: 1.0
                }

                // States: normal vs pressed
                states: [ State {
                        name: "pressed"; when: confirmScheduleWashButton.pressed
                        PropertyChanges {target: buttonScale; xScale: 0.90; yScale: 0.90}
                    }
                ]

                // Smooth transition in and out
                transitions: [ Transition {
                        to: "pressed"
                        NumberAnimation {
                            targets: buttonScale;
                            properties: "xScale, yScale"
                            duration: 100
                            easing.type: Easing.InOutQuad
                        }
                    },
                    Transition {
                        from: "pressed"
                        NumberAnimation {
                            targets: buttonScale
                            properties: "xScale, yScale"
                            duration: 150
                            easing.type: Easing.OutBounce  // Slight bounce on release
                        }
                    }
                ]

                background: Rectangle{ //background of button
                    radius: width / 2
                    // color: "#1B262C" //ADD########################################################

                    gradient: Gradient{ //REMOVE#####################################################
                        orientation: Gradient.Vertical
                        GradientStop {position: 0.0; color: "#1B262C"}
                        GradientStop {position: 0.5; color: "#0F4C75"}
                        GradientStop {position: 1.0; color: "#1B262C"}
                    }

                    //Shadow Effect
                    layer.enabled: true
                    layer.effect: MultiEffect{
                        anchors.fill: parent
                        shadowEnabled: true
                        shadowColor: "black"
                        shadowBlur: 1
                        shadowVerticalOffset: 4 //move shadow downward
                        shadowHorizontalOffset: 0
                        // shadowOpacity: 1
                    }
                }
                contentItem: Label{
                    width: parent.width
                    text: "Confirm\nSchedule\nWash";
                    font.pixelSize: 25; font.bold: true; font.family: "Arial"
                    color: "yellowgreen"
                    horizontalAlignment: Text.AlignHCenter //centers the lines (need to set width of label)
                    verticalAlignment: Text.AlignVCenter

                    //Glow
                    layer.enabled: true
                    layer.effect: MultiEffect{
                        shadowEnabled: true
                        shadowBlur: 0.1 //0-sharp shadow, not blurrrr
                        shadowColor: "lightblue"
                        shadowOpacity: 0.3
                    }
                }
                onClicked: function(){
                    rootId.confirmScheduleWashButtonClicked() //emits signal
                }
            }
        }

        Button{
            id: backButton
            anchors.horizontalCenter: parent.horizontalCenter
            height: 40
            width: 150

            // Scale transform for press animation
            transform: Scale {
               id: backButtonScale
               origin.x: backButton.width / 2
               origin.y: backButton.height / 2
               xScale: 1.0
               yScale: 1.0
            }

            // States: normal vs pressed
            states: [ State {
                    name: "pressed"; when: backButton.pressed
                    PropertyChanges {target: backButtonScale; xScale: 0.90; yScale: 0.90}
                }
            ]

            // Smooth transition in and out
            transitions: [ Transition {
                    to: "pressed"
                    NumberAnimation {
                        targets: backButtonScale;
                        properties: "xScale, yScale"
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                },
                Transition {
                    from: "pressed"
                    NumberAnimation {
                        targets: backButtonScale
                        properties: "xScale, yScale"
                        duration: 150
                        easing.type: Easing.OutBounce  // Slight bounce on release
                    }
                }
            ]


            background: Rectangle{
                radius: 4
                // color: "steelblue"
                gradient: Gradient{
                    orientation: Gradient.Vertical
                    GradientStop {position: 0.0; color: "lightsteelblue"} //lightblue
                    GradientStop {position: 1.0; color: "steelblue"} //#3282B8
                }
            }
            contentItem: Label{
                text: "Back"
                font.pixelSize: 18; color: "white"; font.family: "Arial"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: {
                rootId.backButtonClicked() //emits signal
            }

        }

    }
}