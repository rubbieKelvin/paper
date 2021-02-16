import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

import '../' as UiComponents
import '../../scripts/apisdk.js' as ApiSDK
import '../../scripts/mdicons.mjs' as MDIcons

Item {
	id: root
	width: 250
	height: 50
	clip: true

	property alias label: label
	property alias about: about
	property bool favourite: false
	property int checkbook_id

	ColumnLayout{
		spacing: 5
		anchors.fill: parent
		anchors.margins: 5

		RowLayout{
			Layout.preferredHeight: 24
			Layout.fillWidth: true
			Layout.fillHeight: false
			spacing: 5

			Rectangle{
				width: 10
				height: 10
				color: "red"
				radius: 5
			}

			Label{
				id: label
				Layout.fillHeight: true
				Layout.fillWidth: true
				text: "Note Title"
				verticalAlignment: Text.AlignVCenter
				font.pixelSize: 12
			}

			Item {
				Layout.preferredHeight: 30
				Layout.preferredWidth: 30

				RoundButton {
					id: like_button
					anchors.fill: parent
					icon.source: like_icon.source
					display: AbstractButton.IconOnly
					flat: true
					background: Rectangle{
						radius: 15
						implicitHeight: 30
						implicitWidth: 30
						color: parent.down ? "#9B9B9B" : "transparent"
					}

					onClicked: {
						like_button.visible = false;
						like_processing_indicator.visible = true;

						const token = encryptedStorage.read(constants.token_filename);
						const xhr = ApiSDK.editCheckbook(checkbook_id, null, !favourite, token.auth_token);

						xhr.onload = function () {
							const status = xhr.status;
							const response = xhr.response;

							if (status === 200){
								root.favourite = response.starred;
								like_icon.setPath((root.favourite) ? MDIcons.mdiHeart : MDIcons.mdiHeartOutline);
							}

							like_button.visible = true;
							like_processing_indicator.visible = false;
						}

						xhr.onerror = function () {
							like_button.visible = true;
							like_processing_indicator.visible = false;
						}
					}

					UiComponents.Icon{
						id: like_icon
						visible: false
						enabled: false
						svgHeight: 30
						svgWidth: 30
						path: (favourite) ? MDIcons.mdiHeart : MDIcons.mdiHeartOutline
					}
				}

				BusyIndicator{
					id: like_processing_indicator
					anchors.fill: parent
					running: visible
					visible: false
				}
			}
		}

		Label{
			id: about
			text: "UI first iteration for Cloud Rapidity, a note-taking app integrating with... UI first iteration for Cloud Rapidity, a note-taking app integrating with..."
			wrapMode: Text.WordWrap
			Layout.fillHeight: true
			Layout.fillWidth: true
			
		}
	}
}
