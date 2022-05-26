$(document).ready(function(){
	var notifyNumber = 0;
	window.addEventListener("message",function(event){
		if (event["data"]["notify"] !== undefined){
			var html = `<div id='${event.data.css}'>
				${event["data"]["mensagem"]}
				<div class="timer-bar ${notifyNumber}"></div>
			</div>`;

			$(html).fadeIn(500).appendTo("#notifications").delay(event["data"]["timer"]).fadeOut(500);
			$(`.${notifyNumber}`).css("transition",`width ${event["data"]["timer"]}ms`);

			setTimeout(() => {
				$(`.${notifyNumber}`).css("width","0%");
				notifyNumber += 1;
			},100);
		}

		if (event["data"]["shortcuts"] !== undefined){
			if (event["data"]["shortcuts"] == true){
				if ($("#Shortcuts").css("display") === "none"){
					$("#Shortcuts").css("display","flex");
				}

				if (event["data"]["shorts"][1] !== ""){
					$(".Shorts-1").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["shorts"][1]}.png)`);
				} else {
					$(".Shorts-1").css("background-image","none");
				}

				if (event["data"]["shorts"][2] !== ""){
					$(".Shorts-2").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["shorts"][2]}.png)`);
				} else {
					$(".Shorts-2").css("background-image","none");
				}

				if (event["data"]["shorts"][3] !== ""){
					$(".Shorts-3").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["shorts"][3]}.png)`);
				} else {
					$(".Shorts-3").css("background-image","none");
				}

				if (event["data"]["shorts"][4] !== ""){
					$(".Shorts-4").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["shorts"][4]}.png)`);
				} else {
					$(".Shorts-4").css("background-image","none");
				}

				if (event["data"]["shorts"][5] !== ""){
					$(".Shorts-5").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["shorts"][5]}.png)`);
				} else {
					$(".Shorts-5").css("background-image","none");
				}
			} else {
				if ($("#Shortcuts").css("display") === "flex"){
					$("#Shortcuts").css("display","none");
				}
			}
		}
	});
});