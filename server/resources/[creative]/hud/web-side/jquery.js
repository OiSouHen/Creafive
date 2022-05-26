var lastRadio = ""
var voice = "Médio"
var tickInterval = undefined;
// -------------------------------------------------------------------------------------------
function minimalTimers(Seconds){
	var Days = Math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	var Hours = Math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	var Minutes = Math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	const [D,H,M,S] = [Days,Hours,Minutes,Seconds].map(s => s.toString().padStart(2,0))

    if (Days > 0){
        return D + ":" + H
    } else if (Hours > 0){
        return H + ":" + M
    } else if (Minutes > 0){
        return M + ":" + S
    } else if (Seconds > 0){
        return "00:" + S
    }
}
// -------------------------------------------------------------------------------------------
$(document).ready(function(){
	window.addEventListener("message",function(event){
		if (event["data"]["progress"] !== undefined){
			if ($("#displayProgress").css("display") === "block"){
				$("#displayProgress").css("display","none");
				clearInterval(tickInterval);
				tickInterval = undefined;

				return
			} else {
				$("#displayProgress").css("display","block");
				$(".progress").css("width","0");
			}

			var tickPerc = 1;
			var timeSlamp = event["data"]["progressTimer"];
			tickInterval = setInterval(tickFrame,timeSlamp / 100);

			function tickFrame(){
				tickPerc = tickPerc + 1;

				if (tickPerc >= 100){
					clearInterval(tickInterval);
					tickInterval = undefined;
					$("#displayProgress").css("display","none");
				}

				$(".progress").css("width",tickPerc + "%");
			}

			return
		}

		if (event["data"]["mumble"] !== undefined){
			if (event["data"]["mumble"] == true){
				$("#Mumble").css("display","flex");
			} else {
				$("#Mumble").css("display","none");
			}

			return
		}

		if (event["data"]["hud"] !== undefined){
			if (event["data"]["hud"] == true){
				$("#displayHud").fadeIn(500);
				$("#Streets").fadeIn(500);

				if (event["data"]["vehicle"] == 1 && Compass == true){
					$(".displayMap").css("display","block");
				}
			} else {
				$("#displayHud").fadeOut(500);
				$("#Streets").fadeOut(500);

				if (event["data"]["vehicle"] == 1 && Compass == true){
					$(".displayMap").css("display","none");
				}
			}

			return
		}
		
		if (event["data"]["compass"] !== undefined && event["data"]["vehicle"] == 1){
			Compass = event["data"]["compass"];

			if (Compass == true){
				if ($(".displayMap").css("display") === "none"){
					$(".displayMap").css("display","block");
				}
			} else {
				if ($(".displayMap").css("display") === "block"){
					$(".displayMap").css("display","none");
				}
			}

			return
		}

		if (event["data"]["movie"] !== undefined){
			if (event["data"]["movie"] == true){
				$("#movieTop").fadeIn(500);
				$("#movieBottom").fadeIn(500);
			} else {
				$("#movieTop").fadeOut(500);
				$("#movieBottom").fadeOut(500);
			}

			return
		}

		if (event["data"]["hood"] !== undefined){
			if (event["data"]["hood"] == true){
				$("#hoodDisplay").fadeIn(500);
			} else {
				$("#hoodDisplay").fadeOut(500);
			}
		}

		if (event["data"]["voice"] !== undefined){
			voice = event["data"]["voice"]
		}

		if (event["data"]["health"] !== undefined){
			if (event["data"]["health"] <= 101){
				if ($("#health").css("display") === "block"){
					$("#health").css("display","none");
				}
			} else {
				if ($("#health").css("display") === "none"){
					$("#health").css("display","block");
				}

				$(".health").css("height",event["data"]["health"] - 99 + "%");
			}
		}

		if (event["data"]["thirst"] !== undefined){
			$(".water").css("height",event["data"]["thirst"] + "%");
		}

		if (event["data"]["hunger"] !== undefined){
			$(".food").css("height",event["data"]["hunger"] + "%");
		}

		if (event["data"]["radio"] !== undefined){
			lastRadio = event["data"]["radio"];
		}

		if (event["data"]["stress"] !== undefined){
			if (event["data"]["stress"] <= 0){
				if ($("#stress").css("display") === "block"){
					$("#stress").css("display","none");
				}
			} else {
				if ($("#stress").css("display") === "none"){
					$("#stress").css("display","block");
				}
			}

			$(".stress").css("height",event["data"]["stress"] + "%");
		}

		if (event["data"]["oxigen"] !== undefined){
			if (event["data"]["oxigenShow"] === undefined){
				if ($("#oxigen").css("display") === "block"){
					$("#oxigen").css("display","none");
				}
			} else {
				if ($("#oxigen").css("display") === "none"){
					$("#oxigen").css("display","block");
				}
			}

			$(".oxigen").css("height",event["data"]["oxigen"] + "%");
		}

		if (event["data"]["armour"] !== undefined){
			if (event["data"]["armour"] <= 0){
				if ($("#armour").css("display") === "block"){
					$("#armour").css("display","none");
				}
			} else {
				if ($("#armour").css("display") === "none"){
					$("#armour").css("display","block");
				}
			}

			$(".armour").css("height",event["data"]["armour"] + "%");
		}

		if (event["data"]["vehicle"] !== undefined){
			if (event["data"]["vehicle"] == true){
				if ($("#displayVehicle").css("display") === "none"){
					$("#displayVehicle").css("display","block");
				}

				if (event["data"]["belt"] == false){
					$(".Belt").css("height","0");
				} else {
					$(".Belt").css("height","100%");
				}

				if (event["data"]["belt"] == false){
					$(".Belt").css("height","0");
				} else {
					$(".Belt").css("height","100%");
				}

				if (event["data"]["locked"] == 1){
					$(".Locked").css("height","0");
				} else {
					$(".Locked").css("height","100%");
				}

				var Speed = parseInt(event["data"]["speed"])
				if (Speed < 10){
					Speed = "<opacity>00</opacity>" + Speed
				} else if (Speed > 10 && Speed < 100){
					Speed = "<opacity>0</opacity>" + Speed
				}

				$(".speed").html(Speed);

				$(".Nitro").css("height",parseInt(event["data"]["nitro"] / 2) + "%");
				$(".Fuel").css("height",parseInt(event["data"]["fuel"]) + "%");
			} else {
				if ($("#displayVehicle").css("display") === "block"){
					$("#displayVehicle").css("display","none");
				}
			}

			var wantedText = ""
			var wantedTimers = parseInt((event["data"]["wanted"] - event["data"]["timer"]) / 1000)
			if (wantedTimers > 0){
				wantedText = "<text>"+ minimalTimers(wantedTimers) +" Procurado</text>"
			}

			var reposeText = ""
			var reposeTimers = parseInt((event["data"]["repose"] - event["data"]["timer"]) / 1000)
			if (reposeTimers > 0){
				reposeText = "<text>"+ minimalTimers(reposeTimers) +" Repouso</text>"
			}

			var userVoice = "<inative>" + voice + "</inative>"
			if (event["data"]["talking"] !== undefined){
				if (event["data"]["talking"] == 1){
					userVoice = "<active>" + voice + "</active>"
				} else {
					userVoice = "<inative>" + voice + "</inative>"
				}
			}

			$("#displayBoxes").html(lastRadio + reposeText + wantedText + userVoice + "<text>"+ event["data"]["street"] +"</text>");
		}
	});
});