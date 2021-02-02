import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import '../utils/mdicons.mjs' as MDIcons

Rectangle {
    id: root
    height: 60
    width: 250
    color: "transparent"

	property bool highlighted: false

    RowLayout{
        spacing: 5
        anchors.fill: parent
        anchors.margins: 8

        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 4

            Label{
                text: "Check List One"
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
				color: (highlighted) ? pallete.primary : "#000"
            }
            Label{
                text: "20 items, 5 checked."
				color: (highlighted) ? pallete.primary : "#bbb"
                Layout.fillWidth: true
            }
        }

        Icon{
            path: MDIcons.mdiStarOutline
            svgWidth: 18
			color: (highlighted) ? pallete.primary : "#bbb"
            svgHeight: 18

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
				cursorShape: Qt.PointingHandCursor
            }
        }
    }
}

/*##^##
Designer {
    D{i:6;anchors_height:100;anchors_width:100;anchors_x:23;anchors_y:-41}
}
##^##*/
