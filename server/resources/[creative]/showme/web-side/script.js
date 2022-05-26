addEventListener("message",function(event){
	if (event["data"]["show"] !== undefined){
		if (event["data"]["show"] == true){
			var html = `<span id=${event["data"]["id"]} class="message" style="left: 0; top: 0;"></span>`;
			$(html).fadeIn("normal").appendTo("#webShowMe");
		}
	}

	if (event["data"]["action"] !== undefined){
		if (event["data"]["action"] == "update"){
			if (event["data"]["border"] !== undefined){
				$(`#${event["data"]["id"]}`).css("padding","0").css("background","transparent");
				$(`#${event["data"]["id"]}`).css("left",event["data"]["x"] * 100 + 4 + "%").css("top",event["data"]["y"] * 95 + "%");

				$(`#${event["data"]["id"]}`).html(event["data"]["text"])
			} else {
				$(`#${event["data"]["id"]}`).css("padding","10px 13px").css("background","rgba(15,15,15,0.5)");
				$(`#${event["data"]["id"]}`).css("left",event["data"]["x"] * 100 + 3 + "%").css("top",event["data"]["y"] * 100 + "%");

				$(`#${event["data"]["id"]}`).text(event["data"]["text"])
			}
		}

		if (event["data"]["action"] == "remove"){
			$(`#${event["data"]["id"]}`).fadeOut("normal",function(){ $(this).remove(); });
		}
	}
});