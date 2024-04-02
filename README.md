# User-Guide for 3D Organoid Segmentation

[![PyPI version](https://badge.fury.io/py/stardist.svg)](https://pypi.org/project/stardist)
[![Anaconda-Server Badge](https://anaconda.org/conda-forge/stardist/badges/version.svg)](https://anaconda.org/conda-forge/stardist)
[![Test](https://github.com/stardist/stardist/workflows/Test/badge.svg)](https://github.com/stardist/stardist/actions?query=workflow%3ATest)
[![Test (PyPI)](https://github.com/stardist/stardist/workflows/Test%20(PyPI)/badge.svg)](https://github.com/stardist/stardist/actions?query=workflow%3A%22Test+%28PyPI%29%22)
[![Image.sc forum](https://img.shields.io/badge/dynamic/json.svg?label=forum&url=https%3A%2F%2Fforum.image.sc%2Ftags%2Fstardist.json&query=%24.topic_list.tags.0.topic_count&colorB=brightgreen&suffix=%20topics&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAABPklEQVR42m3SyyqFURTA8Y2BER0TDyExZ+aSPIKUlPIITFzKeQWXwhBlQrmFgUzMMFLKZeguBu5y+//17dP3nc5vuPdee6299gohUYYaDGOyyACq4JmQVoFujOMR77hNfOAGM+hBOQqB9TjHD36xhAa04RCuuXeKOvwHVWIKL9jCK2bRiV284QgL8MwEjAneeo9VNOEaBhzALGtoRy02cIcWhE34jj5YxgW+E5Z4iTPkMYpPLCNY3hdOYEfNbKYdmNngZ1jyEzw7h7AIb3fRTQ95OAZ6yQpGYHMMtOTgouktYwxuXsHgWLLl+4x++Kx1FJrjLTagA77bTPvYgw1rRqY56e+w7GNYsqX6JfPwi7aR+Y5SA+BXtKIRfkfJAYgj14tpOF6+I46c4/cAM3UhM3JxyKsxiOIhH0IO6SH/A1Kb1WBeUjbkAAAAAElFTkSuQmCC)](https://forum.image.sc/tags/stardist)
[![PyPI - Downloads](https://img.shields.io/pypi/dm/stardist)](https://pypistats.org/packages/stardist)

## Introduction
This tutorial guides you through the process of training a deep learning model for 3D organoid segmentation. You will learn how to prepare your data, train your model, and predict segmentation masks using the Stardist 3D demo model.

## Prerequisites
- Download and install Python 3.6 - 3.11 (Recommended version [Python 3.10.9](https://www.python.org/downloads/release/python-3109/).
- Use default settings (see Non-optional python features below) and add python to PATH during setup.
- Clone the repository (Green code button then download zip) [download link](https://github.com/JTaal/3D_Image_Segmentation.git)

## Non-optional Python Features

![image](https://github.com/JTaal/3D_Image_Segmentation/assets/71385957/5e8b6912-38bb-4512-bcc0-c555316c95e4)

- [x] **Add python.exe to PATH** 100% do this, the scripts will not be able to find python otherwise.

- [x] **Documentation**
  _Installs the Python documentation file._

- [x] **pip**
  _Installs pip, which can download and install other Python packages._

- [x] **tcl/tk and IDLE**
  _Installs tkinter and the IDLE development environment._

- [x] **Python test suite**
  _Installs the standard library test suite._

- [ ] **py launcher** [ ] _for all users (requires admin privileges)_
  _Installs the global 'py' launcher to make it easier to start Python._



## Setup (windows)
1. Use `start.bat` from the repository

## Setup (Linux/Unix-based)
1. **Create the Executable:**
   Before running the script on Linux or Unix-based systems (like MacOS), you need to make it executable.
   ```
   cd 3D_Image_Segmentation
   chmod +x setup.sh
   ```

2. **run the script**
   Simply type `./setup.sh` in the terminal to execute


## Running the Notebooks
After setting up your environment using `start.bat`, run the Jupyter notebooks in the following order:

### 0_dataprep.ipynb
- Splits the 2 channel image stacks into individual files for fluorescent images and ground truth masks. Also splits the data into training and testing according to the TRAIN_RATIO. Set TRAIN_RATIO = 1 if you don't want to split the training data.

### 1_data.ipynb
- Processes the prepared data for training.

### 2_training.ipynb
- Trains the deep learning model with the configuration provided. Also splits the training data before training.

### 3_prediction.ipynb
- Validates the trained model using a set-aside image-mask pair.

![image](https://github.com/JTaal/3D_Image_Segmentation/assets/71385957/cb9b4ea2-5071-453f-bb7d-aa853ee3837e)

## Training Configuration
- For an average computer, use the following parameters for ~1-4 hours of training time:
  - `grid = (1,4,4)`
  - `train_patch_size = (24,256,256)`
  - `train_batch_size = 2`
  - `train_epochs = 25`
  - `train_steps_per_epoch = 50`
- For a less powerful computer, use the following parameters for ~30min-1 hour of training time:
  - `grid = (1,4,4)`
  - `train_patch_size = (24,128,128)`
  - `train_batch_size = 2`
  - `train_epochs = 20`
  - `train_steps_per_epoch = 50`
- Ensure `quick_demo` is set to `False` for a full training experience.

## Support
**In case of problems or questions, please first check the list of [Frequently Asked Questions (FAQ)](https://stardist.net/docs/faq.html).**

**The official documentation is on [Stardist Github](https://github.com/stardist/stardist/blob/master/README.md)**

**Integrate Stardist with your current analysis software [GUI support](https://github.com/stardist/stardist/blob/master/README.md#plugins-for-other-software)**


