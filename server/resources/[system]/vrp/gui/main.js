window.addEventListener("load",function(){
	errdiv = document.createElement("div");
	if (true){
		errdiv.classList.add("console");
		document.body.appendChild(errdiv);
		window.onerror = function(errorMsg,url,lineNumber,column,errorObj){
			errdiv.innerHTML += '<br />Error: ' + errorMsg + ' Script: ' + url + ' Line: ' + lineNumber + ' Column: ' + column + ' StackTrace: ' +  errorObj;
		}
	}

	var wprompt = new WPrompt();
	var requestmgr = new RequestManager();

	requestmgr.onResponse = function(id,ok){ $.post("http://vrp/request",JSON.stringify({ act: "response", id: id, ok: ok })); }
	wprompt.onClose = function(){ $.post("http://vrp/prompt",JSON.stringify({ act: "close", result: wprompt.result })); }

	window.addEventListener("message",function(evt){
		var data = evt["data"];

		if(data["act"] == "prompt"){
			wprompt.open(data["title"],data["text"]);
		}

		if(data["act"] == "request"){
			requestmgr.addRequest(data["id"],data["text"],data["accept"],data["reject"]);
		}

		if(data["act"] == "event"){
			if(data["event"] == "Y"){
				requestmgr.respond(true);
			}
			else if(data["event"] == "U"){
				requestmgr.respond(false);
			}
		}

		if (data["death"] == true){
			$("#deathDiv").css("display","block");
		}

		if (data["death"] == false){
			$("#deathDiv").css("display","none");
		}

		if (data["deathtext"] !== undefined){
			$("#deathText").html(data["deathtext"]);
		}

		if (data["identity"] !== undefined){
			if (data["identity"] == false){
				if ($("#identityDiv").css("display") === "block"){
					$("#identityDiv").css("display","none");
				}
			} else {
				if ($("#identityDiv").css("display") === "none"){
					$("#identityDiv").css("display","block");
				}

				if (data["mode"] == "identity"){
					$("#identityDiv").html(`
						<div class="identityLeft">Nome<br><r>${data["nome"]}</div>
						<div class="identityRight">Nacionalidade<br><r>${data["nacionalidade"]}</div>

						<div class="identityLeft">Tipo Sanguíneo<br><r>${data["sangue"]}</div>
						<div class="identityRight">Máximo de Veículos<br><r>${format(data["veiculos"])}</div>

						<div class="identityLeft">Total de Gemas<br><r>${format(data["gemas"])}</div>
						<div class="identityRight">Porte de Armas<br><r>${data["porte"] == 0 ? "Não":"Sim"}</div>

						<div class="identityLeft">Premium<br><r>${data["premium"]}</div>
					`);
				} else {
					$("#identityDiv").html(`
						<div class="identityLeft">Nome<br><r>${data["nome"]}</div>
						<div class="identityRight">Nacionalidade<br><r>${data["nacionalidade"]}</div>

						<div class="identityLeft">Porte de Armas<br><r>${data["porte"] == 0 ? "Não":"Sim"}</div>
						<div class="identityRight">Tipo Sanguíneo<br><r>${data["sangue"]}</div>
					`);
				}
			}
		}
	});
});
/* ----------FORMAT---------- */
const format = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}