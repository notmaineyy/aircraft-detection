# YOLOv5 Model Training

This directory contains the Jupyter Notebook used to train the YOLOv5 model with the aircraft dataset and the folder of results of various YOLOv5s models trained with different hyperparameters and optimisers. 
Below is a detailed structure and description of the contents within the `yolov5s_results` directory.

## YOLOv5 Models Trained
This is the list of models that can be found in the `yolov5s_results` folder.

1. `AdamW/`: Model trained with AdamW optimiser
2. `SGD_final/`: Model trained with SGD optimiser
3. `hyp1/`: Model trained with weight_decay: 0.001, momentum: 0.99, batch_size: 64
4. `hyp2/`: Model trained with weight_decay: 0.01, momentum: 0.9, batch_size: 32
5. `hyp3/`: Model trained with weight_decay: 0.001, momentum: 0.9, batch_size: 64
6. `hyp4/`: Model trained with weight_decay: 0.1, momentum: 0.96, batch_size: 64
7. `hyp5/`: Model trained with weight_decay: 0.01, momentum: 0.93, batch_size: 32
8. `hyp6/`: Model trained with weight_decay: 0.01, momentum: 0.96, batch_size: 64
9. `hyp7/`: Model trained with weight_decay': 0.1, momentum: 0.99, batch_size: 32
10. `hyp8/`: Model trained with weight_decay': 0.1, momentum: 0.9, batch_size: 32
11. `hyp9/`: Model trained with weight_decay': 0.001, momentum: 0.96, batch_size: 16
12. `hyp10/`: Model trained with weight_decay': 0.001, momentum: 0.93, batch_size: 32
13. `hyp11/`: Model trained with weight_decay': 0.1, momentum: 0.99, batch_size: 16
14. `hyp12/`: Model trained with weight_decay': 0.01, momentum: 0.99, batch_size: 64
15. `hyp13/`: Model trained with weight_decay': 0.1, momentum: 0.9, batch_size: 16
16. `hyp14/`: Model trained with weight_decay': 0.01, momentum: 0.93, batch_size: 16
17. `hyp15/`: Model trained with weight_decay': 0.001, momentum: 0.93, batch_size: 64
18. `final_run/`: Final model used. Trained with weight_decay': 0.001, momentum: 0.93, batch_size: 32, epochs: 56

## Description
The `yolov5s_results` includes the results from training YOLOv5s models using various configurations. Each subdirectory within `yolov5s_results` represents a model trained with specific hyperparameters and an optimiser.

Each folder contains the results of a YOLOv5s model trained. Below is a description of the key files and directories within this folder:

- `weights/`: Directory containing the model weight files.
- `F1_curve.png`: Precision-Recall curve showing the F1 score over different confidence thresholds.
- `PR_curve.png`: Precision-Recall curve.
- `P_curve.png`: Precision curve.
- `R_curve.png`: Recall curve.
- `confusion_matrix.png`: Confusion matrix depicting the model's performance.
- `events.out.tfevents.*`: TensorBoard event file for visualizing training metrics.
- `hyp.yaml`: Hyperparameter configuration used for training.
- `labels.jpg`: Image showing the distribution of labels in the dataset.
- `labels_correlogram.jpg`: Correlogram of labels.
- `opt.yaml`: Optimizer configuration used for training.
- `results.csv`: CSV file containing detailed training results.
- `results.png`: Summary of training results.
- `train_batch0.jpg`, `train_batch1.jpg`, `train_batch2.jpg`: Sample images from training batches.
- `val_batch0_labels.jpg`, `val_batch0_pred.jpg`, `val_batch1_labels.jpg`, `val_batch1_pred.jpg`, `val_batch2_labels.jpg`, `val_batch2_pred.jpg`: Validation batch images showing labels and predictions.


## Conclusion

The `yolov5s_results` directory provides a comprehensive overview of the performance of different YOLOv5s models trained with various hyperparameters and optimizers. Use this information to compare and select the best-performing model for your specific use case.

