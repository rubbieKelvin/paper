import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

import '../../scripts/mdicons.mjs' as MDIcons
import '../' as UiComponents

Item {
	width: 250
	height: 50
	clip: true

	property alias label: label
	property alias about: about
	property bool favourite: false

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

			RoundButton {
				id: like_button
				icon.source: like_icon.source
				display: AbstractButton.IconOnly
				Layout.preferredHeight: 24
				Layout.preferredWidth: 24
				flat: true
				background: Rectangle{
					radius: 15
					implicitHeight: 30
					implicitWidth: 30
					color: "transparent"
				}

				UiComponents.Icon{
					id: like_icon
					visible: false
					enabled: false
					svgHeight: 20
					svgWidth: 20
					path: (favourite) ? MDIcons.mdiHeart : MDIcons.mdiHeartOutline
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
