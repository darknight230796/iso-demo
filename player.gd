extends CharacterBody2D

const SPEED = 150
const INVERTED_SPEED = -150
var history = PackedVector2Array()
var isInverted = false
var currentAnim = 'idle'
var animDir = '0'
var animPlayDir = 1

func _physics_process(delta):
	if isInverted:
		if history.size() <= 1:
			isInverted = true
			return
		var direction = history[-1]
		print(direction)
		animPlayDir = -1
		history.remove_at(history.size() -1)
		if direction:
			self.velocity =  direction * INVERTED_SPEED
			currentAnim = 'run'
			getAnimDir(direction.x,direction.y)
		else:
			self.velocity = Vector2.ZERO
			currentAnim = 'idle'
	else:
		var direction =  Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		history.push_back(direction)
		if direction:
			self.velocity =  direction * SPEED
			currentAnim = 'run'
			getAnimDir(direction.x,direction.y)
		else:
			self.velocity = Vector2.ZERO
			currentAnim = 'idle'
	$AnimatedSprite2D.play(currentAnim+animDir,animPlayDir)
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("invertTime"):
		back()
	
func back():
	print("back")
	isInverted=true
	
func getAnimDir(x,y):
	if x==0 && y>0:
		animDir = '0'
	elif x>0 && y>0:
		animDir = '1'
	elif x>0 && y==0:
		animDir = '2'
	elif x>0 && y<0:
		animDir = '3'
	elif x==0 && y<0:
		animDir = '4'
	elif x<0 && y<0:
		animDir = '5'
	elif x<0 && y==0:
		animDir = '6'
	elif x<0 && y>0:
		animDir = '7'
