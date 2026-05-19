import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    height: pickerContainer.height
    width: pickerContainer.width

    //Exposing model and current index for signals
    property alias model : tumblerId.model
    property alias currentIndex: tumblerId.currentIndex
    property alias tumblerHeight: pickerContainer.height
    // property alias tumblerText: textId.text

    Rectangle{
        id: pickerContainer
        anchors.horizontalCenter: parent.horizontalCenter
        width: 33
        height: 100
        radius: 5
        color: "black"
        border.color: "black"
        border.width: 1

        //Outer Glow of outer rectangle
        layer.enabled: true
        layer.effect: MultiEffect{
        shadowEnabled: true
        shadowBlur: 0.1
        shadowColor: "gray"
        shadowOpacity: 0.35 //0- transpant; 1-opaque (default)
        }

        gradient: Gradient{
            // orientation: LinearGradient
            GradientStop{position: 0; color: "black"}
            GradientStop{position: 0.2; color: "black"}
            GradientStop{position: 0.5; color: "gray"}
            GradientStop{position: 0.8; color: "black"}
            GradientStop{position: 1; color: "black"}
        }

        Tumbler{
            id: tumblerId
            // model: 24 //24 hrs
            height: pickerContainer.height
            width: pickerContainer.width
            visibleItemCount: 3
            wrap: true //?????????????

            delegate: Item{ //?????????????????
                required property int index
                required property var modelData

                width: tumblerId.width
                height: 36 //????????????
                property real displacement: Math.abs(Tumbler.displacement)

                Text {
                    id: textId
                    anchors.centerIn: parent
                    text: modelData.toString().padStart(2, "0")
                    font.family: "Arial"
                    font.pixelSize: displacement < 0.1 ? 24 : 19
                    font.bold: true
                    color: "white"
                    scale: displacement < 0.1 ? 1 : 0.78 //??????????/
                    opacity: displacement < 0.1 ? 1 : 0.6

                    // SMOOTH TRANSITIONS
                    Behavior on scale {
                        NumberAnimation {duration: 120}
                    }
                    Behavior on opacity {
                        NumberAnimation {duration: 120}
                    }
                    Behavior on font.pixelSize {
                        NumberAnimation {duration: 120}
                    }
                    // GLOW FOR SELECTED ITEM
                    layer.enabled: displacement < 0.1 //seelcted item
                    layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowBlur: 1.0
                    shadowColor: "lightblue"
                    shadowOpacity: 10
                    }
                }
            }
        }
    }
}
