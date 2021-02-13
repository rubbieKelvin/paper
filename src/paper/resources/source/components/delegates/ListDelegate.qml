import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

import "../../scripts/color.js" as ColorJS

Rectangle{
	id: root
	radius: 5
	border.width: 1
	width: 400
	height: (childrenRect.height)+20
	border.color: (new ColorJS.Color()).strokegray

	property alias model: list.model
	property alias spacing: list.spacing

	ListView{
		id: list
		x: 10
		y: 10
		model: ([
			{text: "hello", checked: true},
			{text: "world", checked: false},
		])
		height: contentHeight
		interactive: false
		boundsMovement: Flickable.StopAtBounds
		boundsBehavior: Flickable.StopAtBounds
		spacing: 10
		width: parent.width-20
		delegate: CheckDelegate {
			width: parent.width
			text: modelData.text
			font.pointSize: 13
			height: 28
			checkable: true
			checked: modelData.checked
		}
	}
}
