#/bin/bash

# chmod +x ./train_yolo.sh

image_name=yolo_trainer
tag=2.4.0-cuda12.4-cudnn9-runtime
container_name=yolo_trainer

dataset=stall
train_result_dir=stall
imgsz=640
batch_size=1
epochs=100
weight=yolov10n.pt
device=0

weight_path=/media/wgh-ubuntu/HDD2/Projects/weights/yolo/v10
dataset_path=/media/wgh-ubuntu/HDD1/data/datasets/test/${dataset}
train_result_path=/media/wgh-ubuntu/HDD2/Projects/train_results/yolo/runs



docker run --rm \
-it \
--gpus all \
-v ${dataset_path}:/home/appuser/yolo_trainer/datasets/${dataset} \
-v ${weight_path}:/home/appuser/yolo_trainer/weights \
-v ${train_result_path}:/home/appuser/yolo_trainer/runs \
-p 6006:6006 \
--shm-size 8G \
--name ${container_name} \
${image_name}:${tag} \
yolo train \
imgsz=${imgsz} \
batch=${batch_size} \
epochs=${epochs} \
data=datasets/${dataset}/${dataset}.yaml \
model=weights/${weight} \
name=${train_result_dir} \
device=${device}
