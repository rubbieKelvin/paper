const baseurl ="http://localhost:8000";

function makeXhr(url, method, headers, usecredentials){

	method = method || "GET";
	headers = headers || {};
	usecredentials = usecredentials || false;

	const xhr = new XMLHttpRequest();

	if (usecredentials) xhr.withCredentials = true;

	xhr.open(method, url);
	xhr.responseType = "json";

	xhr.setRequestHeader("Content-Type", "application/json");
	Object.keys(headers).forEach(
		key => {
			xhr.setRequestHeader(key, headers[key]);
		}
	)
	
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

function getUser(token){
	const xhr = makeXhr(
		`${baseurl}/api/authentication/users/me/`,
		"GET",
		{Authorization: `Token ${token}`},
		true
	);
	
	xhr.send();
	return xhr;
}