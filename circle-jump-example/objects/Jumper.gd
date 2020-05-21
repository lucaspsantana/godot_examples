extends Area2D

var velocity = Vector2(100,0) #valor inicial para teste
var jump_speed = 1000
var target = null  #Se estamos no circulo 

func _unhandled_input(event): #funçao para detectar toque na tela
	if target and event is InputEventScreenTouch and event.pressed: #se estiver no circulo
		jump() # função para saltar

func jump(): #função de salto
	target = null    #sair do circulo  
	velocity = transform.x * jump_speed #avançar a vel de salto

func _on_Jumper_area_entered(area): #detecta um circulo com sinal de area entered
	target = area  #conecta-se
	velocity = Vector2.ZERO #parmaos de avançar

func _physics_process(delta):
	if target: #se acertar o circulo giro em torno dele 
		transform = target.orbit_position.global_transform #
	else: #senão, avançamos em linha reta 
		position += velocity * delta
