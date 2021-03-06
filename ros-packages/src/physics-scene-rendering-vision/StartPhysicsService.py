import os
import os.path as osp
import sys
import tempfile

if os.environ.get('BLENDER_PATH') == None:
    print("Please set BLENDER_PATH in bashrc!")
    sys.exit()

g_blender_executable_path = os.environ['BLENDER_PATH']

g_blank_blend_file_path = 'blank.blend'

# call blender to correct poses
blank_file = osp.join(g_blank_blend_file_path)
temp_dirname = tempfile.mkdtemp()

if str(sys.argv[1]) in 'shelf':
	print ('Loading Physics for shelf')
	pose_correct_code = osp.join('EnforcePhysicsShelf.py')
	
	pose_cmd = '%s %s -b --python %s -- %s %s' % \
	(g_blender_executable_path, blank_file, pose_correct_code, 'shelf', temp_dirname)
	os.system(pose_cmd)

elif str(sys.argv[1]) in 'table':
	print ('Loading Physics for table')
	pose_correct_code = osp.join('EnforcePhysicsTable.py')

	pose_cmd = '%s %s -b --python %s -- %s %s' % \
	(g_blender_executable_path, blank_file, pose_correct_code, 'table', temp_dirname)
	os.system(pose_cmd)
