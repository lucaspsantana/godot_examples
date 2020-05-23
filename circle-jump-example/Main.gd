extends Node

var Circle = preload("res://objects/Circle.tscn") #instaciou Circle
var Jumper = preload("res://objects/Jumper.tscn") #instanciou Jumper

var player

func _ready():  #intanciou os dois objetos 
	randomize()
	new_game()

func new_game(): #código temporáro inicializa o game
	$Camera2D.position = $StartPosition.position
	player = Jumper.instance()
	player.position = $StartPosition.position
	add_child(player)
	player.connect("captured", self, "_on_Jumper_captured")
	spawn_circle($StartPosition.position)

func spawn_circle(_position=null):
	var c = Circle.instance()
	if !_position:
		var x = rand_range(-150, 150)
		var y = rand_range(-500, -400)
		_position = player.target.position + Vector2(x, y)
	add_child(c)
	c.init(_position)

func _on_Jumper_captured(object): #captura o sinal captured dos Jumper's
	$Camera2D.position = object.position #mover a camera pelo circulo
	object.capture()
	call_deferred("spawn_circle") #gera outro circulo
	#executa esta a função assim que for seguro executar


