import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

Rectangle {
	id: root
	width: 200
	height: 40
	radius: 5

	property alias label: label
	property alias mousearea: mousearea

	property bool loading: false

	signal clicked()
	signal released()
	signal doubleClicked()
	signal hovered(bool state)

	transitions: [
		Transition {
			from: ""
			to: "hovered"

			ColorAnimation {
				easing.type: Easing.InQuad
				duration: 200
			}
		},

		Transition {
			from: ""
			to: "down"

			ColorAnimation {
				easing.type: Easing.InQuad
				duration: 100
			}
		}
	]

	MouseArea {
		id: mousearea
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		onEntered: {
			root.hovered(true);
			root.state = "hovered";
		}
		onExited: {
			root.hovered(false);
			root.state = "";
		}
		
		onClicked: {
			root.clicked();
		}

		onPressed: {
			root.state = "down";
		}
		onReleased: {
			root.released();
			root.state = "";
		}
		onDoubleClicked: root.doubleClicked()
	}

	Label{
		id: label
		visible: !root.loading
		anchors.centerIn: parent
		font.pixelSize: 12
	}

	Rectangle{
		width: 20
		height: 30
		color: "#00000000"
		anchors.centerIn: parent
		visible: root.loading

		Component.onCompleted: if(visible) anim.restart();
		
		onVisibleChanged: {
			if(visible) anim.restart();
			else anim.stop();
		}
		
		RowLayout {
			anchors.fill: parent
			
			Rectangle{
				id: bud
				radius: 2
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				Layout.preferredHeight: 4
				Layout.preferredWidth: 4
				color: label.color
				opacity: 0
			}
			
			Rectangle{
				id: bud_2
				radius: 2
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				Layout.preferredHeight: 4
				Layout.preferredWidth: 4
				color: label.color
				opacity: 0
			}
			
			Rectangle{
				id: bud_3
				radius: 2
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				Layout.preferredHeight: 4
				Layout.preferredWidth: 4
				color: label.color
				opacity: 1
			}
		}
		
		SequentialAnimation{
			id: anim
			loops: -1
			ParallelAnimation{
				NumberAnimation {
					target: bud
					easing.type: Easing.InQuad 
					properties: "opacity"
					duration: 300
					from: 0
					to: 1
				}
				
				NumberAnimation {
					target: bud_3
					property: "opacity"
					duration: 300
					easing.type: Easing.InQuad
					from: 1
					to: 0
				}
			}
			ParallelAnimation{
				NumberAnimation {
					target: bud_2
					easing.type: Easing.InQuad 
					properties: "opacity"
					duration: 300
					from: 0
					to: 1
				}
				
				NumberAnimation {
					target: bud
					property: "opacity"
					duration: 300
					easing.type: Easing.InQuad
					from: 1
					to: 0
				}	
			}
			ParallelAnimation{
				NumberAnimation {
					target: bud_3
					easing.type: Easing.InQuad 
					properties: "opacity"
					duration: 300
					from: 0
					to: 1
				}
				
				NumberAnimation {
					target: bud_2
					property: "opacity"
					duration: 300
					easing.type: Easing.InQuad
					from: 1
					to: 0
				}
			}
		}
		
	}
}
