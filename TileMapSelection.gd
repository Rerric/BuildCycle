extends TileMap

const main_layer = 0
const main_atlus_id = 6
var is_night = false
var buildingSelect = 0

#building variable
var building = preload("res://Building.tscn")
var skyscraper = preload("res://Skyscraper.tscn")

#handle input
func _input(event):
	#quits the game
	if Input.is_key_pressed(KEY_ESCAPE): 
		get_tree().quit()
		
	#swaps between night and day
	if event is InputEventKey:
		if event.keycode == KEY_N and event.is_pressed() and !event.is_echo():
			if is_night:
				is_night = false
			else: is_night = true
			print("It's nighttime? ", is_night)
			swap()
		if event.keycode == KEY_1 and event.is_pressed() and !event.is_echo():
			buildingSelect = 0
		if event.keycode == KEY_2 and event.is_pressed() and !event.is_echo():
			buildingSelect = 1
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))
			
			print(pos_clicked)
			
			var current_atlas_coords = get_cell_atlas_coords(main_layer, pos_clicked)
			
			var cell_clicked = map_to_local(pos_clicked)
			print(cell_clicked)
			#object as child node instantiation failed commented out
			#var object = preload("res://Object.tscn")
			#var instance = object.instantiate()
			#positoning required here (?)
			#add_child(instance)
			
			#calling instantiate function, currently spawns house shifted too far down and right
			# & doesnt go away when clicked again
			
			var current_tile_alt = get_cell_alternative_tile(main_layer, pos_clicked)
			var number_of_alts_for_clicked = tile_set.get_source(main_atlus_id)\
						.get_alternative_tiles_count(current_atlas_coords)
						
			if (current_tile_alt == 0): 
				#set_cell(main_layer, pos_clicked, main_atlus_id, current_atlas_coords, 
						#(current_tile_alt + 1) % number_of_alts_for_clicked)
				inst(cell_clicked)
				print("Created Tile")
				
						
#instantiate function
func inst(pos):
	var instance = building.instantiate()
	instance.position = pos
	instance.get_script()
	instance.current_sprite = buildingSelect
	add_child(instance)

func swap():
	#put night/day functionality here
	var alt_id = 0
	if !is_night: alt_id = 2
	var tile_map = get_used_cells(main_layer)
	var tile_to_swap = Vector2i(alt_id,0)
	for i in tile_map:
		set_cell(main_layer, i, main_atlus_id, tile_to_swap)
