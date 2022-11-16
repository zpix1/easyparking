import sys
from typing import Tuple
from PIL import Image
import numpy as np
import cv2
import mrcnn.config
import mrcnn.utils
import os
from mrcnn.model import MaskRCNN
from pathlib import Path


# Конфигурация, которую будет использовать библиотека Mask-RCNN.
class MaskRCNNConfig(mrcnn.config.Config):
    NAME = "coco_pretrained_model_config"
    IMAGES_PER_GPU = 1
    GPU_COUNT = 1
    NUM_CLASSES = 1 + 80  # в датасете COCO находится 80 классов + 1 фоновый класс.
    DETECTION_MIN_CONFIDENCE = 0.6


# Фильтруем список результатов распознавания, чтобы остались только автомобили.
def get_car_boxes(boxes, class_ids):
    car_boxes = []

    for i, box in enumerate(boxes):
        # Если найденный объект не автомобиль, то пропускаем его.
        if class_ids[i] in [3, 8, 6]:
            car_boxes.append(box)

    return np.array(car_boxes)


# Фильтруем список результатов распознавания, чтобы остались только автомобили.
def get_car_masks(masks, class_ids):
    car_masks = []

    for i in range(r['masks'].shape[2]):
        if class_ids[i] in [3, 8, 6]:
            car_masks.append(masks[:,:,i])

    return np.array(car_masks)

def overlay(
    image: np.ndarray,
    mask: np.ndarray,
    color: Tuple[int, int, int] = (255, 0, 0),
    alpha: float = 0.5
) -> np.ndarray:
    """Combines image and its segmentation mask into a single image.
    
    Params:
        image: Training image.
        mask: Segmentation mask.
        color: Color for segmentation mask rendering.
        alpha: Segmentation mask's transparency.
        resize: If provided, both image and its mask are resized before blending them together.
    
    Returns:
        image_combined: The combined image.
        
    """
    color = np.asarray(color).reshape(1, 1, 3)
    colored_mask = np.expand_dims(mask, 2).repeat(3, axis=2)
    masked = np.ma.MaskedArray(image, mask=colored_mask, fill_value=color)
    image_overlay = masked.filled()

    image_combined = cv2.addWeighted(image, 1 - alpha, image_overlay, alpha, 0)
    
    return image_combined

# Корневая директория проекта.
ROOT_DIR = Path(".")

# Директория для сохранения логов и обученной модели.
MODEL_DIR = ROOT_DIR / "logs"

# Локальный путь к файлу с обученными весами.
COCO_MODEL_PATH = ROOT_DIR / "mask_rcnn_coco.h5"

COCO_MODEL_PATH = r"mask_rcnn_coco.h5"

# Загружаем датасет COCO при необходимости.
if not os.path.exists(str(COCO_MODEL_PATH)):
    mrcnn.utils.download_trained_weights(COCO_MODEL_PATH)

# Директория с изображениями для обработки.
IMAGE_DIR = ROOT_DIR / "images"

# Создаём модель Mask-RCNN в режиме вывода.
model = MaskRCNN(mode="inference", model_dir=MODEL_DIR, config=MaskRCNNConfig())

# Загружаем предобученную модель.
model.load_weights(COCO_MODEL_PATH, by_name=True)

# Местоположение парковочных мест.
parked_car_boxes = None

if len(sys.argv) < 2:
    print(f"Usage: script path_to_image")
    exit(1)

img_path = os.path.abspath(sys.argv[1])
print(f"Processing image {img_path}")
frame = cv2.imread(img_path)

# Конвертируем изображение из цветовой модели BGR (используется OpenCV) в RGB.
rgb_image = frame[:, :, ::-1]

# Подаём изображение модели Mask R-CNN для получения результата.
results = model.detect([rgb_image], verbose=0)

# Mask R-CNN предполагает, что мы распознаём объекты на множественных изображениях.
# Мы передали только одно изображение, поэтому извлекаем только первый результат.
r = results[0]

# Переменная r теперь содержит результаты распознавания:
# - r['rois'] — ограничивающая рамка для каждого распознанного объекта;
# - r['class_ids'] — идентификатор (тип) объекта;
# - r['scores'] — степень уверенности;
# - r['masks'] — маски объектов (что даёт вам их контур).

# Фильтруем результат для получения рамок автомобилей.

car_boxes = get_car_boxes(r['rois'], r['class_ids'])
car_masks = get_car_masks(r['masks'], r['class_ids'])

image_with_masks = rgb_image
for mask in car_masks:
    image_with_masks = overlay(image_with_masks, mask)
image_with_masks = Image.fromarray(image_with_masks)
image_with_masks.save("masks.jpg")

print(f"Found {len(car_boxes)} cars")
print("Cars found in frame of video:")

# Отображаем каждую рамку на кадре.
for box in car_boxes:
    print("Car:", box)

    y1, x1, y2, x2 = box

    # Рисуем рамку.
    cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 1)

# Показываем кадр на экране.
# cv2.imshow('Video', frame)
cv2.imwrite("out.jpg", frame)
