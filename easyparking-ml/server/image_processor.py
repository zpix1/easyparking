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

class MaskRCNNConfig(mrcnn.config.Config):
    NAME = "coco_pretrained_model_config"
    IMAGES_PER_GPU = 1
    GPU_COUNT = 1
    NUM_CLASSES = 1 + 80
    DETECTION_MIN_CONFIDENCE = 0.6


class ImageProcessor():
    def __init__(self):
        self.config = MaskRCNNConfig()

        # setup dirs
        self.ROOT_DIR = Path(".")
        self.MODEL_DIR = self.ROOT_DIR / "logs"
        self.COCO_MODEL_PATH = self.ROOT_DIR / "mask_rcnn_coco.h5"
        self.COCO_MODEL_PATH = r"mask_rcnn_coco.h5"
        if not os.path.exists(str(self.COCO_MODEL_PATH)):
            mrcnn.utils.download_trained_weights(self.COCO_MODEL_PATH)
        self.IMAGE_DIR = self.ROOT_DIR / "images"
        os.mkdir(self.IMAGE_DIR)

        # Load trained model
        self.model = MaskRCNN(mode="inference", model_dir=self.MODEL_DIR, config=self.config)
        self.model.load_weights(self.COCO_MODEL_PATH, by_name=True)
        
        self.parked_car_boxes = None

    def get_car_boxes(self, boxes, class_ids):
        car_boxes = []

        for i, box in enumerate(boxes):
            # Если найденный объект не автомобиль, то пропускаем его.
            if class_ids[i] in [3, 8, 6]:
                car_boxes.append(box)

        return np.array(car_boxes)

    def get_car_masks(self, masks, class_ids, r):
        car_masks = []

        for i in range(r['masks'].shape[2]):
            if class_ids[i] in [3, 8, 6]:
                car_masks.append(masks[:,:,i])

        return np.array(car_masks)

    def overlay(
        self,
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
        try:
            color = np.asarray(color).reshape(1, 1, 3)
        except ValueError:
            print(color)
            raise ValueError("")
        colored_mask = np.expand_dims(mask, 2).repeat(3, axis=2)
        masked = np.ma.MaskedArray(image, mask=colored_mask, fill_value=color)
        image_overlay = masked.filled()

        image_combined = cv2.addWeighted(image, 1 - alpha, image_overlay, alpha, 0)
        
        return image_combined

    def infer(self, frame, img_name):
        rgb_image = frame[:, :, ::-1]

        print("Running model", flush=True)
        results = self.model.detect([rgb_image], verbose=0)
        print("Finished model", flush=True)
        r = results[0]

        # Переменная r теперь содержит результаты распознавания:
        # - r['rois'] — ограничивающая рамка для каждого распознанного объекта;
        # - r['class_ids'] — идентификатор (тип) объекта;
        # - r['scores'] — степень уверенности;
        # - r['masks'] — маски объектов (что даёт вам их контур).

        car_boxes = self.get_car_boxes(r['rois'], r['class_ids'])
        car_masks = self.get_car_masks(r['masks'], r['class_ids'], r)

        print("Applying masks", flush=True)
        image_with_masks = rgb_image
        for mask in car_masks:
            image_with_masks = self.overlay(image_with_masks, mask)
        image_with_masks = Image.fromarray(image_with_masks)
        masks_path = img_name.replace(".jpg", "_masks.jpg")
        masks_path = os.path.join(self.IMAGE_DIR, masks_path)
        print("Saving masks", flush=True)
        image_with_masks.save(masks_path)

        print(f"Found {len(car_boxes)} cars")
        print("Cars found in frame of video:")

        for box in car_boxes:
            print("Car:", box)

            y1, x1, y2, x2 = box
            cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 1)

        img_output_path = img_name.replace(".jpg", "_processed.jpg")
        return masks_path
