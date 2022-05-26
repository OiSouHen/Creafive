function RequestManager(){
	var _this = this;
	setInterval(function(){ _this.tick(); },1000);
	this.requests = [];
	this.div = document.createElement("div");
	this.div.classList.add("requestManager");
	document.body.appendChild(this.div);
}

RequestManager.prototype.buildText = function(text,accept,reject){
	return `<div id="NotifyBackground">
		<div id="NotifyText">${text}</div>
		<div id="NotifyY">Y</div><div id="NotifyLeg">${accept == undefined ? "Aceitar":accept}</div>
		<div id="NotifyU">U</div><div id="NotifyLeg">${reject == undefined ? "Recusar":reject}</div>
	</div>`;
}

RequestManager.prototype.addRequest = function(id,text,accept,reject){
	var request = {}
	request.id = id;
	request.time = 29;
	request.text = text;
	request.accept = accept;
	request.reject = reject;
	request.div = document.createElement("div");
	request.div.innerHTML = this.buildText(text,accept,reject);
	this.requests.push(request);
	this.div.appendChild(request["div"]);
}

RequestManager.prototype.respond = function(ok){
	if (this.requests["length"] > 0){
		var request = this.requests[0];
		if (this.onResponse){
			this.onResponse(request["id"],ok);
			this.div.removeChild(request["div"]);
			this.requests.splice(0,1);
		}
	}
}

RequestManager.prototype.tick = function(){
	for (var i = this.requests.length - 1; i >= 0; i--){
		var request = this.requests[i];
		request["time"] -= 1;
		request.div.innerHTML = this.buildText(request["text"],request["accept"],request["reject"]);

		if (request["time"] <= 0){
			this.div.removeChild(request["div"]);
			this.requests.splice(i,1);
		}
	}
}