import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

import "../" as UiComponents

Rectangle {
	id: root
	width: 200
	height: 30
	color: "transparent"

	property alias icon: icon
	property alias label: label
	property bool hovered: false

	signal clicked()

	RowLayout{
		anchors.margins: 5
		anchors.fill: parent
		spacing: 5

		UiComponents.Icon{
			id: icon
			svgHeight: 24
			svgWidth: 24
			color: "white"

			Layout.fillHeight: true
			Layout.preferredWidth: 24
			Layout.preferredHeight: 24
		}

		Label{
			id: label
			text: "Label"
			font.capitalization: Font.Capitalize
			font.pixelSize: 12
			verticalAlignment: Text.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
		}
	}

	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		hoverEnabled: true
		onClicked: root.clicked();
		onEntered: root.hovered = true;
		onExited: root.hovered = false;
	}
}
