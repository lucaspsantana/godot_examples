extends Area2D

signal captured

onready var trail = $Trail/Points

var velocity = Vector2(100,0) #valor inicial para teste
var jump_speed = 1000
var target = null  #Se estamos no circulo 
var trail_length = 25

func _unhandled_input(event): #funçao para detectar toque na tela
	if target and event is InputEventScreenTouch and event.pressed: #se estiver no circulo
		jump() # função para saltar

func jump(): #função de salto
	target.implode()
	target = null    #sair do circulo  
	velocity = transform.x * jump_speed #avançar o Jumper

func _on_Jumper_area_entered(area): #detecta um circulo com sinal de area entered
	target = area  #conecta-se
	target.get_node("Pivot").rotation = (position - target.position).angle() #começar a rodar no local atingido
	velocity = Vector2.ZERO #parmaos de avançar
	emit_signal("captured",area) #sinal será emitido quando o 
#jumper atingir o ciculo 

func _physics_process(delta):
	if trail.points.size() > trail_length:
		trail.remove_point(0)
	trail.add_point(position)
	if target: #se acertar o circulo giro em torno dele 
		transform = target.orbit_position.global_transform
	else: #senão, avançamos em linha reta 
		position += velocity * delta
