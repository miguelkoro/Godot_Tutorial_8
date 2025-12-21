extends VBoxContainer

@onready var currentState: BoardState = BoardState.new()
@export var init_depth = 4
@onready var arr_buttons: Array= [[$HBoxContainer_0/Button_0_0,$HBoxContainer_0/Button_0_1,$HBoxContainer_0/Button_0_2],
					[$HBoxContainer_1/Button_1_0,$HBoxContainer_1/Button_1_1,$HBoxContainer_1/Button_1_2],
					[$HBoxContainer_2/Button_2_0,$HBoxContainer_2/Button_2_1,$HBoxContainer_2/Button_2_2]]

func calculate_minmax(newState: BoardState, depth: int, minMax: bool = true) -> BoardState:
	var solutionValue: int = newState.evaluate_win()
	if solutionValue != 0 || depth == 0:
		return newState
		
	solutionValue = 99 #will be rewrited
	var solutionState:BoardState = null
	if minMax: #max
		for i in range(3):
			for j in range(3):
				if newState.get_pos(i,j) != 0:
					continue
					
				var testState:BoardState = BoardState.new()
				testState.state = newState.state.duplicate(true) #Duplicate node
				testState.set_pos(i,j,1)
				var resState:BoardState = calculate_minmax(testState, depth-1, false)
				if resState != null:
					var retVal:int = resState. evaluate_win()
					if (retVal > solutionValue || solutionValue == 99):
						solutionValue = retVal
						solutionState = testState
	else: #min
		for i in range(3):
			for j in range(3):
				if newState.get_pos(i,j) != 0:
					continue
					
				var testState: BoardState = BoardState.new()
				testState.state = newState.state.duplicate(true) #Duplicate node

				testState.set_pos(i,j,-1)
				var resState: BoardState = calculate_minmax(testState, depth-1, true)
				if resState != null:
					var retVal:int = resState. evaluate_win()
					if (retVal < solutionValue || solutionValue == 99) :
						solutionValue = retVal
						solutionState = testState
	return solutionState

func activate_button(x:int , y: int):
	currentState.set_pos(x,y,-1)
	if currentState.evaluate_win() == -1:
		print("YOU WIN")
		return
	#Enemy turn
	var newState:BoardState = calculate_minmax(currentState, init_depth)
	newState.evaluate_win()
	if newState != null:
		currentState = newState
	else:
		print ("empate")
		
	if currentState.evaluate_win() == 1:
		print("YOU LOSE!")

func update_visuals ():
	for i in range(3):
		for j in range(3):
			if currentState.get_pos(i,j) == -1:
				(arr_buttons[i][j] as Button).text = "X"
			elif currentState.get_pos(i, j) == 1:
				(arr_buttons[i][j] as Button).text = "0"


func _on_button_0_0_pressed() -> void:
	activate_button(0,0)
	update_visuals ()


func _on_button_0_1_pressed() -> void:
	activate_button(0,1)
	update_visuals ()

func _on_button_0_2_pressed() -> void:
	activate_button(0,2)
	update_visuals ()


func _on_button_1_0_pressed() -> void:
	activate_button(1,0)
	update_visuals ()


func _on_button_1_1_pressed() -> void:
	activate_button(1,1)
	update_visuals ()


func _on_button_1_2_pressed() -> void:
	activate_button(1,2)
	update_visuals ()


func _on_button_2_0_pressed() -> void:
	activate_button(2,0)
	update_visuals ()


func _on_button_2_1_pressed() -> void:
	activate_button(2,1)
	update_visuals ()


func _on_button_2_2_pressed() -> void:
	activate_button(2,2)
	update_visuals ()
