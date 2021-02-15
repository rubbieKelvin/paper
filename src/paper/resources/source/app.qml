import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import QtQuick.Window 2.12

import './components' as UiComponents
import './components/controls' as UiControls

import './scripts/color.js' as ColorJS
import './scripts/apisdk.js' as ApiSDK
import './scripts/mdicons.mjs' as MDIcons

ApplicationWindow{
	id: application

	// visibility
	visible: true

	// geom
	width: 1000
	height: 700
	
	background: Rectangle {color: "white"}

	property variant user: null
	signal userUpdated()

	QtObject {
		id: constants
		readonly property string token_filename: "{$apphome}/paper.user.xxx"
	}

	StackView{
		id: application_stack
		anchors.fill: parent
		initialItem: Component{
			id: application_stack_main_component

			Page{
				title: "splash"
				background: Rectangle{color:"transparent"}

				Image{
					source: "./assets/svg/logo-with-text.svg"
					anchors.centerIn: parent
				}

				UiControls.UiProgressBar{
					id: load_bar
					width: 200
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.bottom: parent.bottom
					anchors.bottomMargin: 60
					value: 0
					from: 0
					to: 100
					color: (new ColorJS.Color()).primary

					Timer{
						id: timer
						interval: 3000
						running: true
						repeat: false

						onTriggered: {
							application_stack.push("./auth.qml");
						}
					}

					Timer{
						id: timer_2
						interval: 30
						running: load_bar.value < 100
						repeat: load_bar.value < 100

						onTriggered: load_bar.value += 1;
					}

					Component.onCompleted: {

						// check for token
						const token = encryptedStorage.read(constants.token_filename)
						const stack = application_stack;

						if (token === undefined){
							// there's no user at all
							// just go to signup
							timer.stop();
							timer_2.stop();
							stack.clear();
							stack.push("./auth.qml");
							
						}else{
							console.log("There is a user");
							console.log("verifying user");

							const xhr = ApiSDK.getUser(token.auth_token);
							xhr.onload = function() {
								const response = xhr.response;
								const status = xhr.status;

								if (status === 200) {
									application.user = response;
									application.userUpdated();

									// just go to signup
									timer.stop();
									timer_2.stop();
									stack.clear();
									stack.push("./home.qml");

								}else{
									// expireed token
									// delete token
									encryptedStorage.delete(constants.token_filename);
									timer.stop();
									timer_2.stop();
									stack.clear();
									stack.push("./auth.qml");
								}
							}
						}
					}
				}
			}
		}
	}

	Rectangle{
		id: alert_box
		width: childrenRect.width + 30
		height: 50
		radius: 10
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.margins: 10
		color: "#000"
		visible: false
		enabled: visible

		function notify(message, duration) {
			duration = duration || 3000;
			alert_box_timer.stop();

			alert_box_timer.interval = duration;
			alert_box_label.text = message;
			alert_box.visible = true;
			
			alert_box_timer.restart();
		}

		Timer{
			id: alert_box_timer
			running: false
			repeat: false
			onTriggered: alert_box.visible = false
		}

		RowLayout{
			// anchors.fill: parent
			x: 15
			y: 10
			spacing: 5

			Label{
				id: alert_box_label
				color: "white"
				Layout.fillWidth: true
				Layout.fillHeight: true
				font.pixelSize: 14
				verticalAlignment: Text.AlignVCenter
			}

			Button {
				icon.source: cancel_icon.source
				display: AbstractButton.IconOnly
				Layout.preferredHeight: 28
				Layout.preferredWidth: 28
				background: Rectangle{
					implicitHeight: 28
					implicitWidth: 28
					color: "transparent"
				}

				UiComponents.Icon{
					id: cancel_icon
					visible: false
					enabled: false
					svgHeight: 28
					svgWidth: 28
					color: "white"
					path: MDIcons.mdiCancel
				}

				onClicked: {
					alert_box_timer.stop()
					alert_box.visible = false;
				}
			}
		}
	}
}
