extends Node

var wood_count: int = 0
signal wood_changed(new_amount)

func add_wood(amount):
	wood_count += amount
	wood_changed.emit(wood_count)
