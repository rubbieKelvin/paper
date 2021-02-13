import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

import "../scripts/color.js" as ColorJS

Page{
	id: root

	// TODO: remove the geom.
	width: 1000
	height: 700


	Item {
		id: element
		width: parent.width
		height: 60

		RowLayout {
			id: rowLayout
			anchors.rightMargin: 20
			anchors.leftMargin: 20
			anchors.fill: parent

			Label {
				id: label
				text: qsTr("Label")
				font.weight: Font.Medium
				font.pixelSize: 24
				verticalAlignment: Text.AlignVCenter
				Layout.fillHeight: true
				Layout.fillWidth: true
			}
		}
	}


	ScrollView {
		id: scrollView
		clip: true
		anchors.rightMargin: 20
		anchors.leftMargin: 20
		anchors.top: element.bottom
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.topMargin: 0

  ListView {
	  id: listView
	  clip: true
	  anchors.fill: parent
	  model: ListModel {
		  ListElement {
			  name: "Grey"
			  colorCode: "grey"
		  }

		  ListElement {
			  name: "Red"
			  colorCode: "red"
		  }

		  ListElement {
			  name: "Blue"
			  colorCode: "blue"
		  }

		  ListElement {
			  name: "Green"
			  colorCode: "green"
		  }
	  }
	  delegate: Item {
		  x: 5
		  width: 80
		  height: 40
		  Row {
			  id: row1
			  spacing: 10
			  Rectangle {
				  width: 40
				  height: 40
				  color: colorCode
			  }

			  Text {
				  text: name
				  anchors.verticalCenter: parent.verticalCenter
				  font.bold: true
			  }
		  }
	  }
  }
 }
	RoundButton{
		id: add_to_checkbook_fab
		text: "+"
		font.pixelSize: 14
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.margins: 20
		background: Rectangle{
			implicitHeight: 40
			implicitWidth: 40
			radius: 999
			color: (new ColorJS.Color()).primary
		}
		contentItem: Text {
			text: add_to_checkbook_fab.text
			font: add_to_checkbook_fab.font
			opacity: enabled ? 1.0 : 0.3
			color: add_to_checkbook_fab.down ? "#3a3a3a" : "#ffffff"
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			elide: Text.ElideRight
		}
	}
}
/*##^##
Designer {
	D{i:0;formeditorZoom:0.5}D{i:2;anchors_height:100;anchors_width:100;anchors_x:70;anchors_y:18}
D{i:5;anchors_height:160;anchors_width:110}D{i:4;anchors_height:200;anchors_width:200}
}
##^##*/
