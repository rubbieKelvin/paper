import QtQuick 2.12
import QtQuick.Controls 2.12

ProgressBar {
	id: root
	property string color: "#000000"

	background: Rectangle{
		implicitHeight: 3
		implicitWidth: 200
		radius: 3
		color: root.color
		opacity: .2
	}

	contentItem: Item {
		implicitWidth: 200
		implicitHeight: 3

		Rectangle {
			width: root.visualPosition * parent.width
			height: parent.height
			radius: 3
			color: root.color
		}
	}
}
