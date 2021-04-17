# Docker�T�|�[�g

## Docker�C���[�W�̃r���h

1. �i�����A�܂��ł�������j�{���|�W�g���̃N���[��
```
$ git clone https://github.com/tsutof/tiny_yolov2_onnx_cam
```
2. �V�F���X�N���v�g�t�@�C���Ɏ��s������t�^
```
$ cd tiny_yolov2_onnx_cam

$ chmod +x ./scripts/*.sh
```
3. Jetson Nano�̓d�̓��[�h�����[�h0�ɂ��āA�N���b�N�A�b�v
```
$ sudo nvpmodel -m 0

$ sudo jetson_clocks
```
4. Docker�C���[�W�̃r���h
```
$ ./scripts/docker_build.sh
```

## �r���h����Docker�C���[�W����R���e�i���N��

```
$ ./scripts/docker_run.sh
```
**docker_run.sh** �͗�Ƃ��Ē񋟂��Ă��܂��B**/dev/video0** ���J�������͂Ƃ��Ă��܂����A���g�p�̊��ɍ��킹�ĕύX���Ă��������B

�R���e�i���̃V�F������A�ȉ��̃R�}���h�Ŗ{�A�v���P�[�V�������N���ł��܂��BESC�L�[�ŃA�v���P�[�V�������I�����܂��B

```
# python3 tiny_yolov2_onnx_cam.py [-h] [--camera CAMERA_NUM] [--csi]
                               [--width WIDTH] [--height HEIGHT]
                               [--objth OBJ_THRESH] [--nmsth NMS_THRESH]

optional arguments:
  -h, --help            show this help message and exit
  --camera CAMERA_NUM, -c CAMERA_NUM
                        Camera number
  --csi                 Use CSI camera
  --width WIDTH         Capture width
  --height HEIGHT       Capture height
  --objth OBJ_THRESH    Threshold of object confidence score (between 0 and 1)
  --nmsth NMS_THRESH    Threshold of NMS algorithm (between 0 and 1)
```

**exit** �ŁA�R���e�i����z�X�gOS�ɖ߂�܂��B
```
# exit
```

*[README.ja�ɖ߂�](../README.ja.md)*
