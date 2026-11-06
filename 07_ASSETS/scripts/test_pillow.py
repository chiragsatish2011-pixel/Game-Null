from PIL import Image
img = Image.new('RGB', (64, 64), color=(128, 64, 32))
img.save('07_ASSETS/scripts/test_swatch.png')
print('Pillow test image generated successfully')
