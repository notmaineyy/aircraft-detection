# Final Year BEng Project on Aircraft Detection and Classification with Deep Learning

## Project Overview
Object detection is a crucial capability in computer vision, enabling machines to locate and classify objects of interest. This project focuses on aircraft detection using deep learning for applications in airspace security and traffic management. Traditional Identification Friend or Foe (IFF) systems using radar are susceptible to jamming, motivating the exploration of image-based automatic aircraft recognition (AAR).

A key challenge lies in acquiring sufficient training data for deep learning models. This project addresses this by proposing a two-pronged approach: data augmentation and image compositing. Data augmentation involves generating synthetic variations of existing images, while image compositing combines elements from multiple images to create new, diverse training scenarios.

This project aims to develop a robust deep learning model for AAR that can accurately detect and classify (military vs. commercial) aircraft using ground-based cameras. You Only Look Once (YOLO) and Region-based Convolutional Neural Network (R-CNN) models will be trained to identify the best performing model for deployment. 

A mobile application will be developed to integrate the chosen high-performance model, enabling real-time aircraft detection on mobile devices. This user-friendly application will request camera access and leverage the embedded model to process images, displaying bounding boxes and class labels around detected aircraft directly on the user interface.

## Description

This repository contains code and resources for various aircraft detection models and data generation techniques. The models included are YOLOv5, YOLOv8, and Faster R-CNN. The repository also includes scripts for generating synthetic data for training and testing the models.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/notmaineyy/aircraft-detection.git
    ```
2. Navigate to the project directory:
    ```bash
    cd aircraft-detection
    ```

## Usage

### YOLOv5

Navigate to the YOLOv5 directory and follow the instructions in the README file located there to train and test the YOLOv5 model.

### YOLOv8

Navigate to the YOLOv8 directory and follow the instructions in the README file located there to train and test the YOLOv8 model.

### Faster R-CNN

Navigate to the faster-rcnn directory and follow the instructions in the README file located there to train and test the Faster R-CNN model.

### Data Generation

The `data-generation` directory contains Jupyter notebooks for generating synthetic data. Refer to the README file located there for specific instructions.

### Object Detection

The `object_detection` directory contains the code for the mobile application. Follow the instructions in the README file located there to test the mobile app.
