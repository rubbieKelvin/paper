import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

// python classes
import Lib 1.0

Page{
	id: root
	title: "Auth"

	Request{
		id: login_request
		url: base_url
		method: "GET"
		data: ({name: "rubbie"})
		headers: ({mime: "me"})
	}
	
	// login connections
	Connections {
		target: login_request

		function onRequestCompleted(response) {
			console.log("url:", login_request.url);
			console.log("method:", login_request.method);
			console.log("data:", JSON.stringify(login_request.data));
			console.log("headers:", JSON.stringify(login_request.headers));
			console.log("response:", JSON.stringify(response));
		}

		function onRequestError(error){
			console.log(error);
		}
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
				text: "email"
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
				login_request.call()
			}
		}
	}
}