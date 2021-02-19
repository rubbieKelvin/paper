import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

import "../../scripts/color.js" as ColorJS
import "../../scripts/mdicons.mjs" as MDIcons
import "../" as UiComponents

Rectangle {
	id: root
	height: 60
	color: "white"
	radius: 5
	border.width: 1
	border.color: (new ColorJS.Color()).strokegray

	RowLayout{
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		anchors.top: parent.top
		anchors.margins: 10

		RoundButton{
			text: ">"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
		}

		ColumnLayout{
			Layout.fillHeight: true
			Layout.fillWidth: true

			RowLayout{
				Layout.fillHeight: true
				Layout.fillWidth: true

				Label{
					Layout.fillHeight: true
					Layout.fillWidth: true
					text: "Audio name"
					font.pixelSize: 12
					verticalAlignment: Text.AlignVCenter
				}

				Label{
					Layout.fillHeight: true
					text: "12:00/24:09"
					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignRight
					Layout.fillWidth: true
				}
			}

			Slider{
				Layout.fillHeight: true
				from: 0
				to: 100
				value: 0
				Layout.fillWidth: true
			}
		}
	}
}
