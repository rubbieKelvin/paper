import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import QtQuick.Window 2.12

import "./components/" as UiComponents
import "./components/controls" as UiControls
import "./components/delegates" as UiDelegates

import "./scripts/dl.js" as Dl
import "./scripts/sort.js" as Sort
import "./scripts/color.js" as ColorJS
import "./scripts/mdicons.mjs" as MDIcons
import "./scripts/apisdk.js" as ApiSDK

Page{
	title: "task"
	background: Rectangle {color: "white"}

	function fetchCheckbooks () {
		const token = encryptedStorage.read(constants.token_filename);
		if (token) {
			const xhr = ApiSDK.getCheckbooks(token.auth_token);
			xhr.onload = function () {
				const response = xhr.response;
				response.map(
					checkbook_membership => {
						check_book_item_list_model.append(checkbook_membership.checkbook);
					}
				);
			}
		}else{
			application.logoutAndGoAuth();
		}
	}

	Component.onCompleted: {
		fetchCheckbooks();
	}

	RowLayout{
		anchors.fill: parent
		spacing: 0

		// Side bar
		Rectangle{
			id: side_bar
			color: (new ColorJS.Color()).primary
			width: 220
			Layout.fillHeight: true

			RowLayout {
				id: side_header
				x: 19
				y: 15
				width: parent.width-20
				height: 30
				anchors.horizontalCenter: parent.horizontalCenter
				spacing: 3

				Label {
					id: user_email_label
					text: application.user.email ? application.user.email : "unknown"
					clip: true
					color: "white"
					font.pixelSize: 14
					verticalAlignment: Text.AlignVCenter
					Layout.fillHeight: true
					Layout.fillWidth: true

					Connections {
						target: application

						function onUserUpdated(){
							user_email_label.text = application.user.email ? application.user.email : "unknown";
						}
					}
				}

				RoundButton {
					id: refreshButton
					flat: true
					icon.source: refresh_icon.source
					highlighted: false
					display: AbstractButton.IconOnly
					Layout.preferredHeight: 24
					Layout.preferredWidth: 24

					UiComponents.Icon{
						id: refresh_icon
						visible: false
						enabled: false
						svgHeight: 24
						svgWidth: 24
						color: "white"
						path: MDIcons.mdiSync
					}
				}
			}

			ListView {
				id: menu_list
				x: 10
				width: parent.width-20
				flickDeceleration: 1
				maximumFlickVelocity: 1
				boundsMovement: Flickable.FollowBoundsBehavior
				flickableDirection: Flickable.VerticalFlick
				boundsBehavior: Flickable.StopAtBounds
				spacing: 5
				clip: true
				anchors.bottom: parent.bottom
				anchors.bottomMargin: 0
				anchors.top: side_header.bottom
				anchors.topMargin: 6
				anchors.horizontalCenter: parent.horizontalCenter
				model: ([
					{path: MDIcons.mdiNote, text: "notes", indexd: 0},
					{path: MDIcons.mdiTag, text: "tags", index: 1}
				])
				delegate: UiDelegates.NavItem{
					width: parent.width
					height: 30
					icon.path: modelData.path
					label.text: modelData.text
					label.color: (menu_list.currentItem === this) ? (new ColorJS.Color()).primary : "white"
					icon.color: (menu_list.currentItem === this) ? (new ColorJS.Color()).primary : "white"

					onClicked: menu_list.currentIndex = index;
				}
				highlight: Rectangle{color: "white"; radius: 5}
			}

			UiDelegates.NavItem{
				anchors.bottom: parent.bottom
				anchors.bottomMargin: 15
				width: parent.width-20
				height: 30
				radius: 5
				color: (hovered) ? "#ffffff" : (new ColorJS.Color()).primary
				label.color: (hovered) ? (new ColorJS.Color()).primary : "#ffffff"
				icon.color: (hovered) ? (new ColorJS.Color()).primary : "#ffffff"
				anchors.horizontalCenter: parent.horizontalCenter
				icon.path: MDIcons.mdiAccountSettings
				label.text: "settings"
			}
		}

		// Bar 2
		Rectangle{
			id: middle_bar
			Layout.preferredWidth: 300
			Layout.fillHeight: true

			StackLayout {
				id: middle_stack
				anchors.fill: parent

				Page {
					id: notes_page
					width: 200
					height: 200
					title: "Notes"
					background: Rectangle{color:"white"}

					Rectangle{
						y: 15
						radius: 20
						height: 40
						id: middle_header
						anchors.margins: 10
						anchors.left: parent.left
						anchors.right: parent.right
						color: (new ColorJS.Color()).strokegray

						RowLayout {
							spacing: 5
							anchors.fill: parent
							anchors.rightMargin: 4
							anchors.leftMargin: 4

							UiComponents.Icon{
								svgHeight: 24
								svgWidth: 24
								color: (new ColorJS.Color()).textdark
								path: "M18.319 14.4326C20.7628 11.2941 20.542 6.75347 17.6569 3.86829C14.5327 0.744098 9.46734 0.744098 6.34315 3.86829C3.21895 6.99249 3.21895 12.0578 6.34315 15.182C9.22833 18.0672 13.769 18.2879 16.9075 15.8442C16.921 15.8595 16.9351 15.8745 16.9497 15.8891L21.1924 20.1317C21.5829 20.5223 22.2161 20.5223 22.6066 20.1317C22.9971 19.7412 22.9971 19.1081 22.6066 18.7175L18.364 14.4749C18.3493 14.4603 18.3343 14.4462 18.319 14.4326ZM16.2426 5.28251C18.5858 7.62565 18.5858 11.4246 16.2426 13.7678C13.8995 16.1109 10.1005 16.1109 7.75736 13.7678C5.41421 11.4246 5.41421 7.62565 7.75736 5.28251C10.1005 2.93936 13.8995 2.93936 16.2426 5.28251Z"
							}

							TextField{
								id: search_checkbook_text_field
								font.pixelSize: 12
								placeholderText: "Search Notes..."
								Layout.fillHeight: true
								Layout.fillWidth: true
								padding: 10
								background: Rectangle{
									color: "transparent"
									radius: 20
									implicitHeight: 40
								}
							}
						}
					}

					ScrollView {
						anchors.top: middle_header.bottom
						anchors.right: parent.right
						anchors.bottom: parent.bottom
						anchors.left: parent.left
						anchors.margins: 5

						ListView {
							id: check_book_item_list
							anchors.fill: parent
							clip: true
							spacing: 5
							model: ListModel{id: check_book_item_list_model}
							delegate: UiDelegates.CheckBookItem{
								favourite: starred
								label.text: name
								visible: name.includes(search_checkbook_text_field.text.trim())
								about.text: "0 items"
								width: (parent || {width: 0}).width
								height: (visible) ? 50 : 0
							}
						}
					}

					// fab
					RoundButton {
						anchors.right: parent.right
						anchors.bottom: parent.bottom
						anchors.margins: 10
						icon.source: add_check_book_icon.source
						display: AbstractButton.IconOnly
						Layout.preferredHeight: 50
						Layout.preferredWidth: 50
						background: Rectangle{
							radius: 25
							implicitHeight: 50
							implicitWidth: 50
							color: (parent.down) ? Qt.darker((new ColorJS.Color()).primary, 1.3) : (new ColorJS.Color()).primary
						}

						UiComponents.Icon{
							id: add_check_book_icon
							visible: false
							enabled: false
							svgHeight: 50
							svgWidth: 50
							color: "#ffffff"
							path: MDIcons.mdiPlus
						}


						onClicked: add_checkbook_box.visible = true
					}

					// close fab
					RoundButton {
						x: 5
						flat: true
						icon.source: cancel_icon__1.source
						highlighted: false
						display: AbstractButton.IconOnly
						visible: add_checkbook_box.visible && !create_new_checkbook_button.loading
						Layout.preferredHeight: 30
						Layout.preferredWidth: 30
						anchors.bottom: add_checkbook_box.top
						anchors.bottomMargin: x
						background: Rectangle{
							radius: parent.width/2
							implicitWidth: 30
							implicitHeight: 30
							color: (new ColorJS.Color()).danger
						}

						UiComponents.Icon{
							id: cancel_icon__1
							visible: false
							enabled: false
							svgHeight: 30
							svgWidth: 30
							color: "white"
							path: MDIcons.mdiCancel
						}

						onClicked: {
							add_checkbook_box.visible = false
							check_book_name_field.text = "";
						}
					}

					Rectangle{
						id: add_checkbook_box
						color: (new ColorJS.Color()).strokegray
						width: parent.width
						height: 70
						anchors.bottom: parent.bottom
						visible: false
						enabled: visible
						
						RowLayout{
							anchors.left: parent.left
							anchors.right: parent.right
							anchors.verticalCenter: parent.verticalCenter
							anchors.leftMargin: 5
							anchors.rightMargin: 5
							height: 50
							spacing: 5

							TextField {
								id: check_book_name_field
								Layout.fillWidth: true
								Layout.fillHeight: true
								Layout.preferredHeight: 50
								placeholderText: qsTr("Checkbook name...")
								padding: 5
								color: (this.text.trim().length <= 20) ? (new ColorJS.Color()).textdark : (new ColorJS.Color()).danger
								background: Rectangle{
									color: "transparent"
								}

								onAccepted: {
									create_new_checkbook_button.clicked();
								}

							}

							UiControls.UiButton{
								id: create_new_checkbook_button
								label.text: "create"
								Layout.preferredWidth: 80
								onClicked: {
									this.loading = true;

									const action_button = this;
									const box = add_checkbook_box;
									const text_field = check_book_name_field;
									const checkbook_name = check_book_name_field.text.trim();
									const token = encryptedStorage.read(constants.token_filename);

									if (token){
										const auth_token = token.auth_token;
										const xhr = ApiSDK.createCheckbook(checkbook_name, auth_token);

										xhr.onload = function () {
											const response = xhr.response;
											const status = xhr.status;

											if (status === 200) {
												text_field.text = "";
												box.visible = false;
												action_button.loading = false;

												check_book_item_list_model.append(response);
											}else{
												action_button.loading = false;
											}
										}

										xhr.onerror = function(){
											action_button.loading = false;
										}

									}else{
										application.logoutAndGoAuth();
									}
								}
							}
						}
					}
				}
			}
		}

		// Stroke
		Rectangle{ color: "#e0e0e0"; Layout.preferredWidth: 1; Layout.fillHeight: true }

		// Main
		Rectangle{
			id: main
			color: "#ffffff"
			Layout.fillWidth: true
			Layout.fillHeight: true

			RowLayout {
				id: header_main
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.margins: 20
				height: 60

				Label {
					text: qsTr("Checkbook Title")
					font.weight: Font.Medium
					font.pixelSize: 18
					verticalAlignment: Text.AlignVCenter
					Layout.fillHeight: true
					Layout.fillWidth: true
				}

				RowLayout{
					spacing: 10
					Layout.fillWidth: true
					Layout.fillHeight: true

					RoundButton {
						id: note_button
						icon.source: add_note_icon.source
						display: AbstractButton.IconOnly
						Layout.preferredHeight: 40
						Layout.preferredWidth: 40
						background: Rectangle{
							radius: 20
							implicitHeight: 40
							implicitWidth: 40
							color: (parent.down) ? Qt.darker((new ColorJS.Color()).strokegray, 1.3) : (new ColorJS.Color()).strokegray
						}

						UiComponents.Icon{
							id: add_note_icon
							visible: false
							enabled: false
							svgHeight: 40
							svgWidth: 40
							color: (new ColorJS.Color()).textdark
							path: MDIcons.mdiNotePlus
						}
					}

					RoundButton {
						id: mic_button
						icon.source: add_vn_icon.source
						display: AbstractButton.IconOnly
						Layout.preferredHeight: 40
						Layout.preferredWidth: 40
						background: Rectangle{
							radius: 20
							implicitHeight: 40
							implicitWidth: 40
							color: (parent.down) ? Qt.darker((new ColorJS.Color()).strokegray, 1.3) : (new ColorJS.Color()).strokegray
						}

						UiComponents.Icon{
							id: add_vn_icon
							visible: false
							enabled: false
							svgHeight: 40
							svgWidth: 40
							color: (new ColorJS.Color()).textdark
							path: MDIcons.mdiMicrophonePlus
						}
					}
					
					RoundButton {
						id: img_button
						icon.source: add_img_icon.source
						display: AbstractButton.IconOnly
						Layout.preferredHeight: 40
						Layout.preferredWidth: 40
						background: Rectangle{
							radius: 20
							implicitHeight: 40
							implicitWidth: 40
							color: (parent.down) ? Qt.darker((new ColorJS.Color()).strokegray, 1.3) : (new ColorJS.Color()).strokegray
						}

						UiComponents.Icon{
							id: add_img_icon
							visible: false
							enabled: false
							svgHeight: 40
							svgWidth: 40
							color: (new ColorJS.Color()).textdark
							path: MDIcons.mdiImagePlus
						}
					}
					
					RoundButton {
						id: list_button
						icon.source: add_list_icon.source
						display: AbstractButton.IconOnly
						Layout.preferredHeight: 40
						Layout.preferredWidth: 40
						background: Rectangle{
							radius: 20
							implicitHeight: 40
							implicitWidth: 40
							color: (parent.down) ? Qt.darker((new ColorJS.Color()).strokegray, 1.3) : (new ColorJS.Color()).strokegray
						}

						UiComponents.Icon{
							id: add_list_icon
							visible: false
							enabled: false
							svgHeight: 40
							svgWidth: 40
							color: (new ColorJS.Color()).textdark
							path: MDIcons.mdiCheckBoxMultipleOutline
						}
					}
				}
			}


			ScrollView {
				clip: true
				anchors.rightMargin: 20
				anchors.leftMargin: 20
				anchors.top: header_main.bottom
				anchors.right: parent.right
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.topMargin: 0

				Flow{
					id: check_book_flow
					width: main.width
					clip: true
					spacing: 10
					padding: 5

					function addNote(title, note){}
					function addRecording(title){}
					function addImage(){}
					function addList(){}

					// Component.onCompleted: {
					// 	const i = check_book_repeater.model
					// 	i.push(
					// 		{
					// 			type: "text",
					// 			value: "Lorem ipsum dolor sit amet"
					// 		}
					// 	)
					// 	check_book_repeater.model = i;
					// }

					Repeater{
						id: check_book_repeater
						clip: true
						model: ListModel{id: check_model}
						delegate: Item{
							id: _root
							height: childrenRect.height
							width: (childrenRect || parent || {width: 0}).width

							Component.onCompleted: {
								let item;

								if (modelData.type === "text") {
									item = new Dl.Item(
										Qt.createComponent("./components/delegates/TextDelegate.qml"),
										_root,
										{
											text: modelData.value,
											width: Qt.binding(
												function(){
													if (main.width < 700) return main.width-50;
													return 320
												}
											)
										}
									);

								} else if (modelData.type === "image") {
									item = new Dl.Item(
										Qt.createComponent("./components/delegates/ImageDelegate.qml"),
										_root,
										{
											source: modelData.value,
											widthRatio: Qt.binding(
												function () {
													if (main.width < 700)
														return 1.0
													else
														return modelData.widthRatio;
												}
											),
											width: Qt.binding(
												function () {
													if (main.width < 700)
														return (main.width - 50);
													else
														return (main.width * modelData.widthRatio) - (modelData.widthRatio === 1 ? 50 : 30);
												}
											)
										}
									);

								} else if (modelData.type === "list") {
									item = new Dl.Item(
										Qt.createComponent("./components/delegates/ListDelegate.qml"),
										_root,
										{model: modelData.value}
									)

								} else if (modelData.type === "audio") {
									item = new Dl.Item(
										Qt.createComponent("./components/delegates/AudioDelegate.qml"),
										_root,
										{
											audio: modelData.value,
											width: Qt.binding(
												function () {
													return main.width-50;
												}
											)
										}
									)
								}
							}
						}
					}
				}
			}
		}
	}
}
