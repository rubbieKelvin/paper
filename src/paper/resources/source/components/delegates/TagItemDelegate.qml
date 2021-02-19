import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

import "../" as UiComponents
import "../../scripts/color.js" as ColorJS
import "../../scripts/apisdk.js" as ApiSDK
import "../../scripts/mdicons.mjs" as MDIcons

Rectangle{
	id: root
	width: 200
	height: 40

	property alias label: label
	property int tag_id

	signal removedFromDB()

	RowLayout{
		anchors.fill: parent
		anchors.margins: 5

		Label{
			id: label
			text: "Hello"
			font.pixelSize: 14
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignHLeft | Qt.AlignVCenter
			verticalAlignment: Text.AlignVCenter
		}

		Item{
			Layout.preferredHeight: 30
			Layout.preferredWidth: 30

			RoundButton {
				id: button
				icon.source: close_icon__.source
				display: AbstractButton.IconOnly
				flat: true
				visible: true
				enabled: visible
				anchors.fill: parent
				background: Rectangle{
					radius: 15
					implicitHeight: 30
					implicitWidth: 30
					color: (parent.down) ? (new ColorJS.Color()).strokegray : "transparent"
				}

				UiComponents.Icon{
					id: close_icon__
					visible: false
					enabled: false
					svgHeight: 30
					svgWidth: 30
					color: (new ColorJS.Color()).textdark
					path: MDIcons.mdiClose
				}

				onClicked: {
					this.visible = false;

					const token = encryptedStorage.read(constants.token_filename);

					if (token) {
						const xhr = ApiSDK.deleteTag(tag_id, token.auth_token);

						xhr.onload = function () {
							const status = xhr.status;

							if (status === 204) {
								root.removedFromDB();
							}

							button.visible = true;
						}

						xhr.onerror = function () {
							button.visible = true;
						}

					}else{
						application.logoutAndGoAuth();
					}
				}
			}

			BusyIndicator{
				id: busy_indicator
				anchors.fill: parent
				visible: ! button.visible
				running: visible
			}
		}
	}
}