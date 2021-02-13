import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import QtQuick.Window 2.12

import './scripts/color.js' as ColorJS
import './components/controls' as UiControls

ApplicationWindow{
	id: application

	// visibility
	visible: true

	// geom
	width: 1000
	height: 700

	// custom properties
	readonly property string base_url: "http://localhost:8000"
	readonly property int crypt_key: 32
	property variant user: null

	background: Rectangle {color: "white"}

	StackView{
		id: application_stack
		anchors.fill: parent
		initialItem: Component{
			id: application_stack_main_component

			Page{
				title: "spalsh"
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

					// TODO: remove this timer below
					Timer{
						id: _timer
						interval: 3000
						running: true
						repeat: false

						onTriggered: {
							application_stack.push("./auth.qml");
						}
					}

					// TODO: remove this timer below
					Timer{
						id: _timer_2
						interval: 30
						running: load_bar.value < 100
						repeat: load_bar.value < 100

						onTriggered: load_bar.value += 1;
					}
				}
			}
		}
	}
}
