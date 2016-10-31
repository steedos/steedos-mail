MailQuartz = {};

MailQuartz.intervalId = null;

MailQuartz.getNewMessages = function(){
	console.log("MailQuartz.getNewMessages run...");

	if(MailQuartz.intervalId !=null){
		clearInterval(MailQuartz.intervalId);
	}

	MailQuartz.intervalId = setInterval(function(){
		MailManager.getNewBoxMessages("Inbox",function(messages){
		    if(messages.length > 0){
		    	var title, body, openUrl;
		    	var inboxPath = MailManager.getBoxBySpecialUse("\\Inbox").path;
				var emailjsPath = "/emailjs/b/" + inboxPath + "/";
		    	var msg = new Audio("/sound/notification.mp3");
		        if(messages.length > 1){
		        	title = "未读邮件";
		        	body = "您有" + messages.length + "封未读邮件";
		        	openUrl = emailjsPath;
		        }else{  
	                var envelope = messages[0]["envelope"];
	                var uid = messages[0].uid;
	                var from = envelope.from;
	    			if (from[0].name)
	    				title = from[0].name;
	    			else
	    				title = from[0].address;
	    			body = envelope.subject;
	    			openUrl = emailjsPath + uid;
		        }
		        var options = {
	                iconUrl: Meteor.absoluteUrl() + "images/apps/workflow/AppIcon48x48.png",
	                title: title,
	                body: body,
	                timeout: 6 * 1000
            	}
            	options.onclick = function(){
            		var domainsArr = FlowRouter._current.path.split("/");
            		if (domainsArr[1] && (domainsArr[1] == "emailjs")){
            			FlowRouter.go(openUrl);
            		}else{
            			Steedos.openWindow(openUrl);
            		}
            	}
	 	        $.notification(options);
            	msg.play();
            	return;
		    }
		});
	},1000 * 30);
}
