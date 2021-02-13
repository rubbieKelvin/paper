import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

import "../../scripts/color.js" as ColorJS

Rectangle{
	id: root
	radius: 5
	width: 320
	border.width: 1
	height: (childrenRect.height)+20
	border.color: (new ColorJS.Color()).strokegray

	property alias text: label.text

	Label{
		id: label
		x: 10
		y: 10
		font.pixelSize: 14
		width: root.width-20
		text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
		wrapMode: Text.WordWrap
	}
}


