import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import QtQuick.Window 2.12

Window{
	id: application

	// visibility
	visible: true

	// geom
	width: 700
	height: 500

	// constraints
	minimumWidth: 350
	minimumHeight: 600

	// custom properties
	readonly property string base_url: "http://localhost:8080"

	StackView{
		id: application_stack
		initialItem: "./auth.qml"
		anchors.fill: parent
	}

}