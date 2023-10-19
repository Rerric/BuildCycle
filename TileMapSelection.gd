extends TileMap

const main_layer = 0
const main_atlus_id = 6

#building variable
var building = preload("res://Building.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))
			print(pos_clicked)
			var current_atlas_coords = get_cell_atlas_coords(main_layer, pos_clicked)
			#object as child node instantiation failed commented out
			#var object = preload("res://Object.tscn")
			#var instance = object.instantiate()
			#positoning required here (?)
			#add_child(instance)
			
			#calling instantiate function, currently spawns house shifted too far down and right
			# & doesnt go away when clicked again
			inst(event.position)
			
			var current_tile_alt = get_cell_alternative_tile(main_layer, pos_clicked)
			var number_of_alts_for_clicked = tile_set.get_source(main_atlus_id)\
						.get_alternative_tiles_count(current_atlas_coords)
						
			set_cell(main_layer, pos_clicked, main_atlus_id, current_atlas_coords, 
						(current_tile_alt + 1) % number_of_alts_for_clicked)
						
#instantiate function
func inst(pos):
	var instance = building.instantiate()
	instance.position = pos
	add_child(instance)
