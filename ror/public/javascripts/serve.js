function _sn_serve(_sn) {
	if (_sn == undefined) {
		throw 'Error: missing _sn';
	}
	if (_sn.id == undefined) {
		throw 'Error: missing _sn.id';
	}
	if (_sn.pub == undefined) {
		throw 'Error: missing _sn.pub';
	}
	if (_sn.tid == undefined) {
		throw 'Error: missing _sn.tid';
	}
	window._sn_element = document.getElementById(_sn.id)
	if (_sn_element == undefined) {
		throw 'Error: missing element '+_sn.id;
	}

	_sn_iframe = document.createElement('iframe');
	_sn_iframe.src = 'http://skynet.local/serve?pub='+encodeURIComponent(_sn.pub)+'&tid='+encodeURIComponent(_sn.tid);
	_sn_iframe.setAttribute('style', 'border:0;padding:0;margin:0;width:'+window._sn_element.clientWidth+'px;height:'+window._sn_element.clientHeight+'px;overflow:hidden;');
	window._sn_element.appendChild(_sn_iframe);
	//xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
	//xmlhttp.onreadystatechange = function() {
	//	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	//		window._sn_element.innerHTML = xmlhttp.responseText;
	//	}
	//}
	//xmlhttp.open('GET', 'http://test.local/skynet/serve.php?pub='+_sn.pub+'&tid='+_sn.tid, true);
	//xmlhttp.send();
}

