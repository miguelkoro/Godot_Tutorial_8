class_name BoardState

var state := [[0,0,0],[0,0,0],[0,0,0]]

func get_pos(x:int, y:int)->int:
	return state[x][y]
	
func set_pos(x:int, y:int, value:int)->void:
	state[x][y] = value
	
func evaluate_win()->int: #-1, 0 or 1.
	
	var victory:bool
	#Horizontal test
	for i in range(3):
		victory= state[i][0] == state[i][1] && state[i][1] == state[i][2]
		if victory && state[i][0]!=0:
			return state[i][0]
			
	#Vertical test
	for i in range(3):
		victory = state[0][i] == state[1][i] && state[1][i] == state[2][i]
		if victory && state[0][i]!=0:
			return state[0][i]
			
	victory = state[0][0] == state[1][1] && state[1][1] == state[2][2]
	if victory && state[1][1]!=0:
		return state[1][1]
		
	victory = state[0][2] == state[1][1] && state[1][1] == state[2][0]
	if victory && state[1][1]!=0:
		return state[1][1]
		
	return 0
