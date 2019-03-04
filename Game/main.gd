extends Node2D
var bu = false
var bd = false
var ru = false
var rd = false 

var time = 0
var cap = "START SHOOTING!"
var laser = preload("res://laser.xml")
var laserCount = 0
var laserArray = []

var laser2 = preload("res://p2laser.xml")
var laserCount2 = 0
var laserArray2 = []

var p1Pressed = false
var p2Pressed = false

var p1LastFired = -999
var p2LastFired = -999
var score1 = 0
var score2 = 0
var counter = 0
var arrnum = [639, 469, 320, 569, 700, 370, 450, 459, 500,516,308,338,669,634,393,739,720,532,578,312,365,726,488,540,529,663,596,692,570,447,331,650,495,301,572,669,389,682,382,494,696,620,546,581,612,333,727,738,661,662,662,493,625,328,470,528,718]
var arrint = 0
func _ready():
	set_process(true)
	get_node("score1").set_text(str(score1))
	get_node("score2").set_text(str(score2))
	get_node("caption").set_text(cap)
	

func _process(delta):
	counter = counter + 1	
	if counter == 800:
		var pupPos = get_node("triplepup").get_pos()
		pupPos.y = arrnum[arrint]
		arrint = arrint + 1
		get_node("triplepup").set_pos(pupPos)
		get_node("triplepup").show()
		counter = 0
		var buPos = get_node("blueup").get_pos()
		buPos.y= pupPos.y -30
		buPos.x= pupPos.x -30
		get_node("blueup").set_pos(buPos)
		
		var bdPos = get_node("bluedown").get_pos()
		bdPos.y= pupPos.y +30
		bdPos.x= pupPos.x -30
		get_node("bluedown").set_pos(bdPos)
		
		var ruPos = get_node("redup").get_pos()
		ruPos.y= pupPos.y -30
		ruPos.x= pupPos.x +30
		get_node("redup").set_pos(ruPos)
		
		var rdPos = get_node("reddown").get_pos()
		rdPos.y= pupPos.y +30
		rdPos.x= pupPos.x +30
		get_node("reddown").set_pos(rdPos)
	
	time = time + delta
	var cooldown = 0.5
	
	if Input.is_action_pressed("1fire") && time>(p1LastFired+cooldown) && score1 < 3 && score2 < 3:
		if p1Pressed == false:
			p1Fire()
			p1LastFired = time
			p1Pressed = true
	else:
		p1Pressed = false
	
	if Input.is_action_pressed("2fire") && time>(p2LastFired+cooldown) && score1 < 3 && score2 < 3:
		if p2Pressed == false:
			p2Fire()
			p2LastFired= time
			p2Pressed = true
	else:
		p2Pressed = false
	
	var p1Pos = get_node("p1").get_pos()
	
	if Input.is_action_pressed("1down") && p1Pos.y<805  && score1 < 3 && score2 < 3:
		p1Pos.y  = p1Pos.y + 500 * delta
	
	if Input.is_action_pressed("1up")&& p1Pos.y>250 && score1 < 3 && score2 < 3:
		p1Pos.y  = p1Pos.y - 500 * delta
	
	get_node("p1").set_pos(p1Pos)
	
	var p2Pos = get_node("p2").get_pos()

	if Input.is_action_pressed("2down")&& p2Pos.y<805  && score1 < 3 && score2 < 3:
		p2Pos.y  = p2Pos.y + 500 * delta
		
	if Input.is_action_pressed("2up")&& p2Pos.y>250 && score1 < 3 && score2 < 3:
		p2Pos.y  = p2Pos.y - 500 * delta

	get_node("p2").set_pos(p2Pos)
	
	var laserid = 0
	for laser in laserArray:
		var pupPos = get_node("triplepup").get_pos()
		var laserPos = get_node(laser).get_pos()
		laserPos.x= laserPos.x + 1200 *delta
		get_node(laser).set_pos(laserPos)
		if laserPos.x >= pupPos.x-30 && laserPos.x <= pupPos.x + 30 && laserPos.y <pupPos.y +30 && laserPos.y >pupPos.y -30 && get_node("triplepup").is_visible() == true:
			ru=true
			get_node("redup").show()
			rd=true
			get_node("reddown").show()
			get_node("triplepup").hide()
		if laserPos.x >1397 && laserPos.x <1409 && laserPos.y < p2Pos.y+40 && laserPos.y > p2Pos.y-40:
			get_node("FireSound").play("LOUD CRASH SOUND EFFECT")
			score1 = score1 + 1
			get_node("score1").set_text(str(score1))
			get_node("caption").set_text("PLAYER 1 SCORES")
	
		if laserPos.x>1440:
			remove_child(get_node(laser))
			laserArray.remove(laserid)
		laserid = laserid + 1
	
	var laserid2 = 0
	for laser2 in laserArray2:
		var pupPos = get_node("triplepup").get_pos()
		var laserPos2 = get_node(laser2).get_pos()
		laserPos2.x= laserPos2.x - 1200 *delta
		get_node(laser2).set_pos(laserPos2)
		if laserPos2.x <= pupPos.x+30 && laserPos2.x >= pupPos.x-30&& laserPos2.y <pupPos.y +30 && laserPos2.y >pupPos.y -30&& laserPos2.y >pupPos.y -30 && get_node("triplepup").is_visible() == true:
			bu=true
			get_node("blueup").show()
			bd=true
			get_node("bluedown").show()
			get_node("triplepup").hide()
		if laserPos2.x >31 && laserPos2.x <43 && laserPos2.y < p1Pos.y+40 && laserPos2.y > p1Pos.y-40:
			get_node("FireSound1").play("LOUD CRASH SOUND EFFECT")
			score2 = score2 + 1
			get_node("score2").set_text(str(score2))
			get_node("caption").set_text("PLAYER 2 SCORES")
		if laserPos2.x<0:
			remove_child(get_node(laser2))
			laserArray2.remove(laserid2)
		laserid2 = laserid2 + 1

	if ru==true:
		var p2Pos = get_node("p2").get_pos()
		var ruPos = get_node("redup").get_pos()
		ruPos.x = ruPos.x + 1200 * delta
		ruPos.y = ruPos.y - 450 * delta
		get_node("redup").set_pos(ruPos)
		if ruPos.y < 250 or ruPos.x > 1400:
			ru = false
			get_node("redup").hide()
		if  ruPos.x >1394 && ruPos.x <1412 && ruPos.y < p2Pos.y+40 && ruPos.y > p2Pos.y-40:
			get_node("FireSound").play("LOUD CRASH SOUND EFFECT")
			score1 = score1 + 1
			get_node("score1").set_text(str(score1))
			get_node("caption").set_text("PLAYER 1 SCORES")
		
	if rd==true:
		var p2Pos = get_node("p2").get_pos()
		var rdPos = get_node("reddown").get_pos()
		rdPos.x = rdPos.x + 1200 * delta
		rdPos.y = rdPos.y + 450 * delta
		get_node("reddown").set_pos(rdPos)
		if rdPos.y > 805 or rdPos.x > 1400:
			rd = false
			get_node("reddown").hide()
		if rdPos.x >1394 && rdPos.x <1412 && rdPos.y < p2Pos.y+40 && rdPos.y > p2Pos.y-40:
			get_node("FireSound").play("LOUD CRASH SOUND EFFECT")
			score1 = score1 + 1
			get_node("score1").set_text(str(score1))
			get_node("caption").set_text("PLAYER 1 SCORES")
		
	if bu==true:
		var p1Pos = get_node("p1").get_pos()
		var buPos = get_node("blueup").get_pos()
		buPos.x = buPos.x - 1200 * delta
		buPos.y = buPos.y - 450 * delta
		get_node("blueup").set_pos(buPos)
		if buPos.y <250 or buPos.x <40:
			bu = false
			get_node("blueup").hide()
		if buPos.x >28 && buPos.x <46 && buPos.y < p1Pos.y+40 && buPos.y > p1Pos.y-40:
			get_node("FireSound1").play("LOUD CRASH SOUND EFFECT")
			score2 = score2 + 1
			get_node("score2").set_text(str(score2))
			get_node("caption").set_text("PLAYER 2 SCORES")
		

	if bd==true:
		var p1Pos = get_node("p1").get_pos()
		var bdPos = get_node("bluedown").get_pos()
		bdPos.x = bdPos.x - 1200 * delta
		bdPos.y = bdPos.y + 450 * delta
		get_node("bluedown").set_pos(bdPos)
		if bdPos.y > 805 or bdPos.x <40:
			bd = false
			get_node("bluedown").hide()
		if bdPos.x >28 && bdPos.x <46 && bdPos.y < p1Pos.y+40 && bdPos.y > p1Pos.y-40:
			get_node("FireSound1").play("LOUD CRASH SOUND EFFECT")
			score2 = score2 + 1
			get_node("score2").set_text(str(score2))
			get_node("caption").set_text("PLAYER 2 SCORES")
		
	if score1 == 3 || score2 == 3:
		if score1 == 3:
			get_node("caption").set_text("PLAYER 1 WINS!!")
		else:
			get_node("caption").set_text("PLAYER 2 WINS!!")
		for temp1 in laserArray:
			remove_child(get_node(temp1))
			laserArray.remove(temp1)
			
		for temp2 in laserArray2:
			remove_child(get_node(temp2))
			laserArray2.remove(temp2)
			
		laserArray = []
		laserArray2 = []
	if Input.is_action_pressed("restart") && (score1 == 3 || score2 == 3):
		score1 = 0
		score2 = 0
		get_node("score1").set_text(str(score1))
		get_node("score2").set_text(str(score2))
		get_node("caption").set_text(cap)
		p1Pos.y = 450
		get_node("p1").set_pos(p1Pos)
		p2Pos.y = 450
		get_node("p2").set_pos(p2Pos)
		

func p1Fire():
	get_node("FireSound").play("Laser-gun-sound-effect-2")
	laserCount = laserCount + 1
	var laser_instance = laser.instance()
	laser_instance.set_name("laser" + str(laserCount))
	add_child(laser_instance)
	var laserPos = get_node("laser" + str(laserCount)).get_pos()
	var p1Pos = get_node("p1").get_pos()
	laserPos.y= p1Pos.y
	laserPos.x=40
	get_node("laser"+ str(laserCount)).set_pos(laserPos)
	laserArray.push_back("laser"+ str(laserCount))
	print(laserArray)
	
func p2Fire():
	get_node("FireSound1").play("Laser-gun-sound-effect-2")
	laserCount2 = laserCount2 + 1
	var laser_instance2 = laser2.instance()
	laser_instance2.set_name("laser2" + str(laserCount2))
	add_child(laser_instance2)
	var laserPos2 = get_node("laser2" + str(laserCount2)).get_pos()
	var p2Pos = get_node("p2").get_pos()
	laserPos2.y= p2Pos.y
	laserPos2.x=1400
	get_node("laser2"+ str(laserCount2)).set_pos(laserPos2)
	laserArray2.push_back("laser2"+ str(laserCount2))
	print(laserArray2)