import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

// python classes
import Lib 1.0

Page{
	id: root
	title: "Signup"

	ColumnLayout{
		spacing: 5
		anchors.centerIn: parent

		ColumnLayout{
			Layout.fillWidth: true
			Layout.fillHeight: true

			Label{
				text: "Email"
				Layout.fillWidth: true
			}

			TextField{
				id: email
				placeholderText: "email address..."
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
		}

		ColumnLayout{
			Layout.fillWidth: true
			Layout.fillHeight: true

			Label{
				text: "email"
				Layout.fillWidth: true
			}

			TextField{
				id: password
				placeholderText: "password..."
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
		}

		Button{
			text: "Login"
			Layout.fillWidth: true
			onClicked: {
				login_request.call()
			}
		}
	}
}