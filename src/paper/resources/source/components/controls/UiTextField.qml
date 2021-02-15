import QtQuick 2.12
import QtQuick.Controls 2.12


TextField {
	id: root
	property string bgcolor: "#000000"
	padding: 10
	
	background: Rectangle {
		implicitWidth: 200
		implicitHeight: 40
		color: root.bgcolor
		radius: 5
	}
}
