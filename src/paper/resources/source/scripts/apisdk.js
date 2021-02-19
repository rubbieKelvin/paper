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

function createCheckbook(name, token){
	const xhr = makeXhr(
		`${baseurl}/api/app/checkbook/`,
		"POST",
		{Authorization: `Token ${token}`}
	);

	xhr.send(
		JSON.stringify(
			{
				name: name,
				starred: false
			}
		)
	);

	return xhr;
}

function getCheckbooks(token){
	const xhr = makeXhr(
		`${baseurl}/api/app/checkbook/`,
		"GET",
		{Authorization: `Token ${token}`}
	);

	xhr.send();
	return xhr;
}

function editCheckbook(id, name, starred, token) {
	const data = {checkbook_id: id}

	if (name !== null || name !== undefined) data.name = name;
	if (starred !== null || starred !== undefined) data.starred = starred;

	const xhr = makeXhr(
		`${baseurl}/api/app/checkbook/`,
		"PATCH",
		{Authorization: `Token ${token}`}
	);
	
	xhr.send(JSON.stringify(data));
	return xhr;
}

function getTags(token){
	const xhr = makeXhr(
		`${baseurl}/api/app/tags/`,
		"GET",
		{Authorization: `Token ${token}`}
	)

	xhr.send();
	return xhr;
}

function createTag(name, token) {
	const xhr = makeXhr(
		`${baseurl}/api/app/tags/`,
		"POST",
		{Authorization: `Token ${token}`}
	);

	xhr.send(
		JSON.stringify(
			{
				name: name,
			}
		)
	);

	return xhr;	
}

function deleteTag(id, token) {
	const xhr = makeXhr(
		`${baseurl}/api/app/tags/delete/${id}/`,
		"DELETE",
		{Authorization: `Token ${token}`},
	);

	xhr.send(
		JSON.stringify(
			{"tag_id": id}
		)
	);

	return xhr;	
}

function getCheckbook(id, token){

	const xhr = makeXhr(
		`${baseurl}/api/app/checkbook/get/${id}/`,
		"GET", {Authorization: `Token ${token}`}
	);

	xhr.send();
	return xhr;
}

function editTextitem (checkbook_id, textitem_id, title, content, token) {
	const xhr = makeXhr(`${baseurl}/api/app/checkbook/items/text/`, "PATCH", {Authorization: `Token ${token}`});
	xhr.send(JSON.stringify({
		checkbook_id: checkbook_id,
		textitem_id: textitem_id,
		title: title,
		content: content
	}));

	return xhr;
}