import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

import "../scripts/color.js" as ColorJS
import "../components/" as UiComponents
import "../scripts/mdicons.mjs" as MDIcons

Page{
	id: page
	title: "task"
	background: Rectangle {color: (new ColorJS.Color()).primary}
	width: 180
	height: 700

	RowLayout {
		id: rowLayout
		x: 19
		y: 16
		width: 160
		height: 30
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 3

		UiComponents.RoundImage {
			id: image
			Layout.preferredWidth: 24
			Layout.preferredHeight: 24
			Layout.fillWidth: false
			Layout.fillHeight: true
			source: "../assets/png/dummy_dp.png"
			fillMode: Image.PreserveAspectFit
		}

		Label {
			id: label
			text: qsTr("Label")
			clip: true
			font.pixelSize: 12
			verticalAlignment: Text.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
		}

		RoundButton {
			id: refreshButton
			flat: true
			icon.source: refresh_icon.source
			highlighted: false
			display: AbstractButton.IconOnly
			Layout.preferredHeight: 20
			Layout.preferredWidth: 20

			UiComponents.Icon{
				id: refresh_icon
				visible: false
				enabled: false
				svgHeight: 20
				svgWidth: 20
				path: MDIcons.mdiSync
			}
		}
	}

	ListView {
		id: menu_list
		x: 10
		width: 160
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 0
		anchors.top: rowLayout.bottom
		anchors.topMargin: 6
		anchors.horizontalCenter: parent.horizontalCenter
		model: []
		delegate: Item {}
	}
}

/*##^##
Designer {
	D{i:0;formeditorZoom:1.5}D{i:6;anchors_height:160;anchors_y:52}
}
##^##*/
