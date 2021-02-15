import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

import './scripts/color.js' as ColorJS
import './scripts/apisdk.js' as ApiSDK
import './components/controls' as UiControls

Page{
	id: root
	title: "auth"
	background: Rectangle{color:"transparent"}

	property bool login: true

	function toggleInputs(state){
		email_field.enabled = state
		password_field.enabled = state
		login_button.enabled = state
		login_button.loading = !state
		mode_switch_button.enabled = state
	}

	function validateFields(){
		const email = email_field.text;
		const password = password_field.text;

		if (root.login) return true;

		if (email.length < 5){
			alert_box.notify("invalid email");
			return false;
		}

		if (password.length < 6){
			alert_box.notify("user password with > 6 characters");
			return false
		}

		return true;

	}

	function authenticate(){
		this.toggleInputs(false);

		if (this.validateFields()) {
			if (login) this.login_user();
			else this.signup_user();
		}else{
			this.toggleInputs(true);
		}
	}

	function signup_user(){

	}

	function login_user(){
		const email = email_field.text;
		const password = password_field.text;
		const xhr = ApiSDK.login(email, password);
		
		xhr.onload = function(){
			const response = xhr.response;
			root.toggleInputs(true);

			if (xhr.status === 200) {
				encryptedStorage.write(constants.token_filename, response);
				alert_box.notify("logged in");
				application_stack.push("./home.qml");

			}else if (xhr.status === 400) {
				alert_box.notify("Unable to log in with provided credentials.");
			}
		}
	}

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
				text:  (login) ? "Login." : "Signup."
				font.pixelSize: 24
			}

			ColumnLayout{
				spacing: 15
				Layout.fillWidth: true
				Layout.fillHeight: true

				UiControls.UiTextField{
					id: email_field
					placeholderText: "email address.."
					Layout.fillWidth: true
					Layout.preferredHeight: 40
					bgcolor: (new ColorJS.Color("11")).primary
					font.pixelSize: 12
				}

				UiControls.UiTextField{
					id: password_field
					placeholderText: "password..."
					Layout.fillWidth: true
					Layout.preferredHeight: 40
					bgcolor: (new ColorJS.Color("11")).primary
					font.pixelSize: 12
					echoMode: TextInput.Password
				}

				UiControls.UiButton{
					id: login_button
					label.text: (login) ? "login" : "signup"
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

					// onClicked: application_stack.push("./home.qml");
					onClicked: root.authenticate();
				}

				UiControls.UiButton{
					id: mode_switch_button
					label.text: (login) ? "signup instead" : "login instead"
					label.color: "white"
					mousearea.hoverEnabled: true
					Layout.fillWidth: true
					Layout.preferredHeight: 40
					color: (new ColorJS.Color()).primary
					states: [
						State {
							name: "down"
							PropertyChanges { target: mode_switch_button; color: Qt.darker((new ColorJS.Color()).primary, 1.3) }
						}
					]

					onClicked: {
						root.login = !root.login;
					}
				}
			}
		}
	}
}
