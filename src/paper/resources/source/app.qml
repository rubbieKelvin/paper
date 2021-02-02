import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import QtQuick.Window 2.12

// python
import Lib 1.0

Window{
	id: application

	// visibility
	visible: true

	// geom
	width: 700
	height: 500

	// constraints
	minimumWidth: 350
	minimumHeight: 600

	// custom properties
	readonly property string base_url: "http://localhost:8000"
	readonly property int crypt_key: 31
	property variant user: null 

	// STORAGE FILE
	QtObject {
		id: cryptfiles
		readonly property string authfilename: "{$apphome}/auth.crypt" 
	}

	// PALLETE
	QtObject{
		id: pallete
		readonly property string primary: Qt.rgba(0.9372549019607843, 0.29411764705882354, 0.29411764705882354, 1);
		readonly property string alphagray: Qt.rgba(0.29411764705882354, 0.29411764705882354, 0.29411764705882354, 1);
		readonly property string alphaprimary: Qt.rgba(0.9372549019607843, 0.29411764705882354, 0.29411764705882354, .2);
	}

	// stack view for whole app
	StackView{
		id: application_stack
		anchors.fill: parent
		initialItem: Component{
			Page{
				BusyIndicator{
					anchors.centerIn: parent
				}

				EncryptedJSONStorage{
					id: auth_crpt
					filename: cryptfiles.authfilename
					key: crypt_key

					onCryptingKeyError: {
						// this is prolly a bad key
						// just assume the user doesnt have an auth
						// the user will have to re-login.

						// ...
						console.error("crypting error...");
						
						// ... go to auth
						application_stack.push("./auth.qml");
					}

					Component.onCompleted: {
						const auth = this.read();

						if (auth===undefined || auth===null) {
							// there's no auth file to begin with
							return application_stack.push("./auth.qml");
						}
						const token = auth.auth_token;

						// do a request with the token...
						// to verify if the user is valid
						get_me_request.headers = {
							Authorization: `Token ${token}`
						};

						get_me_request.call();
					}
				}

				Request{
					id: get_me_request
					url: `${base_url}/api/authentication/users/me/`
					method: "GET"
				}
				
				Connections {
					target: get_me_request

					function onRequestCompleted(response){
						if (response.status === 200) {
							
							// good to go
							application.user = response.json;
							console.log("token verified");

							// ...
							// go home
							application_stack.push("./home/main.qml");

						}else{
							
							// error while logging in
							console.log("error while logging in");
						}
					}
				}
			}
		}
	}

}