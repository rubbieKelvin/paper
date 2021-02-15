"""
checklist mananger
"""

import os
import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQuickControls2 import QQuickStyle
from PySide6.QtQml import QQmlApplicationEngine

from importlib import metadata as importlib_metadata

# qml plugins
# from .lib.qjsonstorage import QmlJSONStorage
# from .lib.qjsonstorage import QmlEncryptedJSONStorage
from .lib.qjsonstorage import QmlEncryptedJSONStorage6

# Find the name of the module that was used to start the app
app_module = sys.modules['__main__'].__package__

# Retrieve the app's metadata
metadata = importlib_metadata.metadata(app_module)

# define the project root for recource purposes
# for packging, resources will be saved as python byte code
root = os.path.dirname(__file__)
home = os.path.join(os.environ.get("HOME"), metadata.get("App-ID"))
if not os.path.exists(home):
	os.mkdir(home)


# paper engine
class Paper(QQmlApplicationEngine):
	def __init__(self):
		super(Paper, self).__init__()

	def init_ui(self):
		self.load(
			os.path.join(root, "resources", "source", "app.qml")
		)


def main():
	app = QGuiApplication(sys.argv)
	app.setApplicationName(metadata.get("Name"))
	
	QQuickStyle.setStyle("Fusion")
	QmlEncryptedJSONStorage6.DICTIONARY = {"$apphome": home}

	engine = Paper()
	encryptedStorage = QmlEncryptedJSONStorage6()
	encryptedStorage._key = 26

	engine.rootContext().setContextProperty("encryptedStorage", encryptedStorage)
	engine.init_ui()

	sys.exit(
		app.exec_()
	)
