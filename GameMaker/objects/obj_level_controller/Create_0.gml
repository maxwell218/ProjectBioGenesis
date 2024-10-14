/// @description Initialize Our Grid
cell_width = 16;
cell_height = 16;
 
grid_width = room_width/cell_width;
grid_height = room_height/cell_height;

grid = mp_grid_create(0, 0, grid_width, grid_height, cell_width, cell_height);

mp_grid_add_instances(grid, obj_solid, false);