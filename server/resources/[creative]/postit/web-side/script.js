addEventListener("message",function(event){
	if (event["data"]["show"] !== undefined){
		if (event["data"]["show"] == true){
			var html = `<span id=${event["data"]["id"]} class="message" style="left: 0; top: 0;"></span>`;
			$(html).fadeIn("normal").appendTo("#webPostIt");
		}
	}

	if (event["data"]["action"] !== undefined){
		if (event["data"]["action"] == "update"){
			$(`#${event["data"]["id"]}`).css("left",event["data"]["x"] * 87 + "%").css("top",event["data"]["y"] * 100 + "%");
			$(`#${event["data"]["id"]}`).html("<span class='background'>"+event["data"]["text"]+"</span>")
		}

		if (event["data"]["action"] == "remove"){
			$(`#${event["data"]["id"]}`).fadeOut("normal",function(){ $(this).remove(); });
		}
	}
});