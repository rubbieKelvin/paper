const baseurl ="http://localhost:8000";

function makeXhr(url, method){
	const xhr = new XMLHttpRequest();
	xhr.open(method || "GET", url);
	xhr.responseType = "json";
	xhr.setRequestHeader("Content-Type", "application/json");
	return xhr;
}

function login(email, password){
	const xhr = makeXhr(`${baseurl}/api/authentication/token/login/`, "POST");
	xhr.send(
		JSON.stringify(
			{
				email: email,
				password: password
			}
		)
	);
	
	return xhr;
}