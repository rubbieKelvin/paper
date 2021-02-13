import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

import './scripts/color.js' as ColorJS
import './components/controls' as UiControls

Page{
	title: "auth"
	background: Rectangle{color:"transparent"}

	RowLayout{
		anchors.centerIn: parent
		spacing: 300

		Image{
			source: './assets/svg/logo-with-text.svg'
		}

		ColumnLayout{
			Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
			spacing: 20
			Layout.fillWidth: false
			Layout.preferredWidth: 250

			Label{
				text: "Login."
				font.pixelSize: 24
			}

			ColumnLayout{
				spacing: 15
				Layout.fillWidth: true
				Layout.fillHeight: true

				UiControls.UiTextField{
					placeholderText: "email address.."
					Layout.fillWidth: true
					Layout.preferredHeight: 40
					bgcolor: (new ColorJS.Color("11")).primary
					font.pixelSize: 12
				}

				UiControls.UiTextField{
					placeholderText: "password..."
					Layout.fillWidth: true
					Layout.preferredHeight: 40
					bgcolor: (new ColorJS.Color("11")).primary
					font.pixelSize: 12
				}

				UiControls.UiButton{
					id: login_button
					label.text: "login"
					label.color: (new ColorJS.Color()).textdark
					mousearea.hoverEnabled: true
					Layout.fillWidth: true
					Layout.preferredHeight: 40
					color: "#E0E0E0"
					states: [
						State {
							name: "hovered"
							PropertyChanges { target: login_button; color: (new ColorJS.Color()).primary }
							PropertyChanges { target: login_button.label; color: "#ffffff" }
						}
					]

					onClicked: application_stack.push("./home.qml");
				}
			}
		}
	}
}
