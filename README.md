# Convolutional Neural Network - RX - Classification COVID19

## Anaconda

Descargar e instalar el ejecutable del sitio oficial: https://www.anaconda.com/download

# Comandos Anaconda

|Acción|Descripción|Comando|
|-:|:-:|:-|
|**Create Environment**|Crea un entorno virtual|`conda create --name <my-env> python=3.9.18`|
|**List Environment**|Lista los entorno virtuales existentes|`conda info --envs`|
|**Use Environment**|Selecciona y activa un entorno virtual|`conda activate <my-env>`|
|**Remove Environment**|Elimina un entorno virtual|`conda remove --name <my-env> --all`|
|**Library List**|Lista las librerías en un entorno|`conda list`|

# Paquetes instalados

Después de creado el entorno, se habrá instalado python en su versión 3.9.18

|Nombre|Versión|Comando|Verificar versión (PROMPT)|
|-:|:-:|:-|:-|
|**Tensorflow**|2.14|`pip install tensorflow==2.14`|`python -c 'import tensorflow as tf; print(tf.__version__)'`|
|**Numpy**|Last Version (1.26.4)|`pip install numpy`|`python -c 'import numpy as np; print(np.version.version)'`|
|**Matplotlib**|Last Version (3.8.3)|`pip install matplotlib`|`python -c 'import matplotlib as mpl; print(mpl.__version__)'`|
|**Pydot**|Last Version (2.0.0)|`pip install pydot`|`python -c 'import pydot; print(pydot.__version__)'`|
|**Graphviz**|Last Version (0.20.3)|`pip install graphviz`|`python -c 'import graphviz; print(graphviz.__version__)'`|
|**Scikit-learn**|Last Version (1.4.1.post1)|`pip install scikit-learn`|`python -c 'import sklearn; print(sklearn.__version__)'`|
|**Flask**|Last Version (3.0.2)|`pip install flask`|`python -c 'import flask; print(flask.__version__)'`|
