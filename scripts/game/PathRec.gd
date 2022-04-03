extends Spatial

onready var line_geom = $LineGeom

var line_verts = []
var vertices = []
var enemy_poses = []
var path_color = Color(2,1.749,1.412)

func _ready():
	pass

func _physics_process(delta):
	pass
	
func add_player_pos(vert):
	if line_verts == []:
		line_verts = [vert]
	vertices.append(vert)

func drawline(verts):
	line_geom.clear()
	line_geom.begin(Mesh.PRIMITIVE_LINES)
	line_geom.set_color(path_color)
	for vertex in verts:
		line_geom.add_vertex(vertex)
	line_geom.end()
	
func get_enemy_positions():
	$EnemyPosSaveTimeout.stop()
	$DrawTimer.stop()
	return enemy_poses

func get_path():
	return vertices

func _on_EnemyPosSaveTimeout_timeout():
	enemy_poses.append(vertices.back())
	$EnemyPosSaveTimeout.start(Global.rng.randf_range(1.5, 2.5))

func _on_StartTime_timeout():
	$EnemyPosSaveTimeout.start(Global.rng.randf_range(1.5, 2.5))

func _on_DrawTimer_timeout():
	line_verts.append(vertices.back())
	line_verts.append(vertices.back())
	drawline(line_verts)
