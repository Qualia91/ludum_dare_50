extends Node

func load_data_unencrypted(data_file) -> Dictionary:
	var f := File.new()
	f.open(data_file, File.READ)
	var result := JSON.parse(f.get_as_text())
	f.close()

	if result.error != 0:
		printerr("Failed to parse save file: ", f.error_string)
	return result.result as Dictionary

func load_data(data_file) -> Dictionary:
	var f := File.new()
	f.open_encrypted_with_pass(data_file, File.READ, "happy_bday_ludum_dare")
	var result := JSON.parse(f.get_as_text())
	f.close()

	if result.error != 0:
		printerr("Failed to parse save file: ", f.error_string)
	return result.result as Dictionary
	
func save_data(data_file, data):
	var save_file = File.new()
	save_file.open_encrypted_with_pass(data_file, File.WRITE, "happy_bday_ludum_dare")
	save_file.store_line(to_json(data))
	save_file.close()
	
func does_file_exist(data_file):
	var f := File.new()
	return f.file_exists(data_file)
