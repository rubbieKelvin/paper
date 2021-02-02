import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

// python classes
import Lib 1.0

Page{
	id: root
	title: "Login"

	Request{
		id: login_request
		method: "POST"
		url: `${base_url}/api/authentication/token/login/`
		headers: ({
			'Content-Type': 'application/json'
		})
	}

	Connections {
		target: login_request

		function onRequestCompleted(response){
			if (response.status===200) {
				auth_key_store.write(response.json);
				console.log("logged in succesfully");
				// go home
				application_stack.push("./home/main.qml");
			}else{
				console.log(JSON.stringify(response.json));
			}
		}

		function onRequestError(error){
			console.log(error);
		}
	}

	EncryptedJSONStorage {
		id: auth_key_store
		key: crypt_key
		filename: cryptfiles.authfilename
	}

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
				text: "Password"
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
				login_request.json = {
					email: email.text,
					password: password.text
				};
				login_request.call()
			}
		}
	}
}