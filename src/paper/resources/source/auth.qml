import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

Page{
	title: "auth"
	
	ColumnLayout{
		spacing: 5
		anchors.centerIn: parent

		Label{
			text: qsTr("Paper")
		}

		RowLayout{
			spacing: 5
			Layout.fillWidth: true
			Layout.fillHeight: true

			Button{
				text: qsTr("Login")
				Layout.fillWidth: true
				onClicked: application_stack.push("./login.qml")
			}

			Button{
				text: qsTr("Signup")
				Layout.fillWidth: true
			}
		}
	}

}