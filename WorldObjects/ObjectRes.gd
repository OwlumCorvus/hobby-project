extends Resource
class_name ObjectResource

@export var obj_name: String
@export_multiline var obj_desc: String
@export var obj_locations: Array[String] # Change string to Location Resource
@export var obj_items: Array[ItemData]
@export var obj_capacity: int
@export var obj_exp_given: float
 # @export var obj_lvl_required: int
@export var obj_wait_time_depleted: float
@export var obj_wait_time_action: float
@export var obj_sprites: Array[Texture2D]
@export var obj_sounds: String # Change string to Array[audio type]
@export var obj_animations: String # Change string to sprite sheet
