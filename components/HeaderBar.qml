import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: rootId
    width: 900
    height: 85
    visible: true

    property alias estimatedCost: estimatedCostNumber.text
    property alias washTime: washTimeNumber.text

    //Background
    Rectangle{
        id: headerBackgroundId
        anchors.fill: parent
        gradient: Gradient{
            orientation: Gradient.Vertical
            GradientStop {position: 0.0; color: "#3282B8"}
            GradientStop {position: 0.5; color: "#0F4C75"}
            GradientStop {position: 1.0; color: "#1B262C"}
        }
        border.color: "black"
        border.width: 1
    }

    RowLayout{
        anchors.fill: parent
        spacing: 0

        //Smart Energy
        Rectangle{
            id: smartEnergyOuterGreenRect
            Layout.preferredWidth: 140
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 6
            Layout.topMargin: 6
            Layout.bottomMargin: 6
            radius: 10 //curved corners
            bottomRightRadius: 0 //bottom right corner
            gradient: Gradient{
                orientation: Gradient.Vertical
                GradientStop {position: 0.0; color: "greenyellow"}
                GradientStop {position: 0.5; color: "yellowgreen"}
                GradientStop {position: 1.0; color: "green"}
            }

            Rectangle{
                id: smartEnergyInnerRect
                anchors.centerIn: parent
                height: parent.height - 10
                width: parent.width - 10
                radius: 10 //curved corners
                gradient: Gradient{
                    orientation: Gradient.Vertical
                    GradientStop {position: 0.0; color: "#3282B8"}
                    GradientStop {position: 0.5; color: "#0F4C75"}
                    GradientStop {position: 1.0; color: "#1B262C"}
                }
                //TreeIcon Add

                Image{
                    id:smartEnergy
                    anchors.left: parent.left
                    // anchors.bottom: parent.bottom
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/Components/images/smartEnergy.svg" //Components -> Module name
                    smooth: true
                    sourceSize.width: 50
                    sourceSize.height: 50
                    // width: 70
                    onStatusChanged: { // Optional
                        if (status === Image.Error)
                            console.log(" Image failed to load:", source)
                        else if (status === Image.Ready)
                            console.log("Image loaded OK:", source)
                    }
                }

                Label{
                    id: smartEnergyLabel
                    text: "Smart\nEnergy"
                    font{pixelSize: 20; bold: true}
                    color: "yellowgreen"
                    anchors{
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: 10
                    }
                }

                //2 Digit on Smart Badge
                Rectangle{
                    id: two
                    color: "yellowgreen"
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: -10
                    anchors.rightMargin: -15
                    width: 30; height: 30; radius: 15
                    Label {
                        anchors.centerIn: parent
                        text: "2"; font.pixelSize: 20; font.bold: true; color: "white"
                    }
                    gradient: Gradient{
                        orientation: Gradient.Vertical
                        GradientStop {position: 0.0; color: "greenyellow"}
                        GradientStop {position: 0.5; color: "yellowgreen"}
                        GradientStop {position: 1.0; color: "green"}
                    }
                }
            }
        }

        //Eco Rating
        Rectangle{
            id: ecoRatingRect
            Layout.preferredWidth: 80
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 5
            Layout.topMargin: 6
            Layout.bottomMargin: 6
            Layout.rightMargin: 25
            color: "transparent"
            Label{
                id: ecoRatingLabel
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 5
                text: "Eco Rating"; font.pixelSize: 15; font.bold: false; color: "lightblue"
            }

            Image{
                id:blueLeaf
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                // anchors.top: ecoRatingLabel.bottom
                fillMode: Image.PreserveAspectFit
                source: "qrc:/Components/images/blueLeaf.svg" //Components -> Module name
                smooth: true
                sourceSize.height: 30
                sourceSize.width: 30
                onStatusChanged: { // Optional
                    if (status === Image.Error)
                        console.log(" Image failed to load:", source)
                    else if (status === Image.Ready)
                        console.log("Image loaded OK:", source)
                }
            }
            Image{
                id:blueLeaf2
                anchors.left: blueLeaf.right
                anchors.bottom: parent.bottom
                // anchors.top: ecoRatingLabel.bottom
                fillMode: Image.PreserveAspectFit
                source: "qrc:/Components/images/blueLeaf.svg" //Components -> Module name
                smooth: true
                sourceSize.height: 40
                sourceSize.width: 40
                onStatusChanged: { // Optional
                    if (status === Image.Error)
                        console.log(" Image failed to load:", source)
                    else if (status === Image.Ready)
                        console.log("Image loaded OK:", source)
                }
            }
            Image{
                id:grayLeaf
                anchors.left: blueLeaf2.right
                anchors.bottom: parent.bottom
                // anchors.top: ecoRatingLabel.bottom
                fillMode: Image.PreserveAspectFit
                source: "qrc:/Components/images/grayLeaf.svg" //Components -> Module name
                smooth: true
                sourceSize.height: 50
                sourceSize.width: 50
                onStatusChanged: { // Optional
                    if (status === Image.Error)
                        console.log(" Image failed to load:", source)
                    else if (status === Image.Ready)
                        console.log("Image loaded OK:", source)
                }
            }
        }

        //Vertical Line
        Rectangle {
            id: verticalLine
            Layout.preferredWidth: 1 // Thickness of the line
            Layout.fillHeight: true
            Layout.topMargin: 5
            Layout.bottomMargin: 5
            color: "lightblue"
            Layout.alignment: Qt.AlignVCenter
            gradient: Gradient{
                orientation: Gradient.Vertical
                GradientStop {position: 0.0; color: "#1B262C"}
                GradientStop {position: 0.5; color: "#0F4C75"}
                GradientStop {position: 1.0; color: "#3282B8"}
            }

        }

        //Estimated Cost
        Rectangle{
            id: estimatedCostRect
            Layout.preferredWidth: 170
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 10
            Layout.topMargin: 6
            Layout.bottomMargin: 6
            color: "transparent"

            Image{
                id:money
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.right: estimatedCostLabel.left
                anchors.rightMargin: 5
                // anchors.verticalCenter: parent.verticalCenter
                // anchors.top: estimatedCostLabel.bottom
                // anchors.topMargin: 20
                fillMode: Image.PreserveAspectFit
                source: "qrc:/Components/images/money1.svg" //Components -> Module name
                smooth: true
                sourceSize.height: 60
                sourceSize.width: 60
                onStatusChanged: { // Optional
                    if (status === Image.Error)
                        console.log(" Image failed to load:", source)
                    else if (status === Image.Ready)
                        console.log("Image loaded OK:", source)
                }
            }

            Label{
                id: estimatedCostLabel
                anchors.top: parent.top
                anchors.right: parent.right
                // anchors.rightMargin: 3
                anchors.topMargin: 5
                text: "Estimated Cost"; font.pixelSize: 15; font.bold: false; color: "lightblue"
            }
            Label{
                text: "$"; font.pixelSize: 20; font.bold: false; color: "white"
                anchors.bottom: estimatedCostRect.bottom
                anchors.right: estimatedCostNumber.left
                anchors.bottomMargin: 5
                anchors.rightMargin: 3
            }
            Label{
                id: estimatedCostNumber
                text: "5.2"; font.pixelSize: 35; font.bold: false; color: "white"
                anchors.bottom: estimatedCostRect.bottom
                anchors.right: parent.right
            }
        }

        //Wash Time
        Rectangle{
            id: washTimeRect
            Layout.preferredWidth: 150
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 6
            Layout.topMargin: 6
            Layout.bottomMargin: 6
            color: "transparent"

            Image{
                id:hourGlass
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                fillMode: Image.PreserveAspectFit
                source: "qrc:/Components/images/hourglass.svg" //Components -> Module name
                smooth: true
                height: 60
                // width: 70
                onStatusChanged: { // Optional
                    if (status === Image.Error)
                        console.log(" Image failed to load:", source)
                    else if (status === Image.Ready)
                        console.log("Image loaded OK:", source)
                }
            }


            Label{
                id: washTimeLabel
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 3
                anchors.topMargin: 5
                text: "Wash Time"; font.pixelSize: 15; font.bold: false; color: "lightblue"
            }
            Label{
                id: washTimeNumber
                text: "30"; font.pixelSize: 35; font.bold: false; color: "white"
                anchors.bottom: washTimeRect.bottom
                anchors.right: washTimeMinLabel.left
            }
            Label{
                id: washTimeMinLabel
                text: "Min"; font.pixelSize: 20; font.bold: false; color: "white"
                anchors.bottom: washTimeRect.bottom
                anchors.right: parent.right
                anchors.leftMargin: 5
                anchors.rightMargin: 3
                anchors.bottomMargin: 5
            }
        }
    }
}
