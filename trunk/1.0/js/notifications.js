/*
	notifications.js
	
	Joe Markwardt (Edgepath Technology)
	
	Javascript library to provide outlook-like pop-up notifications
	Requires a div named notificationArea to work
*/

var numberOfMessages = 0;


function findSize() {
  //finds the size of the browser window
  var myWidth = 0, myHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    //Non-IE
    myWidth = window.innerWidth;
    myHeight = window.innerHeight;
  } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    //IE 6+ in 'standards compliant mode'
    myWidth = document.documentElement.clientWidth;
    myHeight = document.documentElement.clientHeight;
  } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    //IE 4 compatible
    myWidth = document.body.clientWidth;
    myHeight = document.body.clientHeight;
  }
  var size = { width: myWidth, height : myHeight };
  return size; 
}

function slideMessages()
{
	var messages = $(".notification");
	messages.each(function () {
		$(this).closest('.ui-dialog').animate( { top: "+=160"}, 500);
	});
}

function addNotification(title,message)
{
	//displays the notification
	
	//initialize our goodies
	var id='notification' + numberOfMessages;
	var html='<div id="' + id + '" class="notification"><span><center><br />' + message + '</center></span></div>';
	var t;
	var dialog;
	var messageHeight=160;
	var y=0;
	var size=findSize();
	var x=size.height - messageHeight;
	var defaultPosition=[y,x];
	var finalPosition=[];
		
	//set our id string
	id='#' + id;
	
	//add our html to the page
	$('#notificationArea').append(html);
	
	//if we have multiple messages on-screen
	if(numberOfMessages > 0)
	{
		//bind to the close event of the previous message, when it closes slide all messages down
		var lastSelector='#notification' + (numberOfMessages - 1);
		var lastMessage = $(lastSelector);
		var lastDialog=lastMessage.closest('.ui-dialog');
		lastDialog.bind("dialogclose", function (event,ui) { slideMessages(); });
		
		//calculate the position for our next message
		x=size.height - (messageHeight * (numberOfMessages + 1));
		finalPosition=[y,x];
	} else {
		finalPosition=defaultPosition;
	}
	
	//create our dialog
	dialog=$(id).dialog({
				dialogClass: 'simpleResults',
				autoOpen: false,
				position: finalPosition,
				stackable: 'true',
				resizable: false,
				modal: false,
				zIndex: 5000,
				title: title,
				width: 200,
				height: 100
			});
		

	
	
	//open our dialog
	dialog.dialog('open');
	
	
	
	//close it after 1.5 seconds
	t = setTimeout(function() { 
								numberOfMessages--;
								dialog.dialog('close');
								dialog.remove();
								
							  },3000);

//increment our global message counter
	numberOfMessages++;
	
}
