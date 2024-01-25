import os
import tifffile
import random

# Change these values as needed
TRAIN_RATIO = 0.9
IMAGE_CHANNEL = 0
MASK_CHANNEL = 1
SOURCE_FOLDER = "data"

def create_folders(source_folder, train_ratio=0.9):
    """
    Create folders for images and masks within the train and test folders.
    """
    # Define train and test folder paths relative to source folder
    train_folder = os.path.join(source_folder, 'train')
    test_folder = os.path.join(source_folder, 'test')

    # Create subdirectories for images and masks within train and test folders
    train_images = os.path.join(train_folder, 'images')
    train_masks = os.path.join(train_folder, 'masks')
    test_images = os.path.join(test_folder, 'images')
    test_masks = os.path.join(test_folder, 'masks')
    
    os.makedirs(train_images, exist_ok=True)
    os.makedirs(train_masks, exist_ok=True)
    os.makedirs(test_images, exist_ok=True)
    os.makedirs(test_masks, exist_ok=True)

    # Get list of files and shuffle them
    all_files = [f for f in os.listdir(source_folder) if f.lower().endswith('.tif')]
    random.shuffle(all_files)

    # Split the files based on the specified ratio
    split_index = int(len(all_files) * train_ratio)
    train_files = all_files[:split_index]
    test_files = all_files[split_index:]

    return train_images, train_masks, test_images, test_masks, train_files, test_files

def separate_channels(file_path, output_directory_images, output_directory_masks):
    """
    Separates the channels of a multi-channel TIFF file and saves each channel as a separate image file.
    """
    with tifffile.TiffFile(file_path) as tif:
        image = tif.asarray()

    if image.ndim == 4 and image.shape[1] == 2:
        for c in range(image.shape[1]):
            channel_image = image[:, c, :, :]
            channel_file_name = f"{os.path.splitext(os.path.basename(file_path))[0]}.tif"
            if c == IMAGE_CHANNEL:  
                output_directory = output_directory_images
            elif c == MASK_CHANNEL: 
                output_directory = output_directory_masks
            else:
                print("unexpected nr. of channels")
            channel_file_path = os.path.join(output_directory, channel_file_name)
            tifffile.imwrite(channel_file_path, channel_image)
            print(f"Saved channel {c} to {channel_file_path}")
    else:
        print(f"Unexpected image dimensions for file {file_path}")

def process_file(file_path, output_directory_images, output_directory_masks):
    """
    Process a single file and save its channels to the specified directories.
    """
    if file_path.lower().endswith(".tif"):
        separate_channels(file_path, output_directory_images, output_directory_masks)

def main(source_folder):
    """
    Process TIFF files from the specified source folder and separate their channels.
    """
    train_images, train_masks, test_images, test_masks, train_files, test_files = create_folders(source_folder)

    if os.path.isdir(source_folder):
        # Process train files
        for filename in train_files:
            process_file(os.path.join(source_folder, filename), train_images, train_masks)
        
        # Process test files
        for filename in test_files:
            process_file(os.path.join(source_folder, filename), test_images, test_masks)

        print('Processing Complete. The channels have been separated successfully!')
    else:
        print('Error: Please provide a valid source directory.')

if __name__ == "__main__":
    main(SOURCE_FOLDER)
