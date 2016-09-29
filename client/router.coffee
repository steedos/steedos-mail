checkUserSigned = (context, redirect) ->
	if !Meteor.userId()
		FlowRouter.go '/steedos/sign-in';

checkMailAccountIsNull = (context, redirect) ->
	if !AccountManager.getAuth()
		FlowRouter.go '/admin/view/mail_accounts';
		toastr.warning("请配置邮件账户");
		$(document.body).removeClass('loading');

checkAccountLogin = (context, redirect) ->
	if !AccountManager.checkAccount()
		FlowRouter.go '/admin/view/mail_accounts';
# [ checkUserSigned, checkMailAccountIsNull, checkAccountLogin],
mailRoutes = FlowRouter.group
	prefix: '/emailjs',
	name: 'mailRoute',
	triggersEnter: [ checkUserSigned],

mailRoutes.route '/', 
	action: (params, queryParams)->
		Session.set("mailForward", false);
		Session.set("mailReply", false);
		Session.set("mailReplyAll", false);
		Session.set("mailJumpDraft", false);
		Session.set("mailBox", "Inbox");
		Session.set("mailMessageId", null); 
		Session.set("mailPage",1);
		BlazeLayout.render 'emailjsLayout',
			main: "mail_home"

mailRoutes.route '/b/:mailBox/', 
	action: (params, queryParams)->
		Session.set("mailForward", false);
		Session.set("mailReply", false);
		Session.set("mailReplyAll", false);
		Session.set("mailJumpDraft", false);
		Session.set("mailBox", params.mailBox); 
		Session.set("mailMessageId", null); 
		Session.set("mailPage",1);
		Session.set("mailBoxFilter", ""); 
		Session.set("mailMessageLoadding",false);
		BlazeLayout.render 'emailjsLayout',
			main: "mail_home"

mailRoutes.route '/b/:mailBox/:mailMessageId', 
	action: (params, queryParams)->
		Session.set("mailForward", false);
		Session.set("mailReply", false);
		Session.set("mailReplyAll", false);
		Session.set("mailJumpDraft", false);
		Session.set("mailBox", params.mailBox); 
		if !Session.get("mailPage")
			Session.set("mailPage",1)
		
		Session.set("mailMessageId", params.mailMessageId); 
		BlazeLayout.render 'emailjsLayout',
			main: "mail_home"

mailRoutes.route '/b/forward/:mailBox/:mailMessageId', 
	action: (params, queryParams)->
		Session.set("mailForward", true);
		Session.set("mailReply", false);
		Session.set("mailReplyAll", false);
		Session.set("mailJumpDraft", false);
		Session.set("mailBox", params.mailBox); 
		Session.set("mailMessageId", params.mailMessageId); 
		BlazeLayout.render 'emailjsLayout',
			main: "mail_home"

mailRoutes.route '/b/reply/:mailBox/:mailMessageId', 
	action: (params, queryParams)->
		Session.set("mailReply", true);
		Session.set("mailReplyAll", false);
		Session.set("mailJumpDraft", false);
		Session.set("mailBox", params.mailBox); 
		Session.set("mailMessageId", params.mailMessageId); 
		BlazeLayout.render 'emailjsLayout',
			main: "mail_home"

mailRoutes.route '/b/replyAll/:mailBox/:mailMessageId', 
	action: (params, queryParams)->
		Session.set("mailReplyAll", true);
		Session.set("mailJumpDraft", false);
		Session.set("mailBox", params.mailBox); 
		Session.set("mailMessageId", params.mailMessageId); 
		BlazeLayout.render 'emailjsLayout',
			main: "mail_home"

mailRoutes.route '/b/jumpDraft/:mailBox/:mailMessageId', 
	action: (params, queryParams)->
		Session.set("mailJumpDraft", true);
		Session.set("mailBox", params.mailBox); 
		Session.set("mailMessageId", params.mailMessageId); 
		BlazeLayout.render 'emailjsLayout',
			main: "mail_home"






