import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Timeline 1.0


ApplicationWindow {
    visible: true
    width: 800
    height: 400
	//flags: Qt.Window | Qt.WindowMaximized
	property int counterValue: 0
	property int val: 0
	property var turn : "N"
	//Set Background for the cluster
	Image {
		id: background
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		width: parent.width
		height:parent.height
		source: "assets/bg.jpg"
	}
	//Start the cluster by removing the opening GIF
	Timer {
		id: bgtimer
		interval : 700
		repeat: true
		running: true
		onTriggered: {
			firstbackground.opacity = (firstbackground.opacity>0)?firstbackground.opacity-0.2:(firstbackground.visible = false,running = false);
		}
	}

//Speedometer 	
	Item {
		id: speedDial
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
	    Image {
			id: dialImage
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			width: 350
			height:350
			source: "assets/speed_dial.png"
		}
	}
	
	Item {
		id: digitalSpeed
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
	    Image {
			id: digitalImage
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			width: 100
			height:100
			source: "assets/speed_dial_195_151.png"
		}
        Text {
            id: speedValue
			font.bold : true
            text: counterValue.toString()
            font.pixelSize: 25
            anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottom : parent.bottom
			color:"green"
        }
		Text {
            id: kphText
			font.bold : true
			font.italic :true
            text: "KPH"
            font.pixelSize: 25
            anchors.horizontalCenter: parent.horizontalCenter
			anchors.top : parent.top
			color:"white"
        }

	}
	Item {
		id: speedNeedle
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		Image {
			id: needleImage
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			source: "assets/speedometer_needle_195_142.png"
			rotation: 180
			transformOrigin: Item.BottomLeft
		}
	}
//Speedometer ends

//Fuel indicator
	Item {
		id: fuelDial
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		Image {
			id: fuelImage
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			width: 200
			height:200
			source: "assets/fuel.png"
		}
	}
	Item {
		id: fuelNeedle
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		Image {
			id: fneedleImage
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			width: 60
			height:150
			source: "assets/speedometer_needle_195_142.png"
			rotation: -20
			transformOrigin: Item.BottomLeft
		}
	}	
	Item {
		id: fuelDial1
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		Image {
			id: fuelImage1
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			width: 100
			height:100
			source: "assets/fuel_dial.png"
		}
	}
	Item {
		id: yellowFuel
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		visible:true
		Image {
			id: yellowLight
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			width: 50
			height:70
			source: "assets/yellow_fuel_light.png"	
		}
	}		
	Item {
		id: redFuel
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		visible:false
		Image {
			id: redLight
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			width: 50
			height:70
			source: "assets/red_fuel_light.png"
		}
	}

//Fuel indicator end
		
//Gear indicator
	Item {
		id: gearBox
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom	
		width:10
		height: 50
		Text {
            id: gearValue
			font.bold : true
			text:{
				switch(val){
					case 1: return "1"
					case 2: return "2"
					case 3: return "3"
					case 4: return "4"
					case 5: return "5"
					default: return "0"
				}
			}
            font.pixelSize: 25
            anchors.fill : parent
			color:"white"
        }
	}
	
	function gearChange()
	{
		if(counterValue<20 && counterValue>0)val=1;
		else if (counterValue<40 && counterValue>20)val=2;
		else if (counterValue<60 && counterValue>40)val=3;
		else if (counterValue<80 && counterValue>60)val=4;
		else if (counterValue>80)val=5;
		else if (counterValue==0)val=0;
	}

//Gear indicator ends

//Turn indicator
	Item {
		id: leftIndicator
		anchors
		{
			top: parent.top
			left: parent.left
		}
		width:100
		height: 100
     	Image {
			id: leftArrow
			anchors.fill: parent
			source: "assets/left.png"	
		}       
		MouseArea {
            id: leftMouseArea
            width: parent.width
            height: parent.height
            // Mouse events
            onClicked: {
				if(turn != 'L'){
					turn = 'L';
					turntimer.running = true;
					rightIndicator.visible = true;
				}
				else {
					turn='N'
					turntimer.running = false
				}
			}
		}
	}
	Item {
		id: rightIndicator
		anchors
		{
			top: parent.top
			right: parent.right
		}
		width:100
		height: 100
     	Image {
			id: rightArrow
			anchors.fill: parent
			source: "assets/right.png"
		} 
		MouseArea {
            id: rightMouseArea
            width: parent.width
            height: parent.height
            // Mouse events
            onClicked: {
				if(turn != 'R'){
					turn = 'R';
					turntimer.running = true;
					leftIndicator.visible = true;
				}
				else {
					turn='N'
					turntimer.running = false
				}
			}
		}		
	}

	Timer {
		id: turntimer
		interval : 300
		repeat: true
		running: true
		onTriggered: {
			if(turn == 'L')
			{
				leftIndicator.visible = !leftIndicator.visible;
			}
			else if(turn == 'R')
			{
				rightIndicator.visible = !rightIndicator.visible;
			}
		}
	}
//Turn indicator ends

	Timer {
		id: moveTimer
		interval: 100 
		repeat: true
		running: false
	
		onTriggered: {
			speedNeedle.rotation = (speedNeedle.rotation<250)?speedNeedle.rotation+10:250
			fuelNeedle.rotation = (fuelNeedle.rotation<82)?fuelNeedle.rotation+1:82
			if(fuelNeedle.rotation>62){
				redFuel.visible = true
				yellowFuel.visible = false
			}
			if(fuelNeedle.rotation==82){
				accelerate.visible = false;
				moveTimer1.running = true;
				running = false;
			}
			counterValue = (counterValue<250)?counterValue+10:250;
			speedValue.text = counterValue.toString();
			speedValue.color = (counterValue<80)?speedValue.color:"red";
			gearChange()		
		}
    }
	Timer {
		id: moveTimer1
		interval: 100 
		repeat: true
		running: false
	
		onTriggered: {
			speedNeedle.rotation = (speedNeedle.rotation>0)?speedNeedle.rotation-10:0
			counterValue = (counterValue>0)?counterValue-10:0;
			speedValue.text = counterValue.toString();
			speedValue.color = (counterValue>80)?speedValue.color:"green";
			gearChange()
		}
    }
	//Accelerate button
	Button {
			id: accelerate
            anchors.bottom:parent.bottom
			anchors.right: parent.right
			width:40
			height:80
			onPressed: {
				moveTimer1.running = false;
				moveTimer.running = true;
				
			}

			onReleased: {
				moveTimer.running = false;
				moveTimer1.running = true;
				
			}
			Image {
					id: background4
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
					width: parent.width
					height:parent.height
					source: "assets/accelerator.png"
			}
    }
	//Opening GIF
	AnimatedImage  {
		id: firstbackground
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		width: parent.width
		height:parent.height
		source: "assets/bg4.gif"
	}
}
