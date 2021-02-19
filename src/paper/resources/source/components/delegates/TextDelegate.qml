import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

import "../../components/" as UiComponents
import "../../scripts/color.js" as ColorJS
import "../../scripts/apisdk.js" as ApiSDK
import "../../scripts/mdicons.mjs" as MDIcons

Rectangle{
	id: root
	radius: 5
	width: 320
	border.width: 1
	height: (editing) ? __.height+20 : _.height+20
	border.color: (new ColorJS.Color()).strokegray

	property alias text: label.text
	property alias title: title.text
	property bool editing: false
	property bool sending: false
	property bool senderror: false
	property variant modeldata: ({})

	function saveItem() {
		const token = encryptedStorage.read(constants.token_filename);
		
		root.sending = true;
		root.senderror = false;

		if (token){
			const checkbook_id = modeldata.checkbook;
			const textitem_id  = modeldata.id;
			const title_text   = title.text;
			const content_text = label.text;
			const xhr = ApiSDK.editTextitem(checkbook_id, textitem_id, title_text, content_text, token.auth_token);
			
			xhr.onload = function () {
				const response = xhr.response;
				const status = xhr.status;

				if (status === 200){
					root.modeldata = response;

					root.senderror = false;
					root.sending = false;
				}else{
					console.log(JSON.stringify(response));
					root.sending = false;
					root.senderror = true;
				}
			};

			xhr.onerror = function () {
				root.sending = false;
				root.senderror = true;
			};

		}else{
			root.senderror = true;
			root.sending = false;
			application.logoutAndGoAuth();
		}
	}

	onEditingChanged: {
		if (editing) {
			title_edit.text = title.text;
			label_edit.text = label.text;
		}else{
			
		}
	}

	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		hoverEnabled: false
		enabled: ! editing
		visible: ! editing
		onClicked: root.editing = true
	}

	ColumnLayout{
		id: _
		// height: childrenRect.height
		width: root.width - 20
		visible: ! editing
		x: 10
		y: 10

		RowLayout{
			Layout.fillWidth: true

			Label{
				id: title
				Layout.fillWidth: true
				text: "True"
				font.pixelSize: 16
				font.weight: Font.Bold
			}

			BusyIndicator{
				Layout.preferredHeight: 28
				Layout.preferredWidth: 28
				running: visible
				enabled: visible
				visible: sending
			}

			RoundButton{
				Layout.preferredHeight: 30
				Layout.preferredWidth: 30
				icon.source: __icon_refresh.source
				flat: true
				enabled: visible
				visible: senderror
				onClicked: root.saveItem()

				UiComponents.Icon{
					id: __icon_refresh
					path: MDIcons.mdiRefresh
					svgHeight: 30
					svgWidth: 30
					visible: false
				}
			}
		}

		Label{
			id: label
			Layout.fillWidth: true
			Layout.fillHeight: true
			font.pixelSize: 14
			text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
			width: root.width-20
			wrapMode: Text.WordWrap
		}
	}

	ColumnLayout{
		id: __
		x: 10
		y: 10
		// height: childrenRect.height
		width: root.width - 20
		visible: editing

		TextField {
			id: title_edit
			Layout.fillWidth: true
			font.pixelSize: 16
			placeholderText: "Enter Title"
			font.weight: Font.Bold
		}

		TextArea {
			id: label_edit
			wrapMode: Text.WrapAnywhere
			placeholderText: "Enter Description"
			Layout.fillWidth: true
			Layout.fillHeight: true
			font.pixelSize: 14
		}

		RowLayout{
			Layout.fillWidth: true
			
			Button {
				Layout.fillWidth: true
				text: "Cancel"
				onClicked: root.editing = false
			}

			Button {
				Layout.fillWidth: true
				text: "Save"
				onClicked: {
					root.editing = false;

					title.text = title_edit.text;
					label.text = label_edit.text;

					root.saveItem();
				}
			}
		}
	}
}


